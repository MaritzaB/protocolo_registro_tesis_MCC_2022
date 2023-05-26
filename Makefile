report: \
	reports/protocolo_reg_tesis_MCC_MaritzaBello.pdf

exam: reports/examen.pdf

.PHONY: \
	all \
	clean \
	format \
	tests

define renderSimpleLatex
    cd $(<D) && pdflatex $(<F)
	cd $(<D) && pdflatex $(<F)
endef

define renderLatex
    cd $(<D) && pdflatex $(<F)
	cd $(<D) && pdflatex $(<F)
	cd $(<D) && bibtex $(subst .tex,,$(<F))
	cd $(<D) && pdflatex $(<F)
	cd $(<D) && pdflatex $(<F)
endef

define lint
	pylint \
        --disable=missing-class-docstring \
        --disable=missing-function-docstring \
        --disable=missing-module-docstring \
		--function-naming-style=camelCase \
        ${1}
endef

reports/examen.pdf: reports/examen.tex
	$(renderSimpleLatex)

reports/protocolo_reg_tesis_MCC_MaritzaBello.pdf:	reports/protocolo_reg_tesis_MCC_MaritzaBello.tex
	$(renderLatex)


clean:
	rm --force --recursive reports/pythontex*
	rm --force reports/*.aux
	rm --force reports/*.bbl
	rm --force reports/*.blg
	rm --force reports/*.log
	rm --force reports/*.out
	rm --force reports/*.pdf
	rm --force reports/*.toc

format:
	black --line-length 60 src/*.py

linter:
	$(call lint, src)
	$(call lint, tests)

tests:
	pytest --verbose tests/