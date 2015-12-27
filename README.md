Remembering Simplified Hanzi Project
====================================

This project provides:

1) A database describing all the frames from Heisig & Richardson's Remembering Simplified Hanzi.
   * <https://nirc.nanzan-u.ac.jp/en/publications/miscellaneous-publications/remembering-hanzi/>
   * <https://nirc.nanzan-u.ac.jp/en/publications/miscellaneous-publications/remembering-simplified-hanzi-ii/>

2) Tools to convert the database into useful formats, namely:
   * [Pleco Chinese Dictionary](http://www.pleco.com/) user dictionary;
   * tab-delimetered text, suitable for [Anki](http://ankisrs.net/) and [Ankidroid](<https://github.com/ankidroid>) flash card programs; and
   * single HTML page, useful for debugging.


Conversion tools
----------------
XSLT (Extensible Stylesheet Language Transformations) programs are provided to transform
rsh.xml into other useful formats.

An XSLT v2 processor is required to execute these programs.
The following examples use the open-source Saxon-HE XSLT v2 processor.
Download here: <http://sourceforge.net/projects/saxon/files/Saxon-HE/>.

To create a Pleco user dictionary (rsh-pleco.txt):
```
% java -cp /path/to/saxon9he.jar net.sf.saxon.Transform -o:rsh-pleco.txt -xsl:userdict.xsl -s:rsh.xml
```

To create a Pleco user dictionary with the Pinyin field populated (rsh-pleco-pinyin.txt):
```
% java -cp /path/to/saxon9he.jar net.sf.saxon.Transform -o:rsh-pleco-pinyin.txt -xsl:userdict.xsl -s:rsh.xml ?config='true()'
```

To create a tab delimited text file (rsh-table.txt):
```
% java -cp /path/to/saxon9he.jar net.sf.saxon.Transform -o:rsh-table.txt -xsl:anki.xsl -s:rsh.xml
```

To create a single-page HTML dictionary (rsh.html):
```
% java -cp /path/to/saxon9he.jar net.sf.saxon.Transform -o:rsh.html -xsl:html.xsl -s:rsh.xml
```

These commands are also given in the enclosed Makefile.
Don't forget to alter the classpath to saxon9he.jar!


Example output
--------------
Below is an example of the Pleco user dictionary loaded into Pleco for Android.
Hyperlinks permit easy navigation to the elements of a character, as well as jumping to the previous and next frames.

[Pleco user dictionary screenshot](/example/userdict.png)


Database file format
--------------------
The structure of the database closely resembles the written structure: a book contains lessons, lessons contain pages, and pages contain either frames or stand-alone blocks of text.
Below is an example of the frame element:

```
<frame xsi:type="character" number="26" character="早" keyword="early">
<strokes>6</strokes>
<p>This character is actually a picture of the first flower of the day, which we shall, in defiance of botanical science, call the <cite>sun</cite>flower, since it begins with the element for <cite>sun</cite> and is held up on a stem with leaves (the pictographic representation of the final two strokes). This time, however, we shall ignore the pictograph and imagine <cite>sun</cite>flowers with <cite type="primitive" keyword="needle">needles</cite> for stems, which can be plucked and used to darn your socks.</p>
<p>The sense of <self>early</self> is easily remembered if one thinks of the <cite>sun</cite>flower as the early riser in the garden, because the <cite>sun</cite>, showing favoritism towards its namesake, shines on it before all the others (see <em>frame</em> <cite type="primitive" keyword="needle">10</cite>). <count/></p>
<primitive>
<p>As a primitive element, this character takes the meaning of <pself>sunflower</pself>, which was used to make the abstract key word <self>early</self> more graphic.</p>
</primitive>
</frame>
```

Each frame states its type (either character or primitive frame) and gives the frame number, character, keyword and part of speech (if applicable).
Paragraphs of the story are written between the p elements, using the following markup language.
* self, pself: used where the story describes the frame's own keyword, or its own primitive keywords.
* cite, info: used where the story makes reference to another keyword.
* variant: used where the story describes alternate forms of the frame's character.
* count: stroke count.
* i, em: italics, emphasis.

The markup language is used by the XSLT programs to understand the relationships between frames.
However, sometimes more information is needed to find the relationships.
Namely, when the story uses an alternate form of the intended keyword (such as capitalised or conjugated forms), it is necessary to specify the intended keyword using the @keyword attribute.
Additionally, when an identical keyword refers to another character frame and primitive frame, it is necessary to specify the type of keyword using the @type attribute.


File list
---------
| Name            | Description
|-----------------|------------
| README.md       | documentation
| LICENSE         | license
| rsh.xml         | database
| heisig.xsd      | schema
| Makefile        | Makefile
| userdict.xsl    | Pleco user dictionary XSLT
| table.xsl       | Tab delimited text XSLT
| html.xsl        | HTML dictionary XSLT
| ebook.xsl       | shared routines
| util.xsl        | shared routines
| reading.xml     | Pinyin and Jyutping pronunciation readings
| traditional.xml | simplified-to-traditional character lookup table
| measure.xml     | Measure words
| surname.xml     | Common surnames


Known limitations
-----------------

* The database DOES NOT reproduce the full text stories from the Remembering Simplified Hanzi series.

* The elements of a character are listed using the name as it appears in the books' index.
  For example, if a character's story describes 'two spoons' or 'spoon atop a spoon', only 'spoon' will be included in the list of elements.

* Some primitive elements are arbitrary, and have no obvious Unicode representation.
  These entries are all prefixed with 囧, and use crude character math.
  For example, '囧应－广' refers to the primitive element created using the last four strokes.

* Although the project requires an XSLT v2 processor, v2 features are only ever used to manipulate Pinyin pronunciations.

* When executed with the default JDK XML parser, Saxon chokes on the following characters.
  To avoid this problem, the affected characters are defined inline using ampersand notation.
  A more robust solution involves configuring Saxon to use an alternate XML parsers, see <http://www.saxonica.com/html/documentation/sourcedocs/controlling-parsing.html>.

| Character | Ampersand notation
|-----------|-------------------
| 𠀐 | ```&#x20010;```
| 𠀎 | ```&#x2000e;```
| 𠂆 | ```&#x20086;```
| 𠂇 | ```&#x20087;```
| 𠂉 | ```&#x20089;```
| 𠂤 | ```&#x200a4;```
| 𠃌 | ```&#x200cc;```
| 𠃓 | ```&#x200d3;```
| 𠆢 | ```&#x201a2;```
| 𠦝 | ```&#x2099d;```
| 𡗗 | ```&#x215d7;```
| 𢀖 | ```&#x22016;```
| 𢛳 | ```&#x226f3;```


Contact
-------
Peter Ross <pross@xvid.org>

GPG Fingerprint: A907 E02F A6E5 0CD2 34CD 20D2 6760 79C5 AC40 DD6B
