SHELL = /bin/sh

TARGET = ocs-store
srcdir = .

DESTDIR =
prefix = /usr/local
exec_prefix = $(prefix)
bindir = $(exec_prefix)/bin
libdir = $(exec_prefix)/lib
datadir = $(prefix)/share

INSTALL = install
INSTALL_PROGRAM = $(INSTALL) -D -m 755
INSTALL_DATA = $(INSTALL) -D -m 644
MKDIR = mkdir -p
CP = cp -Rpf
RM = rm -rf

.PHONY: all rebuild build clean install uninstall

all: rebuild ;

rebuild: clean build ;

build: $(TARGET) ;

clean:
	$(RM) $(srcdir)/node_modules
	$(RM) $(srcdir)/dist

install:
	$(INSTALL_PROGRAM) $(srcdir)/launcher/$(TARGET) $(DESTDIR)$(bindir)/$(TARGET)
	$(MKDIR) $(DESTDIR)$(libdir)
	$(CP) $(srcdir)/dist/$(TARGET)-linux-x64 $(DESTDIR)$(libdir)
	$(INSTALL_DATA) $(srcdir)/desktop/$(TARGET).desktop $(DESTDIR)$(datadir)/applications/$(TARGET).desktop
	$(INSTALL_DATA) $(srcdir)/desktop/$(TARGET).svg $(DESTDIR)$(datadir)/icons/hicolor/scalable/apps/$(TARGET).svg

uninstall:
	$(RM) $(DESTDIR)$(bindir)/$(TARGET)
	$(RM) $(DESTDIR)$(libdir)/$(TARGET)-linux-x64
	$(RM) $(DESTDIR)$(datadir)/applications/$(TARGET).desktop
	$(RM) $(DESTDIR)$(datadir)/icons/hicolor/scalable/apps/$(TARGET).svg

$(TARGET): $(TARGET)-linux-x64 ;

$(TARGET)-linux-x64:
	cd $(srcdir) ; \
		npm install ; \
		npm run package
