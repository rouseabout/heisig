<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- cache some frequently used xpaths -->
<xsl:variable name="allframes" select="/document/book/*/page/frame"/>
<xsl:variable name="allframes-character" select="$allframes[@number]"/>
<xsl:variable name="allframes-primitive" select="$allframes[not(@number)]"/>
<xsl:variable name="allpselfs" select="$allframes/descendant::pself"/>

<xsl:template name="get-keyword">
	<xsl:choose>
		<xsl:when test="@keyword">
			<xsl:apply-templates select="@keyword" mode="always"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates select="text()"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<!-- list-of-keywords -->
<xsl:template match="pself|cite" mode="list-of-keywords">
	<xsl:variable name="name" select="name(.)"/>
	<xsl:variable name="keyword">
		<xsl:call-template name="get-keyword"/>
	</xsl:variable>
	<xsl:variable name="previous-nodes" select="(preceding-sibling::node()|(ancestor::primitive|ancestor::p)/preceding-sibling::p/descendant::node())[name()=$name]"/>
	<xsl:if test="not($previous-nodes[@keyword=$keyword or (not(@keyword) and text()=$keyword)])">
		<xsl:if test="$previous-nodes">
			<xsl:text>; </xsl:text>
		</xsl:if>
		<xsl:value-of select="$keyword"/>
	</xsl:if>
</xsl:template>

<!-- return the character coresponding to a cite or info element -->
<xsl:template name="get-character">
	<xsl:variable name="keyword">
		<xsl:call-template name="get-keyword"/>
	</xsl:variable>
	<xsl:variable name="node-character" select="$allframes-character[@keyword=$keyword]"/>
	<xsl:variable name="node-primitive" select="$allframes-primitive[@keyword=$keyword]|$allpselfs[(@keyword=$keyword or (not(@keyword) and text()=$keyword))][ancestor::frame/@keyword!=$keyword]"/>

	<xsl:choose>
		<xsl:when test="@type='character'">
			<xsl:if test="not($node-character)">
				<xsl:message terminate="yes">
					<xsl:value-of select="ancestor::frame/@character"/>: node-character missing <xsl:value-of select="$keyword"/>
				</xsl:message>
			</xsl:if>
			<xsl:value-of select="$node-character/@character"/>
		</xsl:when>
		<xsl:when test="@type='primitive'">
			<xsl:if test="not($node-primitive)">
				<xsl:message terminate="yes">
					<xsl:value-of select="ancestor::frame/@character"/>: node-primitive missing <xsl:value-of select="$keyword"/>
				</xsl:message>
			</xsl:if>
			<xsl:value-of select="$node-primitive/ancestor-or-self::frame/@character"/>
		</xsl:when>
		<xsl:when test="count($allframes[@keyword=$keyword or descendant::pself[@keyword=$keyword or (not(@keyword) and text()=$keyword)]]) &gt; 1">
			<xsl:message terminate="no">
				<xsl:value-of select="ancestor::frame/@character"/>: keyword '<xsl:value-of select="$keyword"/><xsl:text>' exists in multiple frames:</xsl:text>
					<xsl:for-each select="$node-character|$node-primitive">
					<xsl:text> </xsl:text>
					<xsl:value-of select="ancestor-or-self::frame/@number"/>
					<xsl:text> (</xsl:text>
					<xsl:value-of select="ancestor-or-self::frame/@character"/>
					<xsl:text>)</xsl:text>
					<xsl:value-of select="name(.)"/>
				</xsl:for-each>
				<xsl:text>.</xsl:text>
			</xsl:message>
		</xsl:when>
		<xsl:when test="$node-character">
			<xsl:value-of select="$node-character/@character"/>
		</xsl:when>
		<xsl:when test="$node-primitive">
			<xsl:value-of select="$node-primitive/ancestor-or-self::frame/@character"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:message><xsl:value-of select="ancestor::frame/@character"/>: broken link (<xsl:value-of select="$keyword"/>).</xsl:message>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<!-- convert numbered-pinyin to pinyin-with-tone-marks -->

<xsl:variable name="tokens" select="tokenize('a e o A E O', '\s+')"/>

<xsl:variable name="map">
	<tone alpha="a" mark="āáǎà"/>
	<tone alpha="e" mark="ēéěè"/>
	<tone alpha="i" mark="īíǐì"/>
	<tone alpha="o" mark="ōóǒò"/>
	<tone alpha="u" mark="ūúǔù"/>
	<tone alpha="ü" mark="ǖǘǚǜ"/>
	<tone alpha="A" mark="ĀÁǍÀ"/>
	<tone alpha="E" mark="ĒÉĚÈ"/>
	<tone alpha="I" mark="ĪÍǏÌ"/>
	<tone alpha="O" mark="ŌÓǑÒ"/>
	<tone alpha="U" mark="ŪÚǓÙ"/>
	<tone alpha="Ü" mark="ǕǗǙǛ"/>
</xsl:variable>

<xsl:template match="pinyin[text()='hm' or text()='hng' or text()='n' or text()='ng']" mode="number2mark">
	<xsl:value-of select="text()"/>
</xsl:template>

<xsl:template match="pinyin" mode="number2mark">
	<xsl:analyze-string select="text()" regex="([ywbpmfdtnlgkhjqxrzcs]h?){{0,1}}([aeiouüvÜ]{{1,3}})(n?g?r?)([012345]){{0,1}}">
		<xsl:matching-substring>
			<xsl:value-of select="regex-group(1)"/>
			<xsl:variable name="final" select="translate(regex-group(2),'vV','üÜ')"/>
			<xsl:choose>
				<xsl:when test="regex-group(4)='5' or regex-group(4)=''">
					<xsl:value-of select="$final"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:variable name="pos" select="number(string-length($final)>1 and not(index-of($tokens, substring($final, 1, 1)))) + 1"/>
					<xsl:variable name="rep" select="substring($map/tone[@alpha=substring($final, $pos, 1)]/@mark, number(regex-group(4)), 1)"/>
					<xsl:value-of select="concat(substring($final, 1, $pos - 1), $rep, substring($final, $pos + 1, string-length($final) - $pos))"/>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:value-of select="regex-group(3)"/>
		</xsl:matching-substring>
		<xsl:non-matching-substring>
			<xsl:message terminate="yes">malformed pinyin <xsl:value-of select="."/></xsl:message>
		</xsl:non-matching-substring>
	</xsl:analyze-string>
</xsl:template>

<!-- if missing, append '0' to pinyin pronunication -->

<xsl:template match="pinyin[text()='hm' or text()='hng' or text()='n' or text()='ng']" mode="normalize-zero">
	<xsl:value-of select="text()"/>
	<xsl:text>0</xsl:text>
</xsl:template>

<xsl:template match="pinyin" mode="normalize-zero">
	<xsl:analyze-string select="text()" regex="([ywbpmfdtnlgkhjqxrzcs]h?){{0,1}}([aeiouüvÜ]{{1,3}})(n?g?r?)([012345]){{0,1}}">
		<xsl:matching-substring>
			<xsl:value-of select="regex-group(1)"/>
			<xsl:value-of select="regex-group(2)"/>
			<xsl:value-of select="regex-group(3)"/>
			<xsl:value-of select="regex-group(4)"/>
			<xsl:if test="regex-group(4)=''">
				<xsl:text>0</xsl:text>
			</xsl:if>
		</xsl:matching-substring>
		<xsl:non-matching-substring>
			<xsl:message terminate="yes">malformed pinyin <xsl:value-of select="."/></xsl:message>
		</xsl:non-matching-substring>
	</xsl:analyze-string>
</xsl:template>

</xsl:stylesheet>
