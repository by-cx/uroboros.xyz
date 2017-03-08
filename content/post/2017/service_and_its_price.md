+++
tags = ["services", "price"]
draft = false
date = "2017-03-08T00:51:51+01:00"
title = "Service and its price"

+++

I had pretty unpleasant phone call on Monday. One of application on our server had a trouble. It ate all RAM and the server froze. We couldn't prevent this situation, because multiple applications share this server and the memory load was inside the Apache which is shared and it's hard to find what is wrong exactly. But it's not the interesting part.

We are only servers provider and we don't care much what users have on our servers. If they want we can tell them what to do to run their code faster or more reliable but this was service for 2 euros/month so there is not much space for doing anything on our side of the system.

This server is completely dedicated to one user and he has web sites for multiple clients there. Each website is 2 euros per month for us. What was my surprise when one of his client was calling me why is their eshop so slow. Server with his application was completely ok, database too. The problem was probably caching which had been disabled a few days ago by the developer. That guy was pretty aggressive and he told me how many thousands euros his income is and how much he paid for his machines. It was hard to be assertive and it's hard to resolve anything with guy in this stage of angriness. The only thing you can do is to be calmed, tell the facts and repeat them if it's necessary. The main goal for conversation like this is not to solve the problem, but end the call peacefully. People like this argue with a lot of money and other unimportant nonsense when they are desperate or scared and there is very little space for moving forward. It's like rat in a corner.

After this call, I wait a few tens of minutes, because it was really stressful and I am not used to it. I don't hear things like this everyday. After all of this I wrote him an email with simple explanation. I used more diplomatic way, but at the end, the message was clear. If you pay 2 euros per month, you can't expected high available solution with 24/7 support for the application of this size. This guy has eshop with thousands euros income each day and he was surprised there could be some performance problems.

This is really common problem. We have multiple sites like this on our servers. They are growing, their requirements growing, but their server solution is still cheap. Then, after some trouble, they will find in hard way they don't have dedicated servers and the high available solution for their 2 euros.

With this specific guy, we had multiple problems during last six months. A few months ago we had hardware outage and the server was down between midnight til 6 am. Now we had problem with the RAM eating Apache and in last few days his eshop was slow. I am pretty sure he's not going to pay us our 500 euros for proper solution. He will go to find another cheap hosting to try his luck there. It has to be much better if it costs 5 euros instead of 2, right?

