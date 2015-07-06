# Blog

This is the content for [my blog](http://blog.soff.es/). The source code for the site is [also on GitHub](https://github.com/soffes/blog.soff.es).

If you're looking for [my website](http://soff.es), the source is [over here](https://github.com/soffes/soff.es).

Please do not use or distribute my posts without permission.


## Nerd Things

Posts are structured with the following format:

    published/YYYY-MM-DD-PERMALINK/PERMALINK.markdown

The markdown file may contain [front matter](http://jekyllrb.com/docs/frontmatter/). The first `<h1>`'s text will be treated as the title of the post unless it is specified in front matter. If both are missing, the permalink is used.

Images are included in the post's folder. All image URLs are specified relative to the markdown file.

A cover image may be present. It is specified as `cover_image` in the front matter.

Tags may also be present. The are specified as a [YAML list](https://en.wikipedia.org/wiki/YAML#Lists) in the front matter.

