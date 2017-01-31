+++
title = """How to care for Debian 6.0 Squeeze servers after EOL"""
draft = false
date = "2017-01-30T01:56:00Z"
tags = ["Debian", "security", "servers"]
+++

Long time ago, when Roští.cz was only a small project with a few customers, there was only one server which held everything. That server was pain in the ass from the beginning and the main reason is I tested there a lot of technologies and there is a lot of unnecessary stuff. It was a physical machine which was migrated into a virtual machine and the disk drive has been transformed from LVM layout into single partition layout.

This all means that server is full of garbage. Probably the worst part is, there is still 80 web sites running on it and all of them are tightly bound into the system. At least half of them are written in Python and Python has a lot of libraries depended on system libraries. It's hard to migrate PHP web sites to newer server, but same with Python web sites is almost impossible.

I think I can't help you with this problem. We are lucky, because this server belongs to the old administration software and it's not supported anymore. If somebody has a problem we just tell him: "it's not supported anymore and you should migrate into the new infrastructure". The infrastructure is based on Docker and truly I don't care if anybody will use unsupported system inside the container. The only ports exposed to the world are HTTP and SSH and I can live with that. But whole server with databases, DNS server, FTP server and SSH access for each user, that's a different league with much greater consequences.

We did a three things for securing the server. The main trouble is it's web hosting server and customers can run there anything. In this case, nothing can help us, we can only try to make it safer, but we know it won't be enough in case of direct assault.

## Archive

If you haven't touch that server for a long time, you will need following lines inside the */etc/apt/sources.list* file.

    deb http://archive.debian.org/debian squeeze main
    deb http://archive.debian.org/debian squeeze-backports main
    deb http://archive.debian.org/debian squeeze-lts main

If rest of the content in this file and in the files inside */etc/apt/sources.list.d/* directory is not yours, then you can remove it. It won't work probably.

## Upgrades

Now you should be able to install a at least packages from the official repository and download latest security upgrades from February of 2016. Do it.

    apt-get update
    apt-get upgrade

Be careful about the output from the last command. Something can be wrong. It's old system with a lot of things.

## Dirty COW

This is probably the most dangerous thing in your system if you haven't fixed it yet. The only functional way to fix it I've found is clean-cow kernel module. If you want to install it, install kernel headers first:

    apt-get install linux-headers-2.6.32-5-amd64

The module can be found [at GitHub](https://github.com/Safe3/clean-cow) and the compilation is pretty easy:

    git clone https://github.com/Safe3/clean-cow.git
    cd clean-cow
    make

The last part is add the module into booting process. For example you can add line below into the */etc/rc.local* file.

    insmod /PATH/TO/clean-cow/cow.ko

## Firewall

Make sure services of this server are behind firewall and they don't available from the world. Of course it's not possible for example in case of HTTP protocol or FTP protocol, but SSH or databases don't have to be seen by everybody.

I won't describe here how to deal with firewall in Linux, this post is not about it and it's pretty big area. But if this part is complicated for you, try to use any tool which makes it easy. I like [project Ferm](http://ferm.foo-projects.org/) for example. It's in official Debian Squeeze repository and it comes with reasonable default configuration (SSH only) which is easy to update to letting through other protocols.

Good luck with this. It's probably the most important part if you don't have other people's code on the server like us.

## Backup

Do backup and do it everyday with at least 90 days history. In case of compromitation of your server you need to have data to recover the service else were.

My favorite way for backuping data is using Btrfs and rsync. Let's assume we have a backup server with a lot of space and this space is managed by Btrfs. This file system support snapshot which is great way how to keep history of your files without occupying much space. In Roští we have 1 TB of data for backup everyday and copying all of it into any backup server is completely out of our options. So we use Btrfs's snapshot feature like this:

1) Copy data into backup server with rsync
2) Make snapshot of that data
3) Do it again next day

The advantage of this is, not all data are transfered everyday but only those that have been changed. The copying is pretty fast this way. Btrfs's snapshot then helps us to keep history without much additional space on top of the original data.

I will write about the whole solution later and keep backups in your hands.

## Pray

If you have implemented everything described above, it's time for praying :-) Don't thing this will solve 100 % possible problems in your server, but it gives you solid chance to survive until you figure our what to do with that old machine.


