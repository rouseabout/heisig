<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE ebook [
        <!ENTITY sep "&#x9;">
]>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:variable name="reading" select="document('reading.xml')"/>
<xsl:variable name="measure" select="document('measure.xml')"/>
<xsl:variable name="surname" select="document('surname.xml')"/>
<xsl:variable name="exclamative" select="document('exclamative.xml')"/>
<xsl:variable name="transcription" select="document('transcription.xml')"/>
<xsl:variable name="traditional" select="document('traditional.xml')"/>

<xsl:output method="text" encoding="utf-8"/>

<xsl:template match="/">
	<xsl:text>#Character&sep;Keyword&sep;Alternate keywords&sep;Components&sep;Stroke count&sep;Heisig number&sep;Lesson number&sep;Book/page number&sep;Pinyin&sep;Pinyin audio&sep;Jyutping&sep;Jyutping audio&sep;Traditional&sep;Measure word&sep;Surname&sep;Exclamative&sep;Transcription&#xa;</xsl:text>
	<xsl:apply-templates select="//frame[@number &lt;= 50000]"/>
</xsl:template>

<xsl:template match="frame">
	<xsl:variable name="character" select="@character"/>
	<xsl:value-of select="@character"/><xsl:text>&sep;</xsl:text>
	<xsl:value-of select="@keyword"/><xsl:if test="@pos"> (<xsl:value-of select="@pos"/>)</xsl:if><xsl:text>&sep;</xsl:text>
	<xsl:if test="descendant::pself">
		<xsl:text>❖ </xsl:text>
		<xsl:apply-templates select="descendant::pself" mode="list-of-keywords"/>
	</xsl:if><xsl:text>&sep;</xsl:text>
	<xsl:apply-templates select="descendant::cite" mode="list-of-keywords"/><xsl:text>&sep;</xsl:text>
	<xsl:apply-templates select="strokes" mode="text"/><xsl:text>&sep;</xsl:text>
	<xsl:value-of select="@number"/><xsl:text>&sep;</xsl:text>
	<xsl:value-of select="ancestor::lesson/@number"/><xsl:text>&sep;</xsl:text>
	<xsl:value-of select="ancestor::book/@number"/><xsl:text>.</xsl:text><xsl:value-of select="ancestor::page/@number"/><xsl:text>&sep;</xsl:text>
	<xsl:variable name="pinyin" select="$reading/dict/entry[@simplified=$character]/pinyin"/>
	<xsl:apply-templates select="$pinyin" mode="text"/><xsl:text>&sep;</xsl:text>
	<xsl:apply-templates select="$pinyin" mode="audio"/><xsl:text>&sep;</xsl:text>
	<xsl:if test="count($pinyin)=0">
		<xsl:message><xsl:value-of select="@character"/><xsl:text> has no pinyin pronunication</xsl:text></xsl:message>
	</xsl:if>
	<xsl:variable name="jyutping" select="$reading/dict/entry[@simplified=$character]/jyutping"/>
	<xsl:apply-templates select="$jyutping" mode="text"/><xsl:text>&sep;</xsl:text>
	<xsl:apply-templates select="$jyutping" mode="audio"/><xsl:text>&sep;</xsl:text>
	<xsl:if test="count($jyutping)=0">
		<xsl:message><xsl:value-of select="@character"/><xsl:text> has no jyutping pronunication</xsl:text></xsl:message>
	</xsl:if>
	<xsl:apply-templates select="$traditional/dict/entry[@simplified=$character]" mode="traditional"/><xsl:text>&sep;</xsl:text>
	<xsl:if test="$measure/dict/entry[@simplified=$character]"><xsl:text>M</xsl:text></xsl:if><xsl:text>&sep;</xsl:text>
	<xsl:if test="$surname/dict/entry[@simplified=$character]"><xsl:text>S</xsl:text></xsl:if><xsl:text>&sep;</xsl:text>
	<xsl:if test="$exclamative/dict/entry[@simplified=$character]"><xsl:text>E</xsl:text></xsl:if><xsl:text>&sep;</xsl:text>
	<xsl:if test="$transcription/dict/entry[@simplified=$character]"><xsl:text>T</xsl:text></xsl:if>
	<xsl:text>&#xa;</xsl:text>
</xsl:template>

<xsl:template match="strokes" mode="text">
	<xsl:if test="position() &gt; 1">
		<xsl:text>,</xsl:text>
	</xsl:if>
	<xsl:value-of select="text()"/>
</xsl:template>

<xsl:template match="pinyin" mode="text">
	<xsl:if test="position() &gt; 1">
		<xsl:text> </xsl:text>
	</xsl:if>
	<xsl:apply-templates select="." mode="number2mark"/>
</xsl:template>

<xsl:template match="jyutping" mode="text">
	<xsl:if test="position() &gt; 1">
		<xsl:text> </xsl:text>
	</xsl:if>
	<xsl:value-of select="text()"/>
</xsl:template>

<xsl:template match="pinyin" mode="audio">
	<xsl:text>[sound:pinyin-</xsl:text>
	<xsl:apply-templates select="." mode="normalize-zero"/>
	<xsl:text>.mp3]</xsl:text>
</xsl:template>

<xsl:template match="jyutping" mode="audio">
        <xsl:text>[sound:jyutping-</xsl:text>
        <xsl:value-of select="text()"/>
        <xsl:text>.mp3]</xsl:text>
</xsl:template>

<xsl:template match="entry" mode="traditional">
	<xsl:value-of select="@traditional"/>
</xsl:template>

<xsl:include href="util.xsl"/>

</xsl:stylesheet>
