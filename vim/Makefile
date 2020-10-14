PHONY: vim

install:
	@echo "[INFO] Creating vim directories"
	mkdir -p ./vim/plugged
	mkdir -p ./vim/files/swap
	mkdir -p ./vim/files/backup
	mkdir -p ./vim/files/undo

	@echo "[INFO] Linking config files"
	../scripts/backup_and_link.sh

	@echo "[INFO] Installing vim-plug"
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

	@echo "[INFO] Installing vim plugins"
	vim +silent +PlugInstall +qall 

uninstall:
	@echo "[INFO] Removing linked files"
	../scripts/remove_links.sh
	@echo "[INFO] Deleting vim folder"
	rm -rf ./vim