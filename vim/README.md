# Vim Config
Settings and plugins for the Vim text editor.

## Installation
`make install`

The install script will create folders for the plugins, swap, backup, and undo. Then it will link the config files to your Home directory and finally will download and install all the specified vim plugins using the vim-plug.

## Uninstall
`make uninstall`

The uninstall script will delete any linked files that were created from the install comman as well as the created directories.

## Usage
To change any Vim settings you can update the `vimrc` file. 

To add or remove plugins you can change the `vimrc` file accordingly and run the appropriate [Vim-Plug Command](https://github.com/junegunn/vim-plug#commands).

For more information check the [Vim options](http://vimdoc.sourceforge.net/htmldoc/options.html) and the [Vim Awesome](https://vimawesome.com/).