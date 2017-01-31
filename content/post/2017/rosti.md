+++
title = "Roští.cz"
draft = false
date = "2017-01-28"
tags = ["Roští.cz", "Scaleway", "Caddy", "Hugo", "Dropbear", "Supervisor", "hosting"]
+++

Have you heard about Roští.cz? I don't thing so, but trust me, it's a hosting service, which was intended to be a greatest hosting service in Czechia. From the Internet perspective, Roští has a long history. It was my personal project from 2010 and here is a short story about what Roští.cz actually is.

Here in Czechia, even in 2017, it's not possible to host anything else than PHP code. If you want to write application in Node.js, Python, Java, Go or anything else than PHP, you have to use your own VPS. But using the VPS means a lot of worries. You have to keep the server updated, keep your application compatible, be an database expert and if something goes wrong, you have to know what to do pretty fast.

To be honest, I am no enjoying this anymore in my projects. I don't want to host my new projects in complicated environments build ad-hoc. Sometime I try a new technology, like for this blog, but the most pages are going to Roští, because Rošti solves problems like this and it's not another hosting company, it does things differently.

From the beginning, that means 2011, Rosti has supported Python and PHP and it's pretty good in both now. Later I have added support for Node.js. A three years later I met Martin, my friend who was also very interested in Python. We founded a company called Roští.cz and we started working on a completely new system for hosting applications. In that point, Roští was transformed from project into a solid company.

The system is based on Docker. We use it like light virtual machine provider. Each application has an environment based on our based images and each image is focused to one technology like Python, PHP, Node.js, Java and Ruby. The container is part of an application. Each application is group of load balancer settings, container and databases. Inside the application you can find SSH daemon [Dropbear](https://matt.ucc.asn.au/dropbear/dropbear.html), [Supervisor](http://supervisord.org/) and a few tools every developer needs. Thanks to Docker, we can have multiple versions of all supported technologies and we can scale our infrastructure up and down as we need. After three years of development I can say we are the most advanced hosting company in Czechia.

For me personally Roští means a lot. I could test there a lot of technologies I use now. I couldn't do it in any other company and for all projects I have worked on now I can thank to Roští. At the beginning it was my sandbox and I have learned everything about Linux on servers. Roští wasn't always profitable company, but all expenses returned me in experience and indirect income very quickly. Now it's working company ready to take care for your code.
