+++
title = "Have you checked your backup today?"
date = "2017-02-02"
draft = false
tags = ["GIT", "GitLab", "backup", "healthchecks.io"]
+++

This day is different from the others, because the World knows now that even [service like GitLab](https://about.gitlab.com/) doesn't have a proper setup for backups. Usually you don't need backups until you remove 300 gigabytes of a production data and that's why it's hard to make them right. There is very little space for mistakes. I am not enjoying this, I know how hard is to setup something like backup and there is no universal tutorial for this. It's even harder with their amount of data. What happened to GitLab is sad and I am feel sorry for them, but let's use their problem as a source of inspiration for ourselves. Have you checked your backup today?

![GitLab logo](/post/2017/backup2.png)

If your service is growing and it's in some kind of golden age (no data loss yet), you don't need anything like backup. Everybody knows they need it, but nobody will do it and it's moving forward in ToDo lists in regular basis. Then the day comes and you or your customer have deleted something important or you have encountered a hardware failure. It happens, we are just people and machines are just machines. Now it's the time for the least important thing in the ToDo list. You try to find anything whats left from your data on backup server and this is the place where stories usually goes into different directions:

* You have the backup
* You have the backup but in wrong backup service
* You have the backup, but it is old
* You have the backup, but not for all of your data
* You don't have any backup, but you have found an old copy in your local hard drive
* You don't have any backup

You should learn from other people's mistakes and go for the first way. You should have the data and the way how to recover your production from them. It's the best option.

I have a lot of experience in this. I lost some data. Not my personal data, but my customers data. Usually, with one exception, I was lucky, I always found it somewhere. It's always hard to tell client you can't recover his data and it's even worse when you are responsible for the loss. Have this in your mind when you will move your backup solution or fix to another day.

From last hardware failure I spend a lot of time in backup solution for Roští and I have these hints you can inspire from:

* Choose the right solution for your case
* Have the infrastructure in something like Ansible or at least set of scripts
* Refuse to backup anything you don't know
* Use Docker
* If you are not going to buy a commercial solution, keep your backup scripts simple
* Notify yourself about any backup failure
* Backup everything
* Try to recover something time to time
* Communicate

The world is not perfect and you should be ready to deal with that. Imagine this situation. Somebody has just deleted a 300 GB of data from the company's database and the only backup is in Glacier. You can send them all to home, because it will take a lot of hours to recover all data, maybe even days. Especially if you use a tool which makes incremental backups.

I want to say, even if you have a copy of all you data, you should know how much time is needed to recover all of them. Wrong solution could lead into days of downtime and it's not good for any business. Don't swap archiving tools like Glacier or C14 for backup services. Usually it's important to have the backup available in no time. That's why combination of multiple tools is not a bad idea.

Sometime with hardware failure, you loose also complete setup of your server. In this case you need to be able to recover the server fast before you can copy data backup there. Ansible and Docker are great tools for this task. Make sure you know how to use them and have a documentation for them. They are both very complex tools and if you won't use them for one year, you won't remember how to install anything. Simple README can safe a lot of time.

Docker moves part of the server effort to developers and creates a standard environment for you and your backups. If you use it, the final backup solution is slightly easier to make.

Every line of code you won't write into the backup script is a good line. The whole Roští is backed up by three scripts and each has around 50 lines of BASH code.

Alway notify yourself about the backups. You can use, for example, [healthchecks.io](healthchecks.io) service for monitoring all of your scripts. It will notify you when the script wasn't finished in time.

It's always better to backup more data than less data. I encountered a situation during hardware failure. We had the data, but we hadn't crontabs and this crontab was really huge. It was hard to persuaded that client he should stay with us after this accident. From this time we backup all filesystems on all servers including the system files.

It's good to try recover one or two backups time to time. It's really time consuming and you need resources like test servers to perform it properly. To be honest, I don't do this, but it's better to do it at least once or twice.

![GitLab's status Twitter account](/post/2017/backup1.png)

And the last and the most important thing is communication. You have to tell to your users what are you doing and how long it will take. It doesn't have to be precise, but it's always good to say something and say it often. I don't have to describe this much, because GitLab team showed to all of us how to deal with the communication. They had [their document](https://docs.google.com/document/d/1GCK53YDcBWQveod9kfzW-VCxIABGiryG7_z_6jHdVik/pub) with all details and timeline and they used their [status Twitter account](https://twitter.com/gitlabstatus) for regular updates of the recovery process. The number of clients you will have after you solve the disaster depends on the communication.

I can talk about backup stories even more, but let's end it here and go to check your backups. Mine are OK :-)


