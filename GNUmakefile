
%.html: %.md
	pandoc --from=markdown --to=html -c Class.css $< > $@


CSS=$(wildcard *.css) 

DAY1=Day1 Exercise1 Exercise2 Exercise3 REPL Computing3 EverythingIsACall GlobalEnvironment SearchPath Variables FunctionCalls Outline 
DAY1.HTML=$(patsubst %,%.html,$(DAY1))
Day1:  $(DAY1.HTML)



DAY2= VectorHierarchy Attributes Sequences NA RecyclingRule Subsetting Factors Lists Subsetting DataFrames Subsetting2D Matrices MatrixSubsetting 

# BasicTypes Attributes2

ship1: Day1
	rsync $(CSS) index.html Day1.Rsession $(DAY1.HTML) anson:dsi/RFundamentals

