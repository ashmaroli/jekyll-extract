# Jekyll Extract

A plugin that adds a new Jekyll command to easily copy files and directories from a theme-gem to your site's source directory.


## Installation

Add this plugin to your site's Gemfile:

```ruby
group :jekyll_plugins do
  gem "jekyll-extract"
end
```
...and run:

    $ bundle


## Usage

`jekyll extract` command is meant to simplify accessing a Jekyll theme-gem and copying the files you wish to customize, to your site's configured source directory.

Run `jekyll extract` with a `--list-all` switch to get an idea about all files bundled in the current theme:

```sh
# demo using Minima v2.1.1

$ bundle exec jekyll extract --list-all
[...]
         Listing: All files in current theme
                   * assets/main.scss
                   * LICENSE.txt
                   * README.md
                   * _includes/disqus_comments.html
                   * _includes/footer.html
                   * _includes/google-analytics.html
                   * _includes/head.html
                   * _includes/header.html
                   * _includes/icon-github.html
                   * _includes/icon-github.svg
                   * _includes/icon-twitter.html
                   * _includes/icon-twitter.svg
                   * _layouts/default.html
                   * _layouts/home.html
                   * _layouts/page.html
                   * _layouts/post.html
                   * _sass/minima/_base.scss
                   * _sass/minima/_layout.scss
                   * _sass/minima/_syntax-highlighting.scss
                   * _sass/minima.scss
```

To copy an entire directory over to the source directory (henceforth referenced by the phrase *"extract to source"*), pass the directory-path, relative to the gem, as the argument:

```sh
$ bundle exec jekyll extract _layouts
```

To extract multiple directories simultaneously, pass each directory path as arguments:

```sh
$ bundle exec jekyll extract _layouts _sass/minima
```
will extract contents of both `_layouts` and `_sass/minima` to source, creating the directories as required.

Similarly extract certain files like below:

To check what files are bundled in a particular directory, run the command with a `--show` switch:

```sh
$ bundle exec jekyll extract _layouts --show
[...]
           Listing: Contents of '_layouts' in theme gem...
                     * _layouts/default.html
                     * _layouts/home.html
                     * _layouts/page.html
                     * _layouts/post.html

```
Now, to extract just a couple of layouts from the list, run:

```sh
$ bundle exec jekyll extract _layouts/default.html _layouts/page.html
```
The above command will extract these two files to your site's source directory.


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ashmaroli/jekyll-extract. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

