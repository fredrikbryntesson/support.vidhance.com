Website for support.vidhance.com. The original files are in the master branch and the published website is in the gh-pages branch.

# Prerequisites
 1. Install [hugo](http://gohugo.io).
 2. Clone this repo: ```git clone https://github.com/vidhance/support.vidhance.com```.
 3. Update and initialize the submodule: ```git submodule update --init```.

# Editing
## Markdown
The main content is placed in the content folder into markdown files.
## Other Content
Images and other content is placed in static. Create folders corresponding to the path and the name of the content file they belong to and place the files there.

# Previewing
 1. Run the preview script: ```./tools/preview.sh```.
 2. Open the following URL in your browser: ```http://support.vidhance.com/vidview/```.
 3. Press ```Ctrl-C``` in the terminal to stop the preview server.

# Publishing
 1. Stop the preview server using ```Ctrl-C```.
 2. Run the publish script: ```./tools/publish.sh``` and input a commit message when requested.
 3. Stage changes including the ```public``` folder and commit them using the same commit message and finish off with push.
