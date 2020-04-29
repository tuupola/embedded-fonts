SHELL=/bin/bash

# ISO10646-1 source BDF files
SRCBDF=../ucs-fonts/submission
# Generated FONTX2 files
SRCFONTX2=X11/fontx2
# Generated C header files
SRCH=X11/include

DSTPNG=X11/png
# https://github.com/tuupola/fontx2_tools
BDF2FONTX=bdf2fontx
FONTX2PNG=fontx2png --width 640 --spacing 1
# https://linux.die.net/man/1/xxd
XXD=xxd -include
# macOS needs the -i ""
SED=sed -i ""
SORT=sort -V

define NEWLINE
\n
endef

all: fontx2 header fixheader png

fontx2: $(SRCBDF)/*.bdf
	mkdir -p $(SRCFONTX2)
	$(foreach var, $^, $(BDF2FONTX) < $(var) > $(addprefix $(SRCFONTX2)/font, $(addsuffix .fnt, $(basename $(notdir $(var)))));)

header: $(SRCFONTX2)/*
	mkdir -p $(SRCH)
	$(foreach var, $^, $(XXD) $(var) > $(addprefix $(SRCH)/, $(addsuffix .h, $(basename $(notdir $(var)))));)

fixheader: $(SRCH)/*
	$(foreach var, $^, $(SED) "s/X11_fontx2_//; s/_fnt\[/\[/; s/_fnt_len /_size /" $(var);)

png: $(SRCFONTX2)/*
	mkdir -p $(DSTPNG)
	cd X11/png/ && $(foreach var, $^, $(FONTX2PNG) ../../$(var);)

PNGS = $(ls $(DSTPNG) | $(SORT))

markdown:
	-rm X11/README.md
	echo $(PNGS)
	$(foreach var, $(shell ls $(DSTPNG) | $(SORT)), echo  \#\# $(subst font,,$(basename $(var))) >> X11/README.md; echo ![]\(png/$(var)\) >> X11/README.md;)

clean:
	rm $(SRCFONTX2)/*
	rm $(SRCH)/*
	rm $(DSTPNG)/*

.PHONY: all fontx2 header fixheader png