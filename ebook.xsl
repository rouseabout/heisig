<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:variable name="reading" select="document('reading.xml')"/>

<xsl:template match="document">
	<xsl:call-template name="out-doc">
		<xsl:with-param name="title" select="@title"/>
		<xsl:with-param name="text">
			<xsl:apply-templates select="." mode="series"/>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<!-- make-headword -->

<xsl:template match="document" mode="make-headword">
	<xsl:text>怎么记住简体汉字</xsl:text>
</xsl:template>

<xsl:template match="book" mode="make-headword">
	<xsl:text>本书</xsl:text>
	<xsl:value-of select="@number"/>
</xsl:template>

<xsl:template match="introduction" mode="make-headword">
	<xsl:apply-templates select="ancestor::book" mode="make-headword"/>
	<xsl:text>介绍</xsl:text>
</xsl:template>

<xsl:template match="lesson" mode="make-headword">
	<xsl:apply-templates select="ancestor::book" mode="make-headword"/>
	<xsl:text>第</xsl:text>
	<xsl:value-of select="@number"/>
	<xsl:text>课</xsl:text>
</xsl:template>

<xsl:template match="compounds" mode="make-headword">
	<xsl:apply-templates select="ancestor::book" mode="make-headword"/>
	<xsl:text>符合</xsl:text>
</xsl:template>

<xsl:template match="postscript" mode="make-headword">
	<xsl:apply-templates select="ancestor::book" mode="make-headword"/>
	<xsl:text>第</xsl:text>
	<xsl:value-of select="@number"/>
	<xsl:text>跋</xsl:text>
</xsl:template>

<xsl:template match="index" mode="make-headword">
	<xsl:apply-templates select="ancestor::book" mode="make-headword"/>
	<xsl:text>第</xsl:text>
	<xsl:value-of select="@number"/>
	<xsl:text>个索引</xsl:text>
</xsl:template>

<xsl:template match="blurb" mode="make-headword">
	<xsl:apply-templates select="ancestor::book" mode="make-headword"/>
	<xsl:text>护封</xsl:text>
</xsl:template>

<xsl:template match="frame" mode="make-headword">
	<xsl:value-of select="@character"/>
</xsl:template>

<!-- make-title -->

<xsl:template match="document" mode="make-title">
	<xsl:text>Series</xsl:text>
</xsl:template>

<xsl:template match="book" mode="make-title">
	<xsl:text>Book </xsl:text>
	<xsl:value-of select="@number"/>
</xsl:template>

<xsl:template match="introduction" mode="make-title">
	<xsl:text>Introduction</xsl:text>
</xsl:template>

<xsl:template match="lesson" mode="make-title">
	<xsl:text>Lesson </xsl:text>
	<xsl:value-of select="@number"/>
</xsl:template>

<xsl:template match="compounds" mode="make-title">
	<xsl:text>Compounds</xsl:text>
</xsl:template>

<xsl:template match="postscript" mode="make-title">
	<xsl:text>Postscript </xsl:text>
	<xsl:value-of select="@number"/>
</xsl:template>

<xsl:template match="index" mode="make-title">
	<xsl:text>Index </xsl:text>
	<xsl:number value="number(@number)" format="I"/>
</xsl:template>

<xsl:template match="blurb" mode="make-title">
	<xsl:text>Blurb</xsl:text>
</xsl:template>

<xsl:template match="frame" mode="make-title">
	<xsl:if test="not(@number)">
		<xsl:text>❖ </xsl:text>
	</xsl:if>
	<xsl:value-of select="@keyword"/>
</xsl:template>

<!-- series -->

<xsl:template match="document" mode="series">
	<xsl:call-template name="out-section">
		<xsl:with-param name="headword">
			<xsl:apply-templates select="." mode="make-headword"/>
		</xsl:with-param>
		<xsl:with-param name="title">
			<xsl:value-of select="@title"/>
		</xsl:with-param>
		<xsl:with-param name="text">
			<xsl:call-template name="out-p">
				<xsl:with-param name="text">
					<xsl:value-of select="@author"/>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:apply-templates select="*" mode="make-link-p"/>
		</xsl:with-param>
	</xsl:call-template>
	<xsl:apply-templates select="book"/>

	<xsl:apply-templates select="index"/>
</xsl:template>

<xsl:template match="*" mode="make-link-p">
	<xsl:call-template name="out-p">
		<xsl:with-param name="text">
			<xsl:apply-templates select="." mode="make-link"/>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<xsl:template match="*" mode="make-link">
	<xsl:call-template name="out-link">
		<xsl:with-param name="headword">
			<xsl:apply-templates select="." mode="make-headword"/>
		</xsl:with-param>
		<xsl:with-param name="text">
			<xsl:if test="@number">
				<xsl:value-of select="@number"/>
				<xsl:text>. </xsl:text>
			</xsl:if>
			<xsl:apply-templates select="." mode="make-title"/>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<xsl:template match="*" mode="make-link-left">
	<xsl:call-template name="out-link">
		<xsl:with-param name="headword">
			<xsl:apply-templates select="." mode="make-headword"/>
		</xsl:with-param>
		<xsl:with-param name="text">
			<xsl:text>«</xsl:text>
			<xsl:apply-templates select="." mode="make-title"/>
			<xsl:text>«</xsl:text>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<xsl:template match="*" mode="make-link-right">
	<xsl:call-template name="out-link">
		<xsl:with-param name="headword">
			<xsl:apply-templates select="." mode="make-headword"/>
		</xsl:with-param>
		<xsl:with-param name="text">
			<xsl:text>»</xsl:text>
			<xsl:apply-templates select="." mode="make-title"/>
			<xsl:text>»</xsl:text>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<xsl:template match="*" mode="make-link-up">
	<xsl:call-template name="out-link">
		<xsl:with-param name="headword">
			<xsl:apply-templates select="." mode="make-headword"/>
		</xsl:with-param>
		<xsl:with-param name="text">
			<xsl:text>↑</xsl:text>
			<xsl:apply-templates select="." mode="make-title"/>
			<xsl:text>↑</xsl:text>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<!-- book -->

<xsl:template match="book">
	<xsl:call-template name="out-section">
		<xsl:with-param name="headword">
			<xsl:apply-templates select="." mode="make-headword"/>
		</xsl:with-param>
		<xsl:with-param name="title">
			<xsl:value-of select="/document/@title"/>
			<xsl:text>, </xsl:text>
			<xsl:apply-templates select="." mode="make-title"/>
		</xsl:with-param>
		<xsl:with-param name="text">
			<xsl:apply-templates select="*" mode="make-link-p"/>
			<xsl:apply-templates select="." mode="make-navigation"/>
		</xsl:with-param>
	</xsl:call-template>
	<xsl:apply-templates select="*"/>
</xsl:template>

<!-- section -->

<xsl:template match="*" mode="make-navigation">
	<xsl:if test="preceding-sibling::* or following-sibling::*">
		<xsl:call-template name="out-p">
			<xsl:with-param name="text">
				<xsl:call-template name="out-schema">
					<xsl:with-param name="text">NAVIGATION</xsl:with-param>
				</xsl:call-template>
				<xsl:text> </xsl:text>
				<xsl:apply-templates select="parent::*" mode="make-link-up"/>
				<xsl:if test="preceding-sibling::*">
					<xsl:text> </xsl:text>
					<xsl:apply-templates select="preceding-sibling::*[1]" mode="make-link-left"/>
				</xsl:if>
				<xsl:if test="following-sibling::*">
					<xsl:text> </xsl:text>
					<xsl:apply-templates select="following-sibling::*[1]" mode="make-link-right"/>
				</xsl:if>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
</xsl:template>

<!-- make hyperlink to equivalent section (introduction/lesson/blurb) in other book -->

<xsl:template match="introduction|blurb" mode="make-navigation-other-book">
	<xsl:variable name="book" select="parent::book/@number"/>
	<xsl:variable name="name" select="name(.)"/>
	<xsl:call-template name="make-navigation-other-book-internal">
		<xsl:with-param name="prev" select="/document/book[@number=$book - 1]/*[name()=$name]"/>
		<xsl:with-param name="next" select="/document/book[@number=$book + 1]/*[name()=$name]"/>
	</xsl:call-template>
</xsl:template>

<xsl:template match="lesson" mode="make-navigation-other-book">
	<xsl:variable name="book" select="parent::book/@number"/>
	<xsl:variable name="lesson" select="@number"/>
	<xsl:call-template name="make-navigation-other-book-internal">
		<xsl:with-param name="prev" select="/document/book[@number=$book - 1]/lesson[@number=$lesson]"/>
		<xsl:with-param name="next" select="/document/book[@number=$book + 1]/lesson[@number=$lesson]"/>
	</xsl:call-template>
</xsl:template>

<!-- don't add 'other book' navigation to other elements (that aren't lessons) -->
<xsl:template match="*" mode="make-navigation-other-book"/>

<xsl:template name="make-navigation-other-book-internal">
	<xsl:param name="prev"/>
	<xsl:param name="next"/>
	<xsl:if test="$prev or $next">
		<xsl:call-template name="out-p">
			<xsl:with-param name="text">
				<xsl:call-template name="out-schema">
					<xsl:with-param name="text">OTHER BOOK</xsl:with-param>
				</xsl:call-template>
				<xsl:if test="$prev">
					<xsl:text> </xsl:text>
					<xsl:apply-templates select="$prev" mode="make-link-left"/>
				</xsl:if>
				<xsl:if test="$next">
					<xsl:text> </xsl:text>
					<xsl:apply-templates select="$next" mode="make-link-right"/>
				</xsl:if>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
</xsl:template>

<xsl:template match="introduction|lesson|compounds|postscript|blurb">
	<xsl:message><xsl:apply-templates select="." mode="make-headword"/></xsl:message>
	<xsl:call-template name="out-section">
		<xsl:with-param name="headword">
			<xsl:apply-templates select="." mode="make-headword"/>
		</xsl:with-param>
		<xsl:with-param name="title">
			<xsl:apply-templates select="ancestor::book" mode="make-title"/>
			<xsl:text>, </xsl:text>
			<xsl:apply-templates select="." mode="make-title"/>
		</xsl:with-param>
		<xsl:with-param name="text">
			<xsl:apply-templates select="page/frame|page/text|text" mode="section-body"/>
			<xsl:apply-templates select="." mode="make-navigation"/>
			<xsl:apply-templates select="." mode="make-navigation-other-book"/>
		</xsl:with-param>
	</xsl:call-template>
	<xsl:apply-templates select="page/frame"/>
</xsl:template>

<xsl:template match="text" mode="section-body">
	<xsl:apply-templates select="*"/>
</xsl:template>

<xsl:template match="frame" mode="section-body">
	<xsl:apply-templates select="." mode="make-link-p"/>
</xsl:template>

<!-- frame -->

<xsl:template match="frame">
	<xsl:variable name="character" select="@character"/>
	<xsl:variable name="entry" select="$reading/dict/entry[@simplified=$character]"/>
	<xsl:variable name="pinyin" select="$entry/pinyin"/>
	<xsl:variable name="jyutping" select="$entry/jyutping"/>
	<xsl:call-template name="out-frame">
		<xsl:with-param name="headword" select="@character"/>
		<xsl:with-param name="pinyin" select="$pinyin"/>
		<xsl:with-param name="keywords">
			<xsl:apply-templates select="." mode="make-title"/>
			<xsl:if test="@pos">
				<xsl:text> </xsl:text>
				<xsl:call-template name="out-superscript">
					<xsl:with-param name="text">
						<xsl:text>(</xsl:text>
						<xsl:value-of select="@pos"/>
						<xsl:text>)</xsl:text>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="descendant::pself">
				<xsl:choose>
					<xsl:when test="@number">
						<xsl:text> ❖ </xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>; </xsl:text>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:apply-templates select="descendant::pself" mode="list-of-keywords"/>
			</xsl:if>
		</xsl:with-param>
		<xsl:with-param name="text">

			<xsl:if test="$pinyin or $jyutping">
				<xsl:call-template name="out-p">
					<xsl:with-param name="text">
						<xsl:if test="$pinyin">
							<xsl:call-template name="out-schema">
								<xsl:with-param name="text">PINYIN</xsl:with-param>
							</xsl:call-template>
							<xsl:text> </xsl:text>
							<xsl:apply-templates select="$pinyin" mode="list-of-pinyin"/>
						</xsl:if>
						<xsl:if test="$jyutping and $pinyin">
							<xsl:text> </xsl:text>
						</xsl:if>
						<xsl:if test="$jyutping">
							<xsl:call-template name="out-schema">
								<xsl:with-param name="text">JYUTPING</xsl:with-param>
							</xsl:call-template>
							<xsl:text> </xsl:text>
							<xsl:apply-templates select="$jyutping" mode="list-of-pinyin"/>
						</xsl:if>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>

			<xsl:if test="descendant::cite">
				<xsl:call-template name="out-p">
					<xsl:with-param name="text">
						<xsl:call-template name="out-schema">
							<xsl:with-param name="text">ELEMENTS</xsl:with-param>
						</xsl:call-template>
						<xsl:text> </xsl:text>
						<xsl:apply-templates select="descendant::cite" mode="list-of-keyword-hyperlinks"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>

			<xsl:if test="descendant::variant">
				<xsl:call-template name="out-p">
					<xsl:with-param name="text">
						<xsl:call-template name="out-schema">
							<xsl:with-param name="text">VARIANTS</xsl:with-param>
						</xsl:call-template>
						<xsl:text> </xsl:text>
						<xsl:apply-templates select="descendant::variant[1]" mode="list-of-variants"/>
						<xsl:apply-templates select="descendant::variant[position() != 1]" mode="list-of-variants-sep"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>

			<xsl:apply-templates select="p"/>

			<xsl:apply-templates select="primitive"/>

			<xsl:if test="descendant::info">
				<xsl:call-template name="out-p">
					<xsl:with-param name="text">
						<xsl:call-template name="out-schema">
							<xsl:with-param name="text">SEE ALSO</xsl:with-param>
						</xsl:call-template>
						<xsl:text> </xsl:text>
						<xsl:apply-templates select="descendant::info" mode="list-of-keyword-hyperlinks"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>

			<xsl:call-template name="out-p">
				<xsl:with-param name="text">
					<xsl:choose>
						<xsl:when test="@number">
							<xsl:call-template name="out-schema">
								<xsl:with-param name="text">FRAME</xsl:with-param>
							</xsl:call-template>
							<xsl:text> </xsl:text>
							<xsl:value-of select="@number"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="out-schema">
								<xsl:with-param name="text">❖ PRIMITIVE</xsl:with-param>
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:text>, </xsl:text>
					<xsl:choose>
						<xsl:when test="ancestor::lesson">
							<xsl:call-template name="out-schema">
								<xsl:with-param name="text">LESSON</xsl:with-param>
							</xsl:call-template>
							<xsl:text> </xsl:text>
							<xsl:value-of select="ancestor::lesson/@number"/>
						</xsl:when>
						<xsl:when test="ancestor::compounds">
							<xsl:call-template name="out-schema">
								<xsl:with-param name="text">COMPOUNDS</xsl:with-param>
							</xsl:call-template>
							<xsl:text> </xsl:text>
						</xsl:when>
						<xsl:when test="ancestor::postscript">
							<xsl:call-template name="out-schema">
								<xsl:with-param name="text">POSTSCRIPT</xsl:with-param>
							</xsl:call-template>
							<xsl:text> </xsl:text>
							<xsl:value-of select="ancestor::postscript/@number"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:message terminate="yes"><xsl:value-of select="@character"/>: cannot find lesson/compounds/postscript ancestor</xsl:message>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:text>, </xsl:text>
					<xsl:call-template name="out-schema">
						<xsl:with-param name="text">BOOK</xsl:with-param>
					</xsl:call-template>
					<xsl:text> </xsl:text>
					<xsl:value-of select="ancestor::book/@number"/>
					<xsl:text>, </xsl:text>
					<xsl:call-template name="out-schema">
						<xsl:with-param name="text">PAGE</xsl:with-param>
					</xsl:call-template>
					<xsl:text> </xsl:text>
					<xsl:value-of select="ancestor::page/@number"/>
				</xsl:with-param>
			</xsl:call-template>

			<!-- generate hyperlinks to previous/next frame -->
			<xsl:call-template name="out-p">
				<xsl:with-param name="text">
					<xsl:call-template name="out-schema">
						<xsl:with-param name="text">NAVIGATION</xsl:with-param>
					</xsl:call-template>
					<xsl:text> </xsl:text>
					<xsl:apply-templates select="ancestor::lesson|ancestor::compounds|ancestor::postscript" mode="make-link-up"/>

					<xsl:if test="@number">
						<xsl:variable name="number" select="number(@number)"/>
						<xsl:if test="$allframes-character[@number=number(($number)-1)]">
							<xsl:text> </xsl:text>
							<xsl:apply-templates select="$allframes-character[number(@number)=$number -1]" mode="make-link-left"/>
						</xsl:if>
						<xsl:if test="$allframes-character[@number=number(($number)+1)]">
							<xsl:text> </xsl:text>
							<xsl:apply-templates select="$allframes-character[number(@number)=$number + 1]" mode="make-link-right"/>
						</xsl:if>
					</xsl:if>
				</xsl:with-param>
			</xsl:call-template>

		</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<xsl:template match="primitive">
	<xsl:apply-templates select="p"/>
</xsl:template>

<xsl:template match="variant" mode="paragraph">
	<xsl:apply-templates select="text()"/>
</xsl:template>

<xsl:template match="p">
	<xsl:call-template name="out-p">
		<xsl:with-param name="text">
			<xsl:if test="parent::frame and not(preceding-sibling::p)">
				<xsl:call-template name="out-schema">
					<xsl:with-param name="text">
						<xsl:text>STORY</xsl:text>
					</xsl:with-param>
				</xsl:call-template>
			<xsl:text> </xsl:text>
			</xsl:if>
			<xsl:if test="parent::primitive and not(preceding-sibling::p)">
				<xsl:text>❖ </xsl:text>
			</xsl:if>
			<xsl:apply-templates select="*|text()" mode="paragraph"/>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<!-- FIXME: do something meaningful with these elements -->
<xsl:template match="info-page|cite-page|cite-lesson|cite-book|cite-index" mode="paragraph">
	<xsl:value-of select="text()"/>
</xsl:template>

<xsl:template match="em" mode="paragraph">
	<xsl:call-template name="out-em">
		<xsl:with-param name="text" select="text()"/>
	</xsl:call-template>
</xsl:template>

<xsl:template match="i" mode="paragraph">
	<xsl:call-template name="out-i">
		<xsl:with-param name="text" select="text()"/>
	</xsl:call-template>
</xsl:template>

<xsl:template match="www" mode="paragraph">
	<xsl:call-template name="out-www">
		<xsl:with-param name="text" select="text()"/>
	</xsl:call-template>
</xsl:template>

<!-- paragraph -->

<xsl:template match="self" mode="paragraph">
	<xsl:variable name="keyword">
		<xsl:call-template name="get-keyword"/>
	</xsl:variable>
	<xsl:if test="ancestor::frame/@keyword!=$keyword">
		<xsl:message><xsl:value-of select="ancestor::frame/@character"/>: self keyword (<xsl:value-of select="$keyword"/>) does not match frame/@keyword (<xsl:value-of select="ancestor::frame/@keyword"/>).</xsl:message>
	</xsl:if>
	<xsl:call-template name="out-b">
		<xsl:with-param name="text" select="text()"/>
	</xsl:call-template>
</xsl:template>

<xsl:template match="pself" mode="paragraph">
	<xsl:variable name="keyword">
		<xsl:call-template name="get-keyword"/>
	</xsl:variable>
	<xsl:if test="ancestor::frame[not(@number)]/@keyword=$keyword">
		<xsl:message><xsl:value-of select="ancestor::frame/@character"/>: pself keyword (<xsl:value-of select="$keyword"/>) matches frame/@keyword (<xsl:value-of select="ancestor::frame/@keyword"/>).</xsl:message>
	</xsl:if>
	<xsl:if test="text()">
		<xsl:call-template name="out-i">
			<xsl:with-param name="text" select="text()"/>
		</xsl:call-template>
	</xsl:if>
</xsl:template>

<xsl:template match="count" mode="paragraph">
	<xsl:text>[</xsl:text>
	<xsl:apply-templates select="ancestor::frame/strokes[1]"/>
	<xsl:apply-templates select="ancestor::frame/strokes[position() != 1]" mode="sep"/>
	<xsl:text>]</xsl:text>
</xsl:template>

<xsl:template match="strokes" mode="sep">
	<xsl:text>,</xsl:text>
	<xsl:value-of select="text()"/>
</xsl:template>

<xsl:template match="cite|info" mode="paragraph">
	<xsl:param name="keyword-hyperlinks" />
	<xsl:choose>
		<xsl:when test="$keyword-hyperlinks">
			<xsl:variable name="keyword">
				<xsl:call-template name="get-keyword"/>
			</xsl:variable>

			<!-- if the text is a number, then check that it corresponds to the keyword -->
			<xsl:if test="number(.)=number(.)">
				<xsl:variable name="number" select="text()"/>
				<xsl:if test="not($allframes-character[@number=$number][@keyword=$keyword]) and not($allframes-character[@number=$number]/descendant::pself[@keyword=$keyword or (not(@keyword) and text()=$keyword)])">
					<xsl:message terminate="no"><xsl:value-of select="ancestor::frame/@character"/>: <xsl:value-of select="name(.)"/> @keyword=<xsl:value-of select="$keyword"/>, frame number mismatch</xsl:message>
				</xsl:if>
			</xsl:if>

			<xsl:variable name="character">
				<xsl:call-template name="get-character"/>
			</xsl:variable>

			<xsl:if test="ancestor::frame/@character=$character">
				<xsl:message terminate="no"><xsl:value-of select="ancestor::frame/@character"/>: cites itself</xsl:message>
			</xsl:if>

			<xsl:call-template name="out-link">
				<xsl:with-param name="headword" select="$character"/>
				<xsl:with-param name="text">
					<xsl:call-template name="out-i">
						<xsl:with-param name="text">
							<xsl:choose>
								<xsl:when test="$keyword-hyperlinks">
									<xsl:value-of select="$keyword"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="text()"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<xsl:if test="text()">
				<xsl:call-template name="out-i">
					<xsl:with-param name="text" select="text()"/>
				</xsl:call-template>
			</xsl:if>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="variant" mode="hyperlink">
	<xsl:text>,</xsl:text>
	<xsl:value-of select="text()"/>
</xsl:template>

<!-- list-of-keyword-hyperlinks -->

<xsl:template match="cite|info" mode="list-of-keyword-hyperlinks">
	<xsl:variable name="name" select="name(.)"/>
	<xsl:variable name="keyword">
		<xsl:call-template name="get-keyword"/>
	</xsl:variable>
	<xsl:variable name="previous-nodes" select="(preceding-sibling::node()|(ancestor::primitive|ancestor::p)/preceding-sibling::p/descendant::node())[name()=$name]"/>
	<xsl:if test="not($previous-nodes[@keyword=$keyword or (not(@keyword) and text()=$keyword)])">
		<xsl:if test="$previous-nodes">
			<xsl:text>; </xsl:text>
		</xsl:if>
		<xsl:apply-templates select="." mode="paragraph">
			<xsl:with-param name="keyword-hyperlinks">true</xsl:with-param>
		</xsl:apply-templates>
	</xsl:if>
</xsl:template>

<!-- list-of-variants -->

<xsl:template match="variant" mode="list-of-variants">
	<xsl:value-of select="text()"/>
</xsl:template>

<xsl:template match="variant" mode="list-of-variants-sep">
	<xsl:text>, </xsl:text>
	<xsl:value-of select="text()"/>
</xsl:template>

<!-- list-of-pinyin -->

<xsl:template match="pinyin" mode="list-of-pinyin">
	<xsl:if test="position() &gt; 1">
		<xsl:text>, </xsl:text>
	</xsl:if>
	<xsl:apply-templates select="." mode="number2mark"/>
</xsl:template>

<xsl:template match="jyutping" mode="list-of-pinyin">
	<xsl:if test="position() &gt; 1">
		<xsl:text>, </xsl:text>
	</xsl:if>
	<xsl:value-of select="text()"/>
</xsl:template>

<!-- index -->

<xsl:template match="index">
	<xsl:message><xsl:apply-templates select="." mode="make-headword"/></xsl:message>
	<xsl:call-template name="out-section">
		<xsl:with-param name="headword">
			<xsl:apply-templates select="." mode="make-headword"/>
		</xsl:with-param>
		<xsl:with-param name="title">
			<xsl:apply-templates select="." mode="make-title"/>
			<xsl:text> </xsl:text>
			<xsl:value-of select="@title"/>
		</xsl:with-param>
		<xsl:with-param name="text">
			<xsl:apply-templates select="*" mode="section-body"/>
			<xsl:apply-templates select="." mode="make-navigation"/>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<xsl:template match="index-character-by-frame" mode="section-body">
	<xsl:for-each select="$allframes-character">
		<xsl:sort select="@number" data-type="number"/>
		<xsl:apply-templates select="." mode="format-index-character-pinyin-frame"/>
	</xsl:for-each>
</xsl:template>

<xsl:template match="index-pinyin" mode="section-body">
	<!-- FIXME: group by initial -->
	<!-- FIXME: sort by pinyin -->
	<xsl:for-each select="$reading/dict/entry/pinyin">
		<xsl:sort select="text()" lang="zh" />
		<xsl:apply-templates select="." mode="format-index-pinyin"/>
	</xsl:for-each>
</xsl:template>

<!-- FIXME: group by stroke type -->
<xsl:key name="primitive-strokes" match="frame[not(@number)]" use="strokes" />

<xsl:template match="index-primitive-by-stroke" mode="section-body">
	<!-- FIXME: include primitive variants -->
	<xsl:for-each select="$allframes-primitive">
		<xsl:sort select="strokes[1]" data-type="number"/>
		<xsl:variable name="frames" select="key('primitive-strokes', strokes)" />
		<xsl:if test="generate-id() = generate-id($frames[1])">
			<xsl:call-template name="out-p">
				<xsl:with-param name="text">
					<xsl:value-of select="strokes"/>
					<xsl:text>画</xsl:text>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:apply-templates select="$frames" mode="format-index-character-page">
				<xsl:sort select="ancestor::book/@number * 500 + ancestor::page/@number" data-type="number"/>
			</xsl:apply-templates>
		</xsl:if>
	</xsl:for-each>
</xsl:template>

<xsl:key name="character-strokes" match="frame[@number]" use="strokes" />

<xsl:template match="index-character-by-stroke" mode="section-body">
	<xsl:for-each select="$allframes-character">
		<xsl:sort select="strokes[1]" data-type="number"/>
		<xsl:variable name="frames" select="key('character-strokes', strokes)" />
		<xsl:if test="generate-id() = generate-id($frames[1])">
			<xsl:call-template name="out-p">
			<xsl:with-param name="text">
					<xsl:value-of select="strokes"/>
					<xsl:text>画</xsl:text>
				</xsl:with-param>
			</xsl:call-template>
			<!-- FIXME: group by first stroke type -->
			<xsl:apply-templates select="$frames" mode="format-index-character-frame">
				<xsl:sort select="@number" data-type="number"/>
			</xsl:apply-templates>
		</xsl:if>
	</xsl:for-each>
</xsl:template>

<xsl:template match="index-keyword" mode="section-body">
	<xsl:for-each select="$allframes/@keyword|$allpselfs/@keyword|$allpselfs[not(@keyword)]/text()">
		<xsl:sort select="lower-case(.)"/>
		<xsl:apply-templates select="parent::node()" mode="format-index-keyword-all"/>
	</xsl:for-each>
</xsl:template>

<!-- format-index-* -->

<xsl:template match="frame" mode="format-index-character-pinyin-frame">
	<xsl:call-template name="out-p">
		<xsl:with-param name="text">
			<xsl:call-template name="out-link-direct">
				<xsl:with-param name="headword" select="@character"/>
			</xsl:call-template>
			<xsl:text> </xsl:text>
			<xsl:value-of select="pinyin[1]"/>
			<xsl:text> </xsl:text>
			<xsl:value-of select="@number"/>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<xsl:template match="frame" mode="format-index-character-page">
	<xsl:call-template name="out-p">
		<xsl:with-param name="text">
			<xsl:call-template name="out-link-direct">
				<xsl:with-param name="headword" select="@character"/>
			</xsl:call-template>
			<xsl:text> </xsl:text>
			<xsl:value-of select="ancestor::book/@number"/>
			<xsl:text>.</xsl:text>
			<xsl:value-of select="ancestor::page/@number"/>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<xsl:template match="frame" mode="format-index-character-frame">
	<xsl:call-template name="out-p">
		<xsl:with-param name="text">
			<xsl:call-template name="out-link-direct">
				<xsl:with-param name="headword" select="@character"/>
			</xsl:call-template>
			<xsl:text> </xsl:text>
			<xsl:value-of select="@number"/>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<xsl:template match="frame[@number]" mode="format-keyword">
	<xsl:param name="keyword"/>
	<xsl:value-of select="$keyword"/>
</xsl:template>

<xsl:template match="frame[not(@number)]|pself" mode="format-keyword">
	<xsl:param name="keyword"/>
	<xsl:call-template name="out-i">
		<xsl:with-param name="text">
			<xsl:value-of select="$keyword"/>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<xsl:template match="pinyin" mode="format-index-pinyin">
	<xsl:call-template name="out-p">
		<xsl:with-param name="text">
			<xsl:variable name="character" select="parent::entry/@simplified"/>
			<xsl:apply-templates select="." mode="number2mark"/>
			<xsl:text> </xsl:text>
			<xsl:call-template name="out-link-direct">
				<xsl:with-param name="headword" select="$character"/>
			</xsl:call-template>
			<xsl:text> </xsl:text>
			<xsl:value-of select="$allframes-character[@character=$character]/@number"/>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<xsl:template match="*" mode="format-index-common">
	<xsl:param name="keyword"/>
	<xsl:param name="character"/>
	<xsl:call-template name="out-p">
		<xsl:with-param name="text">
			<xsl:apply-templates select="." mode="format-keyword">
				<xsl:with-param name="keyword" select="$keyword"/>
			</xsl:apply-templates>
			<xsl:text> </xsl:text>
			<xsl:call-template name="out-link-direct">
				<xsl:with-param name="headword" select="$character"/>
			</xsl:call-template>
			<xsl:text> </xsl:text>
			<xsl:value-of select="ancestor::book/@number"/>
			<xsl:text>.</xsl:text>
			<xsl:value-of select="ancestor::page/@number"/>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<xsl:template match="frame" mode="format-index-keyword-all">
	<xsl:apply-templates select="." mode="format-index-common">
		<xsl:with-param name="keyword" select="@keyword"/>
		<xsl:with-param name="character" select="@character"/>
	</xsl:apply-templates>
</xsl:template>

<xsl:template match="pself" mode="format-index-keyword-all">
	<xsl:variable name="name" select="name(.)"/>
	<xsl:variable name="keyword">
		<xsl:call-template name="get-keyword"/>
	</xsl:variable>
	<xsl:variable name="previous-nodes" select="(preceding-sibling::node()|(ancestor::primitive|ancestor::p)/preceding-sibling::p/descendant::node())[name()=$name]"/>
	<xsl:if test="not($previous-nodes[@keyword=$keyword or (not(@keyword) and text()=$keyword)])">
		<xsl:apply-templates select="." mode="format-index-common">
			<xsl:with-param name="keyword" select="$keyword"/>
			<xsl:with-param name="character" select="ancestor::frame/@character"/>
		</xsl:apply-templates>
	</xsl:if>
</xsl:template>

<xsl:include href="util.xsl"/>

</xsl:stylesheet>
