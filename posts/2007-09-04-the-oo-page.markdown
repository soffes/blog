---
title: The OO Page
tags: [development, php, web, objective-c]
---

I love objects. Programming in Cocoa has really made me understand the power of OO (object oriented) programming. I‘ll take a minute to explain objects and MVC for a minute. (If you are familiar with objects, move to the next paragraph.) An object is a variable that has multiple variables and functions (called methods when inside an object) inside it and is an instance of a class. A class is some code that tell the object what it can do. One very popular approach to using objects (or just programming in general) is the MVC method (model, view, controller). Each of the elements of a MVC are usually objects too.

In my simple [web site](http://samsoffes.com), I use [CodeIgniter](http://codeigniter.com), which is an open-source PHP framework that makes OO PHP easier and quicker, to run things. I have created several libraries (or classes) to take more work from me and moving it to my libraries. The ones I use the most are Page, Sidebar, and Widget. For the first time in PHP, I have used multiple instances of the same class on the same page. In CodeIgniter, this isn't done that often because you rarely have to, but I decided it would be fun, so I am.

My Page object is my page. It creates my `<head>` tag, page template, and assembles the rest of my views. One of it‘s views is the sidebar of course. The sidebar is also an object that contains an array (think of it as a list if you don‘ know what it is) of widgets which are also objects. After adding all of my widgets to my sidebar, the page objects asks for the final HTML version of it when it‘s ready to display the page. Inside each sidebar widget, there are several methods for manipulating how it looks and acts too.

This is quite complex, so instead of just talking about all of my objects, methods, and variables, heres a diagram:

I love this way of programming because it keeps the code in the controllers and view very short and tidy. If you want to know more or if you want to get your hands on the source code, email me on the [about](http://samsoffes.com/about) page.
