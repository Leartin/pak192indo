# Just run
#   make clean all archives
# to get fresh and ready to deploy .tbz2 and .zip archives

MAKEOBJ ?= ./makeobj

DESTDIR  ?= ./release/
PAKDIR   ?= $(DESTDIR)/
DESTFILE ?= pak192.indo

OUTSIDE :=
OUTSIDE += ./master/misc/

DIRS192 :=
DIRS192 += ./master/building/
DIRS192 += ./master/config/
DIRS192 += ./master/doc/
DIRS192 += ./master/goods/
DIRS192 += ./master/maintained_object/
DIRS192 += ./master/misc/
DIRS192 += ./master/scenario/
DIRS192 += ./master/sound/
DIRS192 += ./master/text/
DIRS192 += ./master/vehicle/
DIRS192 += ./master/way/

DIRS128 :=
DIRS128 += ./master/misc

DIRS := $(OUTSIDE) $(DIRS192) $(DIRS128)

.PHONY: $(DIRS) copy tar zip

all: copy $(DIRS) zip

archives: tar zip

tar: $(DESTFILE).tbz2
zip: $(DESTFILE).zip

copy:
	@echo "===> COPY"
	@rm -rf $(PAKDIR)
	@mkdir -p $(PAKDIR)/sound $(PAKDIR)/text $(PAKDIR)/config $(PAKDIR)/scenario
	@cp -p compat/compat.tab $(PAKDIR)
	@cp -p sound/* $(PAKDIR)/sound
	@cp -p config/* $(PAKDIR)/config
	@cp -rp scenario/* $(PAKDIR)/scenario
	@find $(PAKDIR)/scenario -depth "(" -name ".svn" ")" -exec rm -rf {} \;
	@cp -p pak.text/* $(PAKDIR)/text

$(DIRS192):
	@echo "===> PAK192 $@"
	@mkdir -p $(PAKDIR)
	@$(MAKEOBJ) verbose PAK $(PAKDIR)/ $@/ > /dev/null

$(DIRS128):
	@echo "===> PAK128 $@"
	@mkdir -p $(PAKDIR)
	@$(MAKEOBJ) quiet PAK128 $(PAKDIR)/ $@/ > /dev/null

$(OUTSIDE):
	@echo "===> Grounds calculations"
	@echo "===> OUTSIDE with REVISION and grounds"
	@mkdir -p $(PAKDIR)
	@printf "Obj=ground\nName=Outside\ncopyright=pak192.indo ALPHA R r%s\nImage[0][0]=outside.0.1\n-" `svnversion` >$@/outside.dat
	@$(MAKEOBJ) PAK64 $(PAKDIR)/ $@/ > /dev/null
	@rm $@/outside.dat
