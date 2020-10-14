.PHONY: install zsh vim

install: zsh vim

uninstall: uninstall_zsh uninstall_vim

zsh:
	cd zsh && make install

uninstall_zsh:
	cd zsh && make uninstall

vim:
	cd vim && make install

uninstall_vim:
	cd vim && make uninstall
