#!/bin/bash

mkdir rendered_templates

for file in $(ls templates); do
  echo $file
  erb -r './devops.rb' templates/$file > rendered_templates/$file
done
