
%.html: %.md
	pandoc --from=markdown --to=html -c Class.css $< > $@


CSS=$(wildcard *.css) 

DAY1=Day1 Exercise1 Exercise2 Exercise3 REPL Computing3 EverythingIsACall GlobalEnvironment SearchPath Variables FunctionCalls Outline 
DAY1.HTML=$(patsubst %,%.html,$(DAY1))
Day1:  $(DAY1.HTML)

ship1: Day1
	scp $(CSS) index.html $(DAY1.HTML) anson:dsi/RFundamentals

