.PHONY: install zsh vim vscode

install: zsh vim vscode

uninstall: uninstall_zsh uninstall_vim uninstall_vscode

zsh:
	cd zsh && make install

uninstall_zsh:
	cd zsh && make uninstall

vim:
	cd vim && make install

uninstall_vim:
	cd vim && make uninstall

vscode:
	cd vscode && make install

uninstall_vscode:
	cd vscode && make uninstall

