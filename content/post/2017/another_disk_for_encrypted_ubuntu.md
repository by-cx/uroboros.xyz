+++
tags = ["ubuntu", "encryption", "howto"]
draft = false
date = "2017-02-12"
title = "How to add another disk into the root of the encrypted Ubuntu"

+++

Manipulation with encrypted root (/) partition of your Ubuntu is not exactly a seamless task which you would like to do everyday. There is one special case which can't be covered by standard documentation. You can find tutorials and documentation for expanding your root partition even when it's encrypted, but in my case, I had to add a new hard drive to expand it with a new space. If you have installed your encrypted Ubuntu without any custom changes during the installation process, it is installed in LVM which is in encrypted partition of your hard drive. Inside the LVM, there are only two partitions - root and swap and not much a free space left.

Let's look at it:

    cx@bimbo ~ [1]> sudo lvs
      LV     VG        Attr       LSize   Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert
      root   ubuntu-vg -wi-ao---- 201,33g
      swap_1 ubuntu-vg -wi-ao----  19,96g

I have nothing unusual in my Ubuntu so if you installed it like me, with default configuration, it should look very same. There are two logical volumes in *ubuntu-vg* volume group. All of this was in one 120 GB SSD. I had another spare SSD (also 120 GB) and wanted to use it to expand my root logical volume. It's not hard, but I spend some time trying to figure out how to boot from it. At the end I found a solution with a simple script in */etc/initramfs-tools/scripts/local-top/*.

## Backup everything

Let's assume, you have same drive set like me:

* sda - new SSD
* sdb - old SSD
* sdc - HDD with data

I will count on this in rest of the post. Please adjust *sdX* with values from your system.

It's important to backup everything. For that you can use *dd*:

    dd if=/dev/sdb bs=16M of=/mnt/your_data_hdd/sdb.img

If anything goes wrong, call this to recover:

    dd if=/mnt/your_data_hdd/sdb.img bs=16M of=/dev/sdb

## Partitioning

The new SSD should have some partition table. One partition is enough and the easies way is to [use *gparted*](http://gparted.org/):

![Gparted with encrypted partition](/post/2017/luks_gparted_1.png)

![Gparted with encrypted partition](/post/2017/luks_gparted_2.png)

You can also use *parted* in your command line:

    cx@bimbo ~ [1]> sudo parted /dev/sda
    GNU Parted 3.2
    ...
    (parted) p
    Model: ATA Samsung SSD 850 (scsi)
    Disk /dev/sda: 128GB
    Sector size (logical/physical): 512B/512B
    Tabulka oddílů: msdos
    Disk Flags: 
    
    Číslo  Začátek  Konec  Velikost  Typ      Systém souborů  Přepínače
     1     1049kB   128GB  128GB     primary

*(Sorry for the Czech in the example.)*

## Encrypting of the new partition

This step is easy, call:

    cryptsetup luksFormat /dev/sda1

And put there a password. We will use password, because this is a part of the root partition and it's not possible to unlock it with key saved into different partition. Not need for the key then.

## Setup initramfs and crypttab

The [initramfs](https://en.wikipedia.org/wiki/Initramfs) is a base image of the system which boots your main system. It's something like recovery mode, but it's used for basic setup of your computer in initial phase of the booting process too. It's saved in */boot* and it's not encrypted. This is the weakest spot in the whole Ubuntu encryption setup and it's not easy or even possible to solve it. The attacker can update your *initramfs* to gather the encryption key and then he can use it to access your data. But it's not theme for this post.

Let's add a new line into */etc/crypttab*. After that, the file should look like this:

    sda5_crypt UUID=2b505a9e-a562-4018-b23a-b33c6211b512 none luks,discard
    sdb5_crypt UUID=ca4db582-f415-4fb9-b956-fc8b99447f64 none luks,discard

The first column contains name of the virtual unencrypted block device. You can find it in */dev/mapper* if decryption setup is success. UUID doesn't need any explanation. *None* means no keys for this device. *Luks* is encryption type and discard passes TRIM into the backend device (your SSD) and you don't need it if the drive is HDD.

If you don't know how to find the UUID of your partitions, use *blkid*:

    cx@bimbo ~> sudo blkid 
    /dev/sda1: UUID="ca4db582-f415-4fb9-b956-fc8b99447f64" TYPE="crypto_LUKS" PARTUUID="4d968862-01"
    /dev/sdb5: UUID="2b505a9e-a562-4018-b23a-b33c6211b512" TYPE="crypto_LUKS" PARTUUID="4614e44c-05"

Then you can add the script into the *initramfs's* configuration directory. The right place is in */etc/initramfs-tools/scripts/local-top/crypt* file and the content should look like this:

    #!/bin/sh
    
    PREREQ=""
    
    prereqs() {
            echo "$PREREQ"
    }
    
    case "$1" in
            prereqs)
                    prereqs
                    exit 0
            ;;
    esac
    
    cryptsetup luksOpen /dev/sda1 sda1_crypt
    vgscan
    vgchange -a y

Last three commands unlocks our new drive and, *vgscan* finds the *ubuntu-vg* and *vgchange* activates it in the system. Everything before is mandatory header and it's similar to other scripts in *initramfs*.

This is not a clean way how to do it. It's probably possible to use *cryptroot*, mentioned for example [https://help.ubuntu.com/community/EncryptedFilesystemHowto4](here), but I didn't find a solid documentation so I used the way with a minimal effort required.

We are almost done, let's call this now:

    update-initramfs -u -k all

It updates all already created *initramfs* images in your system and the new images will contain this new unlock script.

## Add the new drive to the volume group and extend the root logical volume

Now it's the best time for reboot. If anything goes wrong you can still boot back to your system and fix it. If you do the extending now without knowing it's ok, you'll stay in *initramfs* during the booting. It still possible to boot then but it requires manual intervention in *initramfs's* shell.

At first we have to extend the volume group:

    vgextend ubuntu-vg /dev/mapper/sda1_crypt

Then we can check the remaining space:

    cx@bimbo ~> sudo vgs
      VG        #PV #LV #SN Attr   VSize   VFree
      ubuntu-vg   2   2   0 wz--n- 230,55g 9,26g

It's the last column.

Now you can create a new logical volumes, for example for log files or your new home or you can extend the root logical volume like me:

    cx@bimbo ~> sudo lvextend -L + 100G /dev/ubuntu-vg/root 
    cx@bimbo ~> sudo resize2fs /dev/ubuntu-vg/root

The *resize2fs* is tool developed for ext4 filesystem. Use the right tool for your filesystem if it's not ext4.

Now it's another good time for reboot and check if everything is ok. There is one disadvantage for this setup, you have to put your password twice during the boot. I don't do that much, twice or three times a month so it's not exactly disadvantage for me, but you should know about that.

Good luck and if you have a better setup, for example for *cryptroot*, let me know in comments. I think others will find it useful too.



