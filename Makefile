SAXON=java -cp $(HOME)/bin/saxon9he/saxon9he.jar net.sf.saxon.Transform
SAXONFLAGS=

RSH=rsh.xml

all: rsh-pleco.txt rsh-pleco-pinyin.txt rsh-table.txt

rsh-pleco.txt: userdict.xsl $(RSH)
	$(SAXON) $(SAXONFLAGS) -o:$@ -s:$(RSH) -xsl:$<

rsh-pleco-pinyin.txt: userdict.xsl $(RSH)
	$(SAXON) $(SAXONFLAGS) -o:$@ -s:$(RSH) -xsl:$< ?config-pinyin='true()'

rsh.html: html.xsl $(RSH)
	$(SAXON) $(SAXONFLAGS) -o:$@ -s:$(RSH) -xsl:$<

rsh-table.txt: table.xsl $(RSH)
	$(SAXON) $(SAXONFLAGS) -o:$@ -s:$(RSH) -xsl:$<

test: heisig.xsd $(RSH)
	xmllint --nonet --noout --schema $< $(RSH)

release: heisig-release.zip

%.zip: rsh-pleco.txt rsh-pleco-pinyin.txt rsh-table.txt
	zip -9 $@ $^

clean:
	rm -f rsh-pleco.txt rsh-pleco-pinyin.txt rsh.html rsh-table.txt heisig-release.zip

table.xsl: util.xsl reading.xml traditional.xml measure.xml surname.xml
ebook.xsl: util.xsl reading.xml
html.xsl: ebook.xsl
userdict.xsl: ebook.xsl
