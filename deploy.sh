#!/bin/sh

# Build the site
cd "`dirname "$0"`"
bundle exec jekyll build

# Ensure correct permissions in _site
# User and group can read and write any file/directory.
# Others (the web) can only read.
chmod -R u=rwX,go=rX _site

# Upload it to the production server
rsync -avz \
  --delete-after \
  --delete-excluded \
  --rsh='ssh' \
  ./_site/ \
  fantasticlife@smethur.st:/srv/www/smethurst
