# Blog

This is the content for [my blog](https://blog.soff.es/). The source code for the site is [also on GitHub](https://github.com/soffes/blog.soff.es).

Please do not use or distribute my posts without permission.


## Nerd Things

Posts are structured with the following format:

    published/YYYY-MM-DD-PERMALINK/PERMALINK.md

The markdown file may contain [front matter](https://jekyllrb.com/docs/frontmatter/). The first `<h1>`'s text will be treated as the title of the post unless it is specified in front matter. If both are missing, the permalink is used.

Images are included in the post's folder. All image URLs are specified relative to the markdown file.

A cover image may be present. It is specified as `cover_image` in the front matter.

Tags may also be present. The are specified as a [YAML list](https://en.wikipedia.org/wiki/YAML#Lists) in the front matter.


### Creating a New Post

Run the following command:

    $ rake new 'My Great Post'

This will ensure the slug for the post isn’t already taken, create the directory with the proper date, create a markdown file in the directory, and open the markdown file in the desired editor. Time saver.


### Editing the Most Recent Post

It’s fairly common that I have a typo in a post. To quickly edit the most recent post, run the following command:

    $ rake recent

Easy as that.
