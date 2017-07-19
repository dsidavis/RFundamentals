
%.html: %.md
	pandoc --from=markdown --to=html -c Class.css $< > $@


CSS=$(wildcard *.css) 

DAY1=Day1 Exercise1 Exercise2 Exercise3 REPL Computing3 EverythingIsACall GlobalEnvironment SearchPath Variables FunctionCalls Outline  
DAY1.HTML=$(patsubst %,%.html,$(DAY1))


DAY2= Day2 VectorHierarchy Attributes Sequences NA RecyclingRule Subsetting Factors Subsetting  Subsetting2D  MatrixSubsetting ListAndC Lists Matrices DataFrames Lists DataFrames Matrices
# Matrices Lists DataFrames 
# BasicTypes Attributes2  
DAY2.HTML=$(patsubst %,%.html,$(DAY2))


DAY3= Apply WritingFunctions Day3 tryCatch rnormVec WritingPackages Day4 Debugging
DAY3.HTML=$(patsubst %,%.html,$(DAY3))

DAY4=

DAY4.HTML=$(patsubst %,%.html,$(DAY4))


Day1:  $(DAY1.HTML)
Day2:  $(DAY2.HTML)
Day3:  $(DAY3.HTML)

Day4:  $(DAY4.HTML) expandGrid.R

all: ship1 ship2 ship3 ship4




ship1: Day1
	rsync $(CSS) index.html Day1.Rsession $(DAY1.HTML) calls.pdf anson:dsi/RFundamentals

ship2: Day2
	rsync $(CSS) index.html $(DAY2.HTML) anson:dsi/RFundamentals

ship3: Day3
	rsync $(CSS) index.html $(DAY3.HTML) anson:dsi/RFundamentals

ship4: Day4
	rsync $(CSS) index.html $(DAY4.HTML) anson:dsi/RFundamentals


%.pdf: %.tex
	pdflatex $*
