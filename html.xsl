<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:include href="ebook.xsl"/>

<xsl:output method="html" encoding="utf-8" indent="yes"/>

<xsl:template name="out-doc">
	<xsl:param name="title"/>
	<xsl:param name="text"/>
	<xsl:text disable-output-escaping="yes">&lt;</xsl:text>!DOCTYPE html<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
	<html>
	<head>
	<title><xsl:copy-of select="$title"/></title>
	</head>
	<body>
	<xsl:copy-of select="$text"/>
	</body>
	</html>
</xsl:template>

<xsl:template name="out-section">
	<xsl:param name="headword"/>
	<xsl:param name="title"/>
	<xsl:param name="text"/>
	<a><xsl:attribute name="name"><xsl:value-of select="$headword"/></xsl:attribute></a>
	<h2>
	<xsl:copy-of select="$title"/>
	</h2>
	<xsl:copy-of select="$text"/>
</xsl:template>

<xsl:template name="out-frame">
	<xsl:param name="headword"/>
	<xsl:param name="pinyin"/>
	<xsl:param name="keywords"/>
	<xsl:param name="text"/>
	<p/>
	<table border="1" width="100%">
	<tr>
	<td>
	<a><xsl:attribute name="name"><xsl:value-of select="$headword"/></xsl:attribute></a>
	<h2>
	<xsl:value-of select="$headword"/>
	<xsl:text> </xsl:text>
	<xsl:copy-of select="$keywords"/>
	</h2>
	<xsl:copy-of select="$text"/>
	</td>
	</tr>
	</table>
</xsl:template>

<xsl:template name="out-p">
	<xsl:param name="text"/>
	<p><xsl:copy-of select="$text"/></p>
</xsl:template>

<xsl:template name="out-br">
	<br/>
</xsl:template>

<xsl:template name="out-i">
	<xsl:param name="text"/>
	<i><xsl:copy-of select="$text"/></i>
</xsl:template>

<xsl:template name="out-b">
	<xsl:param name="text"/>
	<b><xsl:copy-of select="$text"/></b>
</xsl:template>

<xsl:template name="out-superscript">
	<xsl:param name="text"/>
	<sup><xsl:copy-of select="$text"/></sup>
</xsl:template>

<xsl:template name="out-em">
	<xsl:param name="text"/>
	<span style="font-variant: small-caps"><xsl:copy-of select="$text"/></span>
</xsl:template>

<xsl:template name="out-schema">
	<xsl:param name="text"/>
	<b><xsl:copy-of select="$text"/></b>
</xsl:template>

<xsl:template name="out-www">
	<xsl:param name="text"/>
	<a>
	<xsl:attribute name="href"><xsl:copy-of select="$text"/></xsl:attribute>
	<xsl:copy-of select="$text"/>
	</a>
</xsl:template>

<xsl:template name="out-link">
	<xsl:param name="headword"/>
	<xsl:param name="text"/>
	<xsl:copy-of select="$text"/>
	<xsl:text> (</xsl:text>
	<a>
	<xsl:attribute name="href"><xsl:text>#</xsl:text><xsl:value-of select="$headword"/></xsl:attribute>
	<xsl:value-of select="$headword"/>
	</a>
	<xsl:text>)</xsl:text>

</xsl:template>

<xsl:template name="out-link-direct">
	<xsl:param name="headword"/>
	<a>
	<xsl:attribute name="href"><xsl:text>#</xsl:text><xsl:value-of select="$headword"/></xsl:attribute>
	<xsl:value-of select="$headword"/>
	</a>
</xsl:template>

</xsl:stylesheet>
