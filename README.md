# support.vidhance.com
Website for support.vidhance.com.

The site is built with [Hugo](http://gohugo.io/) and deployed to Github Pages.

Changes to the repository will trigger a [Wercker](http://wercker.com/) script that builds and deploys the site automatically.

## Editing
#### Markdown
The main content is placed in the content folder into markdown files.
#### Other Content
Images and other content is placed in static. Create folders corresponding to the path and the name of the content file they belong to and place the files there.

## To run this site on a local computer follow these steps

1. Clone the repository to your computer.
2. Go to https://github.com/spf13/hugo/releases and download the latest release. (v0.14 was used to build this site)
3. Stand in the root folder of the cloned repository and run "hugo -w server" to start a local webserver hosting the site and that refreshes the site when a file is edited.
