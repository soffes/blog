---
cover_image: 3D05430x2S0C3J3H261f1Z1m1O0Y2g3n.jpg
---

# Tearing Up the Carpet

Someone [asked](https://twitter.com/d0tio/status/348519355136479232) what [Markdown](http://daringfireball.net/projects/markdown) parser we use for [Roon](http://roon.io). ==Roon uses [Redcarpet](https://github.com/vmg/redcarpet).==

I figured it was worth expanding a bit about this though. Mainly two things Roon does that's sorta unique made possible by the fabulous Redcarpet folks.

## Underline

We have _underline_ support. As far as I know, we are the only people that support this right now. Here's how you write it:

    You can underline like _this_. This is still *italic*.

This is made possible by a feature [I contributed](https://github.com/vmg/redcarpet/pull/227). From the Markdown spec:

> Markdown treats asterisks (*) and underscores (_) as indicators of emphasis. Text wrapped with one * or _ will be wrapped with an HTML `<em>` tag…

We figured why not treat `_this_` as underline since it's still emphasis. That way we didn't stomp on other Markdown things. The Redcarpet folks liked my patch at graciously merged it!

So most of Redcarpet is written in C. I am really bad at C. I mainly write Ruby and Objective-C (which is a lot different than plain C). I was way proud of myself for writing some passable C code.

## Highlight

Something I've been doing for awhile is ==highlighting important parts of my blog posts==. A few people call this my signature move. I'll gladly take credit, but I started doing this after I saw 37signals do this on their Basecamp marketing site years ago. (They don't any more).

Anyway, I just made `<em>` be a highlight instead of italics on my blog. Since people using Roon probably want actual italics instead of everything being highlighted, we need to build something.

Drew and I came up with `==this==` for highlight. From Markdown's spec:

> A Markdown-formatted document should be publishable as-is, as plain text, without looking like it’s been marked up with tags or formatting instructions.

I picked `==` since it's very easy to see and makes the text stand out. I think this fits in well with Gruber's original intent.

I scratched my neckbeard, busted out some C, and [added support to Redcarpet](https://github.com/vmg/redcarpet/pull/263) for highlight. Again, the fantastic Redcarpet folks accepted my patch. ==Now Roon has highlight.==

Since we invented the syntax for both of these, I doubt many other people are using it yet. That said, you totally can since it's in Redcarpet! Here's now:

Add this to your Gemfile:

``` ruby
gem 'redcarpet', github: 'vmg/redcarpet'
```

Then parse some Markdown like this:

``` ruby
md = Redcarpet::Markdown.new(Redcarpet::Render::HTML, highlight: true, underline: true)
md.render('This is ==highlighted== and this is _underlined_')
#=> "<p>This is <mark>highlighted</mark> and this is <u>underlined</u></p>\n"
```

Enjoy!
