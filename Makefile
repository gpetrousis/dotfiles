.PHONY: install zsh vim

install: zsh vim

uninstall: uninstall_zsh uninstall_vim

zsh:
	./scripts/zsh.sh install

uninstall_zsh:
	./scripts/zsh.sh uninstall

vim:
	./scripts/vim.sh install 

uninstall_vim:
	./scripts/vim.sh uninstall
