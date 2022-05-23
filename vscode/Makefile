
install:
	@echo "[INFO] Linking config files"
ifeq ($(DOTFILES_TARGET), MACOS)
	../scripts/backup_and_link.sh -s -t "$(HOME)/Library/Application Support/Code/User"
else ifeq ($(DOTFILES_TARGET), CODEPI)
	../scripts/backup_and_link.sh -s -t "$(HOME)/.local/share/code-server/User"
else
	../scripts/backup_and_link.sh -s -t "$(HOME)/.config/Code/User"
endif

uninstall:
	@echo "[INFO] Removing linked files"
ifeq ($(DOTFILES_TARGET), MACOS)
	../scripts/remove_links.sh -s -t "$(HOME)/Library/Application Support/Code/User"
else ifeq ($(DOTFILES_TARGET), CODEPI)
	../scripts/remove_links.sh -s -t "$(HOME)/.local/share/code-server/User"
else
	../scripts/remove_links.sh -s -t "$(HOME)/.config/Code/User"
endif