# dotfiles
A collection of my personal configuration dotfiles.

Available configurations:
- [Zsh](zsh/README.md)
- [Vim](vim/README.md)

The configurations should work on both Linux and MacOS

![GitHub](https://img.shields.io/github/license/gpetrousis/dotfiles.svg)

## Fair warning
If you want to use the dotfiles you should double check and evaluate them. Don't execute commands and apply settings that you don't understand. I tried my best to document the files so this can be easier.

At the end of the day you are responsible for what is running on your machine.

## Instalation
### Clone the repo
`git clone git@github.com:gpetrousis/dotfiles.git && cd dotfiles`

### Run the install script
`make install`

To install configurations separately you can either:
- Run `make <config>`. Eg: `make zsh`
- Navigate to the config folder and install. Eg: `cd vim && make install`

The install script will link all the available config files to your Home path, create necessary directories and download any needed dependencies.

In case there is already an existing link it will be deleted and if there is already a config file it will be kept as backup in the format of `<filename>.<date>.backup`.

Any created folders will be kept in the repo directory and will be linked as well. This way it's easier to clean-up in case you don't want to use these configs anymore.

#### For MacOS installation run
`make install DOTFILES_TARGET="MACOS"`

This will link MacOS specific config files.

### Uninstall
`make uninstall`

To install configurations separately you can either:
- Run `make uninstall_<config>`. Eg: `make uninstall_zsh`
- Navigate to the config folder and uninstall. Eg: `cd vim && make uninstall`

The uninstall script will delete any linked files and directories that were created from the install command.

## Support
If you find something that is not working as expected feel free to [open an issue](https://github.com/gpetrousis/dotfiles/issues) and I will try to take a look at it as fast as possible

## Future work
- Add vscode config
- Add AWS Profile to prompt

## Status
The project is in a stable state.
The dotfiles and the scripts that are included so far should be complete and work as expected.
However more stuff will come in the future and small changes are bound to happen (Check the Future Work).