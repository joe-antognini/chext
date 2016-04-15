#! /bin/bash

#
# chext installation script
#

# Prompt for an installation path
echo "Please choose an installation location:"
echo "1 for /usr/local/bin (default, may require sudo permissions)"
echo "2 for $HOME/bin"
read -p "or type another path: " path_input

case ${path_input:-$1} in
  1|"")
    install_path="/usr/local"
    ;;
  2)
    install_path="$HOME"
    ;;
  *)
    install_path=$path_input
    ;;
esac

echo "Installing to $install_path/bin..."

# Install the executable
if [ ! -e $install_path/bin ]
then
  mkdir -p $install_path/bin
fi
cp chext $install_path/bin

# Install the man page
if [ ! -e $install_path/share/man/man1 ]
then
  mkdir -p $install_path/share/man/man1
fi
cp chext.1 $install_path/share/man/man1

if hash bats 2> /dev/null
then
  echo "BATS found, testing chext..."
  bats chext.bats
fi
