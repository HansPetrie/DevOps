#!/bin/bash

for file in $(ls templates); do
  echo $file
  erb -r './devops.rb' templates/$file > rendered_templates/$file
done
