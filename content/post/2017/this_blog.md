+++
title = "Server side of this blog"
draft = false
date = "2017-01-25"
tags = ["me", "Ghost", "Hugo", "Scaleway", "Golang", "Jekyll", "Ruby"]
+++

Maybe it sounds strange but I don't use my own services for hosting almost anything important. It's not like I wouldn't believe in my services, I use them for websites for my wife or my friends. I use it for its own web sites, but not for myself. It's because I usually test a new approaches and new technologies every time it's possible and I can't do it with applications of other people and my application are the best for this task.

My last blog, unfortunately written in Czech, was managed [by Ghost](ghost.org). It was a new blogging platform a few years ago. It pretty mature now but it believe me, it wasn't that time. From my perspective, it's mature project with pretty bad upgrades feature. Templates are amazing, admin interface is like from this century and it's fast as hell even without complicated plugins like, for example, Wordpress. But the only thing I didn't like on that platform were updates. Every time a new version was released I had to download it from their site and unzip it into the server. I hadn't been doing that much often and if you look [into documentation](http://support.ghost.org/how-to-upgrade/), you can see it's not something you would like to do everyday. But still. beside this "issue" the Ghost is probably the best blogging platform for ordinary people these days.

Enough about history, not there a new blog. Written in English and with a new set of technologies. At first, I decided to use some static site generator. The main reason it I don't want to care about any blogging system anymore. Static page served by simple web server is fast and it's easy to scale it up. In this case, I use these tools:

## Hugo as a generator

One of my favourite [programming language is Go](https://golang.org/). It doesn't have a nice web site or documentation (it's great, just not nice), but it's like drugged C. It statically typed compilable programming language which helps you build a new applications fast and they have a pretty amazing performance. There are a lot of projects written in Go. For example [Docker](http://docker.com/) or [Minio](https://minio.io/), but also [Hugo](https://gohugo.io/), the static page generator.

I am not able to say much about it, because I use it only a few days and the only thing I want is a simple blog. But I considered another tool for this job, [Jekyll](https://jekyllrb.com/). Compared to Hugo, Jekyll is written in Ruby by same guys who have written [GitHub](https://github.com). It great tool with a lot of possibilities, but if you have a blog with 100 posts, you'll find yourself [in long waiting procedure](https://novelist.xyz/tech/hugo-vs-jekyll-static-site-generator/) every time you want to deploy a new post to the Internet. We are not talking about tens of seconds but about minutes.

## Caddy as a web server

Another tool I use for this blog is [webserver Caddy](https://caddyserver.com/). I wanted to use it for a very long time. It's also written in Go and it's also fast as hell. Not as fast as Nginx for example, but still enough for this blog or any other page. Caddy is not like other web servers. It makes "web servering" easy. For example all I need for this page is this short config file:

	uroboros.xyz {
	    root /srv/uroboros.xyz
	    gzip
	    log /var/log/caddy/access.log {
		rotate {
			size 128 # Rotate after 100 MB
			age  90  # Keep log files for 14 days
			keep 10  # Keep at most 10 log files
	    	}
	    }
	}

And that's it. It listens on ports 80 and 443, it can obtain certificate from [Let's encrypt](https://letsencrypt.org/) and it redirects everything from HTTP to HTTPS. It also handles the access log file and of course, the serve static files from the directory with my blog.

If you ever need a simple web server, try this one.

## Scaleway as a cloud provider

And last piece of puzzle is the machine. A few months ago I found [Scaleway](https://www.scaleway.com/), a new cloud server provider with great value/price ratio. We moved here a few virtual servers in Roští.cz and after six months I can say it's great service with solid infrastructure. I can't tell anything about performance or something like that, because it's more about what your application needs than the specific number. I use their cheapest cloud server for this blog and it could run on much slower machine with same performance. All I want to tell you is if you need a cheap cloud, try this one.

## In future

I want to write here a few more blog posts, mainly focused on servers and maybe some games or electronics. But I would like to try a more advance solution like CDN or S3. We will see, maybe I will be too lazy for that :-) Have a good day.


