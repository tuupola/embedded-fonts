SHELL=/bin/bash

# Source BDF or PCF files
SRCPCF=src
SRCBDF=src

# Generated files
DSTFONTX=fontx
DSTH=include
DSTPNG=png

# https://github.com/tuupola/fontx2_tools
BDF2FONTX=bdf2fontx
FONTX2PNG=fontx2png --width 640 --spacing 1
# https://linux.die.net/man/1/xxd
XXD=xxd -include
# https://github.com/ganaware/pcf2bdf
PCF2PDF=pcf2bdf
# macOS needs the -i ""
SED=sed -i ""
SORT=sort -V

all: bdf fontx header fixheader png

bdf: $(SRCPCF)/*.pcf
	$(foreach var, $^, $(PCF2PDF) < $(var) > $(addsuffix .bdf, $(basename $(var)));)

fontx: $(SRCBDF)/*.bdf
	mkdir -p $(DSTFONTX)
	$(foreach var, $^, $(BDF2FONTX) < $(var) > $(addprefix $(DSTFONTX)/, $(addsuffix .fnt, $(basename $(notdir $(var)))));)

header: $(DSTFONTX)/*
	mkdir -p $(DSTH)
	$(foreach var, $^, $(XXD) $(var) > $(addprefix $(DSTH)/, $(addsuffix .h, $(basename $(notdir $(var)))));)

fixheader: $(DSTH)/*
	$(foreach var, $^, $(SED) "s/fontx_//; s/_fnt\[/\[/; s/_fnt_len /_size /" $(var);)

png: $(DSTFONTX)/*
	mkdir -p $(DSTPNG)
	cd $(DSTPNG) && $(foreach var, $^, $(FONTX2PNG) ../$(var);)

PNGS = $(ls $(DSTPNG) | $(SORT))

markdown:
	-rm README.md
	echo $(PNGS)
	$(foreach var, $(shell ls $(DSTPNG) | $(SORT)), echo  \#\# $(subst font,,$(basename $(var))) >> README.md; echo ![]\(png/$(var)\) >> README.md;)

clean:
	rm $(DSTFONTX)/*
	rm $(DSTH)/*
	rm $(DSTPNG)/*

.PHONY: all fontx header fixheader png bdf