---
layout: post
title: "Brakeman Turns Ten!"
date: 2020-08-27 08:10
comments: true
categories:
permalink: /blog/:year/:month/:day/:title
---

Hi! [Justin Collins](https://twitter.com/presidentbeef) here with a rare non-release-related Brakeman post.

On August 27, 2010 (_two days before Rails 3.0!_), I released the [first public version](https://rubygems.org/gems/brakeman/versions/0.0.2) of my summer intern project at AT&T Interactive: a static analysis security tool for Ruby on Rails called "Brakeman".

Brakeman was intended to be a stop-gap solution until commercial products started supporting Ruby. I had no idea it would take me on such a wild journey nor did I think I would still be maintaining it ten years later.

In the past ten years, Brakeman has had:

* [33+ million gem downloads](https://rubygems.org/gems/brakeman)
* [Over 9,000 dependent GitHub repos](https://github.com/presidentbeef/brakeman/network/dependents?package_id=UGFja2FnZS0yMzgzMw%3D%3D)
* [120 releases](https://github.com/presidentbeef/brakeman/releases)
* [100+ contributors](https://github.com/presidentbeef/brakeman/graphs/contributors)

I am extremely grateful to everyone who has contributed to this journey: those who took chances on me, those who supported and promoted Brakeman, those who have contributed time and code to Brakeman, those who reported bugs and suggested improvements, and everyone who has used Brakeman to make their applications safer!

Very special thanks to:

* [Tin Zaw](https://www.linkedin.com/in/tinzaw/)
* [Ryan Davis](https://www.zenspider.com/)
* [Neil Matatall](https://twitter.com/ndm)
* [Jim Manico](https://manicode.com/)
* [Alex Smolen](https://alexsmolen.com/)
* [Ken Johnson](https://twitter.com/cktricky)

Want some Brakeman FAQ nuggets? You got it!

### Where did the idea for Brakeman come from?

I recall during my internship interview at AT&T Interactive, we were talking about cross-site scripting. I distinctly recall saying, "What if we had a tool that looked at the inputs and outputs of an application and found cross-site scripting?" The response was an excited "Do you know of a tool like that for Ruby?" To which I replied, "No, but I'm sure it wouldn't be that hard to build!" This idea was later pitched back to me as a possible internship project.

By the way, that's still not how Brakeman works, but it was originally designed to find cross-site scripting.

### Who came up with the name "Brakeman"?

[Carl Johnson](https://www.linkedin.com/in/carlivar/) and [Tatsuya Murase](https://www.linkedin.com/in/tatsuya-murase-a8061/) on the security team at AT&T Interactive were way more into trains than me, and they suggested the name. There were a couple other candidates, but I thought "Brakeman" had a snappy sound to it and was unique.

### Was Brakeman your PhD research?

Nope, unrelated. However, Brakeman was released exactly at the midpoint of my PhD career.

_[Here is my dissertation](https://escholarship.org/uc/item/8md1h50q) for those interested few._

### What is up with the Brakeman logo?

It's a [brakeman lantern](https://www.google.com/search?source=univ&tbm=isch&q=brakeman+lantern) and was designed by [Janelle Lawless](http://www.nell-ux.com/).

### Do you still maintain Brakeman? Who owns it?

Yes, I am still the maintainer of the free version you see here.

The bits of Brakeman owned by Brakeman, Inc. were [sold to Synopsys](https://brakemanpro.com/2018/06/28/brakeman-pro-acquired-by-synopsys).

### Will Brakeman ever support other languages/frameworks?

Almost certainly not. It is very tailored to Ruby and Rails and I don't have time or energy to build another static analysis engine from scratch!

### Can I see a picture of you presenting Brakeman in public for the very first time?

Sure, here you go:

![Justin Collins presenting at LA Ruby Meetup October 2010](/images/Justin_LARuby_October_2010.jpeg)

### That's nice but what about blurry video of the first _conference_ talk about Brakeman?

[No problem!](https://vimeo.com/32696936)

### Okay but what I really want is a sweet Brakeman sticker.

Oh, one of these special edition ones?

![Metallic Brakeman Sticker](/images/brakeman_metal_sticker.jpg)

Email your name and physical address to stickers@brakeman.org.

### What's next?

Next is Brakeman 5.0! It would have been nice to have a release coincide with this anniversary, but alas that is way too hard to manage. No promises, but if all goes well 5.0 will be released in September.

As long as Rails continues to hang on as a solid option for many companies and individuals, I expect to continue maintaining Brakeman. The project means a lot to me and it's a privilege and responsibility I take very seriously.

We'll see what happens in the next ten years!
