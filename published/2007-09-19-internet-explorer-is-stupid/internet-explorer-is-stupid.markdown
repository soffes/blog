# Internet Explorer is Stupid

This is retarded. I’m going to complain for a minute here. To be valid XHTML1.1, you need to make your content type `application/xhtml+xml`. By default the content type is `text/html` which isn’t valid XHTML1.1. In Internet Explorer, it doesn't know what to do with the `application/xhtml+xml` content type and asks the user to download it. WHY!? That is so dumb. Why does Microsoft refuse to listen to web standards? I do not understand. There is an easy work around for this, but that is dumb that this has to be done.

``` php
if (isset($_SERVER["HTTP_ACCEPT"]) && !(stristr( $_SERVER["HTTP_ACCEPT"], "application/xhtml+xml"))) {
    header ("Content-type: text/html");
} else {
    header ("Content-type: application/xhtml+xml");
}
```

While we’re complaining, why doesn’t IE6 not display PNGs when it can? You can hack it to display them (with this [clever script](http://www.twinhelix.com/css/iepngfix/)). It's so annoying. This is why [samsoffes.com](http://samsoffes.com) will not be supporting IE6. I give up.

**Update:** I can’t get it to validate now. I need to do some work on that little piece of code.

**Update:** Fixed. The validator doesn’t send the `$_SERVER["HTTP_ACCEPT"]` variable because it‘s just a script obviously. I updated it the code above to reflect my changes. Enjoy.
