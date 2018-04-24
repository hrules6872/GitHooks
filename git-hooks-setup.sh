#!/bin/sh

HOOKSFOLDER='./hooks'

exec < /dev/tty
while true; do
  read -p "Do you want to make $HOOKSFOLDER folder your project Git Hooks folder? [y/n]" yn
  case $yn in
    [Yy]* ) break;;
    [Nn]* ) exit 1;;  
  esac
done

mayor=$(git --version | grep -o '[0-9.]*' | awk -F \. {'print $1'})
minor=$(git --version | grep -o '[0-9.]*' | awk -F \. {'print $2'})

if [ $mayor -eq "2" ] && [ $minor -lt "9" ]; then
  rm -rf .git/hooks/*
  find $HOOKSFOLDER -type f -exec ln -sf ../../{} .git/hooks/ \;
else
  git config core.hooksPath $HOOKSFOLDER
fi  

find $HOOKSFOLDER -type f -not -path '*/\.*' -exec chmod +x {} \;

if [ $? -ne 0 ]; then
    exit 1
fi
echo "Done."