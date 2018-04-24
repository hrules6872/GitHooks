#!/bin/sh

HOOKSFOLDER='./hooks'

error() {
  echo "Usage: $0 --enable-all"
  echo "Usage: $0 --disable-all"
  echo "Usage: $0 --enable [hooks/git-hook/name]"
  echo "Usage: $0 --disable [hooks/git-hook/name]"  
  exit 1
}

if [ -z "$1" ]; then
  error
fi
 
case $1 in 
  "--enable-all") find $HOOKSFOLDER -type f -not -path '*/\.*' -exec chmod +x {} \; ;;
  "--disable-all") find $HOOKSFOLDER -type f -not -path '*/\.*' -exec chmod -x {} \; ;;
  "--enable")
    if [ -z "$2" ]; then
      error
    fi
    chmod +x $2;;
  "--disable")
    if [ -z "$2" ]; then
      error
    fi
    chmod -x $2;;
  *) error;;
esac

if [ $? -ne 0 ]; then
  exit 1
fi
echo "Done."