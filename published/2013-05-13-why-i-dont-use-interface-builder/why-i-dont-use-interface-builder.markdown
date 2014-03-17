---
cover_image: 0V401Y2B1f3h391m3x1A303N1g3Q1b3n.jpg
---

# Why I Don't Use Interface Builder

For iOS development, I don't use Interface Builder. I haven't willfully used a NIB (when I say NIB, I mean Interface Builder file, not the specific format) since iOS 2.0. In the past, I've worked with a few folks that really liked using Interface Builder. This is an argument I've had over and over.

Instead of mindlessly arguing on one side or the other of this, here's my go to points when I'm trying to win someone over.


### Choosing Explicit over Implicit

Choosing to be explicit is my number one reason to do things in code instead. If someone new to the team opens up a view or view controller, they can see right away where everything is and not have to wonder if this file has a NIB.

I have spent countless hours searching for the source of a bug only to discover it's some checkbox in one of the half dozen inspectors in Interface Builder. If it was in code, it's simple to glance at the view code and see the source of the problem much quicker.

### Tight Coupling

It is much harder to use Interface Builder for reusable views. I constantly create little views and reuse them all over the place. That's kind of the point of working in an object-oriented environment. If you use Interface Builder and have outlets and forget to connect the outlet in the second place you use it, you crash at runtime. ==This is terrible.== This introduces a whole new class of bugs.

Now we have this thing that crashes simply because we're using Interface Builder instead of using code. If it was the exact same thing in code, it wouldn't crash. Even worse, the compiler can check this for you.

Not to mention, if you use lots of custom views, your NIBs will just be a bunch of invisible boxes. So now you have this tight coupling that is even harder to work with if you were to just lay it out in code.

Have you ever sat staring at some code wondering why it's not working on to realize you didn't connect the outlet or action? I hate that.

### Working With Others

Have you ever had a merge conflict in a NIB. It's the worst. (Granted the XIB format has helped, but it's just awful instead of impossible now.) If you're working in a large application with several developers, you will waste an enormous amount of time dealing wit this issue.

The worst part is if it gets automatically merged wrong, you might not notice until runtime. With code, you can read the diff and understand what's happening. NIBs (in either format) are not  human readable. This also makes looking at the history of a file useless. If it was code, it's just Objective-C. We're good at that.

### It's Part of Xcode

This used to be more of an issue, but I think it's still worth mentioning. To put it lightly, Xcode is not the most stable piece of software in the world. The text editing part works pretty well. Every time I get a crash while editing a NIB, I grumble to myself and wish it was code even more.

The less I have to use Xcode for more than anything except a text editor with completion and a compiler, the happier I am.

### Location, Location, Location

Layout code is not hard. Auto-layout is a bit more code than traditional layout, but it's still not bad. Trying to work with auto-layout in Interface Builder is maddening. Setting outlets to control built-in constraints is just silliness.

It's so simple to just override `layoutSubviews` and do your thing. Personally, I find this much easier to work with than auto-layout for most things.

I think this is a lot of people's biggest fear is working with layouts in code. Once you get the hang of it, it's so simple. Making your app universal becomes much more tribal than making separate NIBs for iPhone and iPad. You can simply reuse your code instead of create this tight coupling.

### Bottom Line

Interface Builder itself is not bad. It does encourage bad practices, prevent reusability, make working with others more difficult, and slow your workflow. Personally, I avoid using Interface Builder (including storyboards) as much as possible. All of the projects I've worked on since 2009 haven't had NIBs unless it was out of my control.

I think you should save yourself some time, learn a few things, and start moving to code. We are programmers after all.


**Update:** not to mention localization. It's a huge pain with IB. You end up making connections to everything. So much easier to do in code.
