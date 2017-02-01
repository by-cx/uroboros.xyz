+++
title = "Have you checked your backup today?"
date = "2017-02-01"
draft = true
+++

This day is different from the others, because the World knows now that even service like GitLab do not have a proper setup for backups. Usually you don't need backups until you remove 300 gigabytes of a production data and that's exactly why GitLab needed them. I am not enjoying this, I know how hard is to setup something like backup and there is no universal tutorial for each case. What happened to GitLab is sad and I am feel sorry for them, but let's use it as a source of inspiration for ourselves. Have you checked your backup today?

If your service is growing and it's in some kind of golden age (no data loss yet), you don't need anything like backup. Everybody knows they need it, but nobody will do it and it's moving forward in ToDo lists in regular basis. Then the day comes and you or your customer have deleted something important or you have encountered a hardware failure. It happens, we are just people and machines are just machines. Now it's the time for the least important thing in the ToDo list. You try to find anything whats left from your data on backup server and this is the place where stories usually goes into different directions:

* You have the backup
* You have the backup but in wrong backup service
* You have the backup, but it is old
* You have the backup, but not all of the data
* You don't have any backup, but you have found an old copy in your local hard drive
* You don't have any backup

You should learn from other people's mistakes and go for the first way. You should have the data and the way how to recover your production from them. It's the best option.

I have a lot of experience in this. I lost some data. Not my personal data, but my customers data. Usually, with one exception, I was lucky. It's always hard to tell client you can't recover his data and it's even worse when you are responsible for the loss. Have this in your mind when you will move your backup solution to another day.

From last hardware failure I spend a lot of time in backup solution for Roští and I have these hints you can inspire from:

* Choose the right solution for your case
* Have the infrastructure in something like Ansible or at least set of scripts
* Refuse to backup anything you don't know
* Use Docker
* If you are not going to buy a commercial solution, keep your backup scripts simple
* Notify yourself about any backup failure
* Try to recover something time to time

The world is not perfect and you should be ready to deal with that. Imagine this situation. Somebody has just deleted a 300 GB of data from the company's database and the only backup is in Glacier. You can send them all home, because it will take a lot of hours to recover all data, maybe even days. Especially if you use a tool which makes incremental backups.

I want to say, even if you have a copy of all data, you should know how much time is needed to recover all of them. Wrong solution could lead into days of downtime and it's not good for any business. Don't swap archiving tools like Glacier or C14 for backup services. Usually it's important to have the backup available in no time. That's why combination of multiple tools is not a bad idea.

Sometime with hardware failure, you loose also complete setup of your server. In this case you need to be able to recover the server fast before you can copy data backup there. Ansible and Docker are great tools for this task. Make sure you know how to use them and have documentation for them. They are both very complex tools and if you won't use them for one year, you won't remember how to install anything.


