# dotfiles
A collection of my personal configuration dotfiles.

Available configurations:
- [Zsh](zsh/)
- [Vim](vim/)
- [VSCode](vscode/)

The configurations should work on Linux, MacOS and RaspberryPi configured as a
code server.

![GitHub](https://img.shields.io/github/license/gpetrousis/dotfiles.svg)

## Fair warning
If you want to use the dotfiles you should double check and evaluate them. Don't
execute commands and apply settings that you don't understand. I tried my best
to document the files so this can be easier.

At the end of the day you are responsible for what is running on your machine.

## Instalation
### Clone the repo
```shell
git clone git@github.com:gpetrousis/dotfiles.git && cd dotfiles
```

### Run the install script
```shell
./scripts/install.sh -a
```

To install configurations separately you can run:
```shell
./scripts/install.sh -p <platform> <config>
```

Eg:

```shell
./scripts/install.sh zsh
```

The install script will link all the available config files to your Home path,
create necessary directories and download any needed dependencies.

In case there is already an existing link it will be deleted and if there is
already a config file it will be kept as backup in the format of
`<filename>.<date>.backup`.

Any created folders will be kept in the repository directory and will be linked
as well. This way it's easier to clean-up in case you don't want to use these
configs anymore.

#### For MacOS installation run
```shell
./scripts/install.sh -a -p mac
```

This will link MacOS specific config files.
#### For PiCode installation run
```shell
./scripts/install.sh -a -p picode
```

This will link specific config files for the code-server.

### Uninstall
```shell
./scripts/uninstall.sh -a -p <platrofm>
```

Similar to the install scripts the platform can be linux, zsh or picode. The
script will unlink the platrofm config specific files.

To uninstall configurations separately you can run:
```shell
./scripts/uninstall.sh -p <platrofm> <config>
```
Eg:
```shell
./scripts/uninstall.sh -p picode vim
```

The uninstall script will delete any linked files and directories that were
created from the install command.

## Support
If you find something that is not working as expected feel free to [open an issue](https://github.com/gpetrousis/dotfiles/issues) and I will try to take a look at it as fast as possible

## Future work
- Move backup_and_link.sh and remove_links.sh to common scripts
- Add AWS Profile to prompt

## Status
The project is in a stable state.
The dotfiles and the scripts that are included so far should be complete and work as expected.
However more stuff will come in the future and small changes are bound to happen (Check the Future Work).
