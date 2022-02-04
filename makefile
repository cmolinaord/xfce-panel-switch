INSTALL_DIR = /proyectos/bin

.PHONY: install uninstall

install:
	install -Dm755 panel2-switch.sh		$(INSTALL_DIR)/panel2-switch
uninstall:
	rm -f /proyectos/bin/panel2-switch
