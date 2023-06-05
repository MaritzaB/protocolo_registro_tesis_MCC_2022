.PHONY: \
	all \
	clean \
	format \
	tests \
	tesis

report: \
	reports/protocolo_reg_tesis_MCC_MaritzaBello.pdf

tesis: \
	tesis/modelado_nicho_ecologico.pdf

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

reports/protocolo_reg_tesis_MCC_MaritzaBello.pdf:	reports/protocolo_reg_tesis_MCC_MaritzaBello.tex
	$(renderLatex)

tesis/modelado_nicho_ecologico.pdf: tesis/modelado_nicho_ecologico.tex
	$(renderLatex)


clean:
	rm --force reports/*.aux
	rm --force reports/*.bbl
	rm --force reports/*.blg
	rm --force reports/*.log
	rm --force reports/*.out
	rm --force reports/*.pdf
	rm --force reports/*.toc
	rm --force tesis/*.aux
	rm --force tesis/*.bbl
	rm --force tesis/*.blg
	rm --force tesis/*.log
	rm --force tesis/*.out
	rm --force tesis/*.pdf
	rm --force tesis/*.toc
	rm --force tesis/*.lof
	rm --force tesis/*.lot
	rm --force tesis/introduccion/*.aux
	rm --force tesis/otros/*.aux

format:
	black --line-length 60 src/*.py

linter:
	$(call lint, src)
	$(call lint, tests)

tests:
	pytest --verbose tests/