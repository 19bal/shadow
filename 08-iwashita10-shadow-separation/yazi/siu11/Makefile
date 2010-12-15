NAME=			premat

LATEX_FLAGS+=		-src-specials
LATEX_MK_FLAGS+=	--ignore-errors
VIEWPDF=		acroread

# Kaynak satırı etkinleştirildiğinde bunu da etkinleştir.
BIBTEXSRCS=		premat.bib

EPS_FILES_FROM_JPG:=	$(patsubst %.jpg,%.eps,$(wildcard resim/*.jpg))
EPS_FILES_FROM_BMP:=	$(patsubst %.bmp,%.eps,$(wildcard resim/*.bmp))

%.eps: %.bmp
	convert $< $@

TEXSRCS=		$(EPS_FILES_FROM_JPG) $(EPS_FILES_FROM_BMP)

include /usr/share/latex-mk/latex.gmk
