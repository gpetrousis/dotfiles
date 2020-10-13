.PHONY: install zsh

install: zsh

uninstall: uninstall_zsh

zsh:
	./scripts/zsh.sh install

uninstall_zsh:
	./scripts/zsh.sh uninstall
