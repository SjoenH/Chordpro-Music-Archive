#!/bin/bash

#Change directory to where this file is at.
cd "`dirname "$0"`" 

rm -rf temp

git add .
git commit -m "Updated songs"
git push