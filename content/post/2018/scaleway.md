+++
title = "Scaleway, 18 months of experience"
draft = false
date = "2018-02-03T20:00:00Z"
tags = ["servers", "scaleway", "cloud"]
+++

Finally, I have created a plan for leaving ScaleWay. Super progressive cloud project focused on price. It's not like it would be a bad service, it's just not what I expected more than year ago. Let's look back to what happened with Roští.cz while it was hosted on Scaleway.

October 17, 2016, I was playing with Scaleway and after some testing, I had created a new database and node server for Roští there. All new servers were hosted there without any issue next eleven months. I was surprised, because the service was really cheap and I was pretty doubful about it.

When rest of our infrastructure moves there in September 2017 it was a week before my holiday. I left my colegue to deal with company stuff, but servers were mine and I was only one in the company who could fix anything serious. So far we had only our own servers in datacenters and it's pain in the ass. Every time something goes down, you have to go there. It's not everyday, but usually it's unexpected.

So I wanted to move everything important into Scaleway before I leave the office. When we left the country, a few days later first problems occurred. One of our servers went down because of backend storage issue. I haven't found the true reason for this issue and support was very, very unhelpful. The server was down for a few hours and I thought the support will solve it. But in Scaleway, if something happens outside of Mon-Fri 8:00-17:00 you are on your own. It was Friday evening, they left the server down for two days and long before it's was up again I had to recreated it from our backups. It was horrible experience, especially the support. We could live with the downtime, but lack of support when this is happening is unforgivable.

We paid also for their phone support and when I called there they told me exactly the same as in the written ticked in the admin interface. As a result of this, we canceled the support package, it was useless.

At first I thought it's just a single problem because it was fine for last twelve months. But it was a mistake. It happened again and then again and then again in January this year with our admin interface and the main database.

Because of this issue we were able to recover from the backups in one or two hours - as fast as the data are copied, but it was painful and we had to deal with that. Our reputation was severly damaged and we lost a few of our very important clients and if we hadn't be so unique on this market, I am sure we would lost more than a few of them. Scaleway support was saying same thing over and over - there was no solution on our side and it was fixed on their side. No details at all.

This year, DigitalOcean cut down prices for their droplets and it wasn't hard decision to move all our servers there. We should have done this a long before, into Vultr or similar service. Scaleway is the best operator for applications which can survive randomly crashing servers. If your app has a good design, you can save a lot of money in Scaleway. But if you depend on single points of failure, or even more than one, just go some where else.

My experience is [not unique](https://github.com/scaleway/image-ubuntu/issues/87) and it looks like it's related to kernel, but I think the linked GitHub issue is just a rumore born from the lack of communication.

Maybe even bigger issue in last six months has been lack of available servers. Low stock or temporary out of stock is one of my favourite underline note when one of our servers is failing.

We will keep one machine in Scaleway, it's our service machine with tools like webmail or Grafana. Moving of everything important to DigitalOcean has already started and it will be finished next week. Maybe I will have a pieceful holiday next year.


