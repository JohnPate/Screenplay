# Makefile
#
# LaTeX2e Draft Screenplay document class
# Authored by and Copyright (C)2006 by 
#         John Pate <johnny@dvc.org.uk>
#                 http://dvc.org.uk
# Latest version is available as:
#         http://dvc.org.uk/sacrific.txt/screenplay.zip
# 
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 2 of
# the License, or (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public
# License along with this program; if not, write to the Free
# Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
# MA 02110-1301 USA
# 
# GPL v2 text also available as: 
#         http://dvc.org.uk/gplv2.txt
#
# John Pate <johnny@dvc.org.uk>
# revised 2012-06-25

.SUFFIXES:

all:
	@echo no rule for all

screenplay.zip: screenplay.pdf test.pdf screenplay.dtx
	zip -j screenplay.zip README  \
		./screenplay.dtx \
		./screenplay.ins \
		./screenplay.pdf \
		./test.pdf \
		./COPYING 

screenplay.cls:
	latex screenplay.ins

test.tex:
	latex screenplay.ins

screenplay.dvi: screenplay.cls
	latex screenplay.dtx
	makeindex -s gind.ist screenplay.dtx
	latex screenplay.dtx
	makeindex -s gglo.ist -o screenplay.gls screenplay.glo
	latex screenplay.dtx

screenplay.pdf: screenplay.dvi
	mv screenplay.dvi screen.dvi
	dvipdf -sPAPERSIZE=letter screen.dvi
	pdfopt screen.pdf screenplay.pdf
	rm screen.pdf screen.dvi

test.pdf: test.tex
	latex test.tex
	mv test.dvi temp.dvi
	dvipdf -sPAPERSIZE=letter temp.dvi
	pdfopt temp.pdf test.pdf
	rm temp.pdf temp.dvi

cleantex:
	-rm *.aux *.log *.dvi *.ps
	-rm temp.*.*

clear: clean

clean: cleantex
	-rm screenplay.zip
	-rm screenplay.log
	-rm screenplay.glo
	-rm screenplay.out
	-rm screenplay.gls
	-rm screenplay.aux
	-rm screenplay.idx
	-rm screenplay.ilg
	-rm screenplay.ind
	-rm screenplay.pdf
	-rm screenplay.cls
	-rm screenplay.tpt
	-rm hardmarg.sty
	-rm test.tex test.pdf example.tex

.PHONY: clean clear cleantex

# #####eof#####
