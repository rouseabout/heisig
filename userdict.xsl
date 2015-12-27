<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE ebook [
	<!ENTITY pleco-newline "&#xEAB1;">
	<!ENTITY pleco-bold-open "&#xEAB2;">
	<!ENTITY pleco-bold-close "&#xEAB3;">
	<!ENTITY pleco-italic-open "&#xEAB4;">
	<!ENTITY pleco-italic-close "&#xEAB5;">
	<!ENTITY pleco-underline-open "&#xEAB6;">
	<!ENTITY pleco-underline-close "&#xEAB7;">
	<!ENTITY pleco-link-open "&#xEAB8;">
	<!--
	Note, when there are only puctuation characters between 'pleco-link-close'
	and the next 'pleco-italic-open', Pleco ignores the italic command.
	Solution: place a zero-width-space character (0x200B) immediately after
	'pleco-link-close' command. Tested with Pleco 3.2.23/Android. -->
	<!ENTITY pleco-link-close "&#xEABB;&#x200B;">
	<!ENTITY pleco-invert-open "&#xEABC;">
	<!ENTITY pleco-invert-close "&#xEABD;">
	<!ENTITY pleco-altfont-open "&#xEABE;">
	<!ENTITY pleco-altfont-close "&#xEABF;">
	<!ENTITY pleco-color-open "&#xEAC1;"><!-- followed by two octet parameters -->
	<!ENTITY pleco-color-close "&#xEAC2;">
	<!ENTITY pleco-block-open "&#xEAC3;"><!-- followed by two octet parameters -->
	<!ENTITY pleco-block-close "&#xEAC4;">
	<!ENTITY pleco-size-open "&#xEAC5;"><!-- followed by two octet parameters (font size, unknown) -->
	<!ENTITY pleco-size-close "&#xEAC6;">
	<!ENTITY pleco-hr "&#xEAC7;"><!-- followed by two octet parameters -->
]>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:param name="config-pinyin" select="config-pinyin"/>

	<xsl:include href="ebook.xsl"/>

	<xsl:output method="text" encoding="utf-8"/>

	<xsl:template name="out-doc">
		<xsl:param name="text"/>
		<xsl:param name="title"/>
		<xsl:text>//</xsl:text>
		<xsl:value-of select="$title"/>
		<xsl:text>&#xa;</xsl:text>
		<xsl:copy-of select="$text"/>
	</xsl:template>

	<xsl:template name="userdict-entry">
		<xsl:param name="headword"/>
		<xsl:param name="pinyin"/>
		<xsl:param name="text"/>
		<xsl:value-of select="$headword"/>
		<xsl:text>&#x9;</xsl:text>
		<xsl:value-of select="$pinyin"/>
		<xsl:text>&#x9;</xsl:text>
		<xsl:copy-of select="$text"/>
		<xsl:text>&#xa;</xsl:text>
	</xsl:template>

	<xsl:template name="out-section">
		<xsl:param name="headword"/>
		<xsl:param name="title"/>
		<xsl:param name="text"/>
		<xsl:call-template name="userdict-entry">
			<xsl:with-param name="headword" select="$headword"/>
			<xsl:with-param name="text">
				<xsl:copy-of select="$title"/>
				<xsl:text>&pleco-newline;</xsl:text>
				<xsl:copy-of select="$text"/>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="internal-out-frame">
		<xsl:param name="headword"/>
		<xsl:param name="pinyin"/>
		<xsl:param name="keywords"/>
		<xsl:param name="text"/>
		<xsl:call-template name="userdict-entry">
			<xsl:with-param name="headword" select="$headword"/>
			<xsl:with-param name="pinyin" select="$pinyin"/>
			<xsl:with-param name="text">
				<xsl:copy-of select="$keywords"/>
				<xsl:text>&pleco-newline;</xsl:text>
				<xsl:copy-of select="$text"/>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="out-frame">
		<xsl:param name="headword"/>
		<xsl:param name="pinyin"/>
		<xsl:param name="keywords"/>
		<xsl:param name="text"/>
		<xsl:choose>
			<xsl:when test="$config-pinyin and $pinyin">
				<xsl:for-each select="$pinyin">
					<xsl:call-template name="internal-out-frame">
						<xsl:with-param name="headword" select="$headword"/>
						<xsl:with-param name="pinyin" select="text()"/>
						<xsl:with-param name="keywords" select="$keywords"/>
						<xsl:with-param name="text" select="$text"/>
					</xsl:call-template>
				</xsl:for-each>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="internal-out-frame">
					<xsl:with-param name="headword" select="$headword"/>
					<!-- pinyin leave blank -->
					<xsl:with-param name="keywords" select="$keywords"/>
					<xsl:with-param name="text" select="$text"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="out-p">
		<xsl:param name="text"/>
		<xsl:text>&pleco-block-open;@@</xsl:text>
		<xsl:copy-of select="$text"/>
		<xsl:text>&pleco-block-close;</xsl:text>
	</xsl:template>

	<xsl:template name="out-br">
		<xsl:text>&pleco-newline;</xsl:text>
	</xsl:template>

	<xsl:template name="out-i">
		<xsl:param name="text"/>
		<xsl:text>&pleco-italic-open;</xsl:text>
		<xsl:copy-of select="$text"/>
		<xsl:text>&pleco-italic-close;</xsl:text>
	</xsl:template>

	<xsl:template name="out-b">
		<xsl:param name="text"/>
		<xsl:text>&pleco-bold-open;</xsl:text>
		<xsl:copy-of select="$text"/>
		<xsl:text>&pleco-bold-close;</xsl:text>
	</xsl:template>

	<xsl:template name="out-superscript">
		<!-- FIXME: superscript font -->
		<xsl:param name="text"/>
		<xsl:copy-of select="$text"/>
	</xsl:template>

	<xsl:template name="out-em">
		<!-- FIXME: fixed-with font -->
		<xsl:param name="text"/>
		<xsl:text>&pleco-altfont-open;</xsl:text>
		<xsl:copy-of select="$text"/>
		<xsl:text>&pleco-altfont-close;</xsl:text>
	</xsl:template>

	<xsl:template name="out-schema">
		<xsl:param name="text"/>
		<xsl:text>&pleco-altfont-open;</xsl:text>
		<xsl:copy-of select="$text"/>
		<xsl:text>&pleco-altfont-close;</xsl:text>
	</xsl:template>

	<xsl:template name="out-www">
		<xsl:param name="text"/>
		<xsl:text>&lt;</xsl:text>
		<xsl:copy-of select="$text"/>
		<xsl:text>&gt;</xsl:text>
	</xsl:template>

	<xsl:template name="out-link">
		<xsl:param name="headword"/>
		<xsl:param name="text"/>
		<xsl:value-of select="$text"/>
		<xsl:text> (&pleco-link-open;</xsl:text>
		<xsl:value-of select="$headword"/>
		<xsl:text>&pleco-link-close;)</xsl:text>
	</xsl:template>

	<xsl:template name="out-link-direct">
		<xsl:param name="headword"/>
		<xsl:text>&pleco-link-open;</xsl:text>
		<xsl:value-of select="$headword"/>
		<xsl:text>&pleco-link-close;</xsl:text>
	</xsl:template>

</xsl:stylesheet>
