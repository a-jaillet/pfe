

all : DossierInitPFE.pdf rapportPFE-fr.pdf rapportPFE-en.pdf

DossierInitPFE.pdf : DossierInitPFE.tex rapportPFE.bib graphics/DiagrammeThil.jpg
	make DossierInitPFE-3.pdf

rapportPFE-fr.pdf : rapportPFE-fr.tex rapportPFE.bib graphics/DiagrammeThil.jpg
	make rapportPFE-fr-3.pdf

rapportPFE-en.pdf : rapportPFE-en.tex rapportPFE.bib graphics/DiagrammeThil.jpg
	make rapportPFE-en-3.pdf



DossierInitPFE-3.pdf : DossierInitPFE-2.pdf
	pdflatex DossierInitPFE.tex
	cp DossierInitPFE.pdf DossierInitPFE-3.pdf

DossierInitPFE-2.pdf : DossierInitPFE-1.pdf DossierInitPFE-1.bbl
	pdflatex DossierInitPFE.tex
	cp DossierInitPFE.pdf DossierInitPFE-2.pdf

DossierInitPFE-1.bbl : DossierInitPFE-1.pdf rapportPFE.bib
	bibtex DossierInitPFE

DossierInitPFE-1.pdf : DossierInitPFE.tex graphics/DiagrammeThil.jpg
	pdflatex DossierInitPFE.tex
	cp DossierInitPFE.pdf DossierInitPFE-1.pdf






rapportPFE-fr-3.pdf : rapportPFE-fr-2.pdf
	pdflatex rapportPFE-fr.tex
	cp rapportPFE-fr.pdf rapportPFE-fr-3.pdf

rapportPFE-fr-2.pdf : rapportPFE-fr-1.pdf rapportPFE-fr.bbl
	pdflatex rapportPFE-fr.tex
	mv rapportPFE-fr.pdf rapportPFE-fr-2.pdf

rapportPFE-fr-1.pdf : rapportPFE-fr.tex graphics
	pdflatex rapportPFE-fr.tex
	mv rapportPFE-fr.pdf rapportPFE-fr-1.pdf

rapportPFE-fr.bbl : rapportPFE-fr.tex rapportPFE.bib
	bibtex rapportPFE-fr





rapportPFE-en-3.pdf : rapportPFE-en-2.pdf
	pdflatex rapportPFE-en.tex
	cp rapportPFE-en.pdf rapportPFE-en-3.pdf

rapportPFE-en-1.pdf : rapportPFE-en.tex graphics
	pdflatex rapportPFE-en.tex
	mv rapportPFE-en.pdf rapportPFE-en-1.pdf

rapportPFE-en.bbl : rapportPFE-en.tex rapportPFE.bib
	bibtex rapportPFE-en

rapportPFE-en-2.pdf : rapportPFE-en-1.pdf rapportPFE-en.bbl
	pdflatex rapportPFE-en.tex
	mv rapportPFE-en.pdf rapportPFE-en-2.pdf




	






clean : clean-fr clean-en cleanInit cleanPoster

cleanInit : 
	rm -f DossierInitPFE-1.pdf DossierInitPFE-2.pdf DossierInitPFE-3.pdf DossierInitPFE.bbl DossierInitPFE.aux DossierInitPFE.blg DossierInitPFE.log DossierInitPFE.out DossierInitPFE.toc

cleanPoster : 
	rm -f PosterPFE.aux PosterPFE.out PosterPFE.log

clean-fr :
	rm -f rapportPFE-fr-1.pdf rapportPFE-fr-2.pdf rapportPFE-fr-3.pdf rapportPFE-fr.bbl rapportPFE-fr.aux rapportPFE-fr.blg rapportPFE-fr.log rapportPFE-fr.out rapportPFE-fr.toc

clean-en :
	rm -f rapportPFE-en-1.pdf rapportPFE-en-2.pdf rapportPFE-en-3.pdf rapportPFE-en.bbl rapportPFE-en.aux rapportPFE-en.blg rapportPFE-en.log rapportPFE-en.out rapportPFE-en.toc
