# Sidebar Widgets

Today I've been messing with my sidebar a little more. I really like the new [Digg Widgets](http://web.archive.org/web/20071014203346/http://digg.com/add-digg), but I was having trouble styling them the way I wanted.

**Solution:** write my own. I figured why not. I've been messing with PHP5's xml classes and thought it would be fun. (Notice [http://samsoffes.com/rss](http://web.archive.org/web/20071014203346/http://samsoffes.com/rss) written entirely in PHP5's [`SimpleXML`](http://www.php.net/simplexml/) class.) After struggling to open an external file with file_get_contents(), I resorted to using [cURL](http://curl.haxx.se/)...

``` php
// My feed from http://digg.com/users/samsoffes
$feed = 'http://digg.com/rss/samsoffes/index2.xml';

// Use cURL
$xmlstr = shell_exec('curl '.$feed);

// Create and SimpleXML object
$xml = new SimpleXMLElement($xmlstr);

// Add the Digg XML name space
$xml->registerXPathNamespace('digg', 'http://digg.com/docs/diggrss/');
```

It works well. I had some problems grabbing the digg count and had to use `xpath()`. The `xpath()` method of the `SimpleXML` class [always returns an array](http://www.php.net/manual/en/function.simplexml-element-xpath.php). This is very annoying when you would expect it not to return an array if you only get one result.

Anyway, what I love about OO PHP is that I can put

``` php
$widget->addCSS('myStyleSheet');
```

and it will add it to the header for me. If I remove the widget from the sidebar, all of it’s css and javascript is removed as well. This is achieved by passing `$this` as `$widget` to the widget's view. It can then call `addCSS()` in the widget class (that I made) which will then simply forward the request to my page class.

``` php
$this->ci->page->addCSS($stylesheet);
```

Where can you get these classes? I hope to release my Page, Sidebar, and Widget class sometime. There’s no demand for them now so I’m holding off for a bit. If you want them, simply [email me](http://samsoffes.com/about).
