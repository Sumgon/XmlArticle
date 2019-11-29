<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:x="http://sumgon.org/Article.xsd" version="1.0" exclude-result-prefixes="x">
  <xsl:output method="html" indent="yes"/>
  <!--上面这行压根没用，加来安慰自己-->
  <xsl:variable name="lowercase" select="'abcdefghijklmnopqrstuvwxyz'"/>
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>

  <xsl:template match="/">
    <html>
      <head>
        <meta charset="utf-8"/>
        <title>
          <xsl:apply-templates select="x:Article/x:Title" mode="TabTitle"/>
        </title>
        <link type="text/css" rel="stylesheet" href="basicStyles.css"/>
        <link type="text/css" rel="stylesheet" href="prism.css"/>
        <xsl:apply-templates select="x:Article/x:StyleSheets"/>
      </head>
      <body>
        <xsl:apply-templates select="x:Article"/>
        <script src="prism.js">prism.js</script>
      </body>
    </html>
  </xsl:template>
  
  <!--Tab Title-->
  <xsl:template match="x:Title" mode="TabTitle">
    <xsl:apply-templates select="text()|x:StyledText|x:LineBreak" mode="TabTitle"/>
  </xsl:template>
  
  <xsl:template match="x:StyledText" mode="TabTitle">    
    <xsl:value-of select="text()"/>
  </xsl:template>

  <xsl:template match="x:LineBreak" mode="TabTitle">
    <xsl:text>/</xsl:text>
  </xsl:template>
  
  <!--End Tab Title-->
  
  <xsl:template match="x:StyleSheets">
    <xsl:apply-templates select="x:StyleSheet"/> 
  </xsl:template>
  
  <xsl:template match="x:StyleSheet">
    <link type="text/css" rel="stylesheet">
      <xsl:attribute name="href">
        <xsl:value-of select="@Source"/>      
      </xsl:attribute>   
    </link> 
  </xsl:template>
  
  <!--Article-->
  <xsl:template match="x:Article">
    <article>
      <xsl:apply-templates select="x:Title"/>
      <xsl:apply-templates select="x:Subtitle"/>
      <xsl:apply-templates select="x:Authors"/>
      <xsl:apply-templates select="x:Abstract"/>
      <xsl:apply-templates select="x:Introduction"/>
      <xsl:apply-templates select="x:Body" mode="Article"/>
      <xsl:apply-templates select="x:References"/>
    </article>
  </xsl:template>
    
  <xsl:template match="x:Title">
    <div>
      <xsl:attribute name="class">
        <xsl:call-template name="UnderlineStyleTypeTemplate">
          <xsl:with-param name="UnderlineStyle" select="preceding-sibling::x:StyleDefinitions/x:TitleStyle/@UnderlineStyle"/>
        </xsl:call-template>
        <xsl:text>title</xsl:text>
      </xsl:attribute>

      <xsl:variable name="ParsedFontSize">
        <xsl:call-template name="FontSizeTypeTemplate">
          <xsl:with-param name="FontSize" select="preceding-sibling::x:StyleDefinitions/x:TitleStyle/@FontSize"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:variable name="ParsedFontFamily">
        <xsl:call-template name="FontFamilyTypeTemplate">
          <xsl:with-param name="FontFamily" select="preceding-sibling::x:StyleDefinitions/x:TitleStyle/@FontFamily"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:variable name="ParsedFontStretch">
        <xsl:call-template name="FontStretchTypeTemplate">
          <xsl:with-param name="FontStretch" select="preceding-sibling::x:StyleDefinitions/x:TitleStyle/@FontStretch"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:variable name="ParsedFontStyle">
        <xsl:call-template name="FontStyleTypeTemplate">
          <xsl:with-param name="FontStyle" select="preceding-sibling::x:StyleDefinitions/x:TitleStyle/@FontStyle"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:variable name="ParsedFontWeight">
        <xsl:call-template name="FontWeightTypeTemplate">
          <xsl:with-param name="FontWeight" select="preceding-sibling::x:StyleDefinitions/x:TitleStyle/@FontWeight"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:variable name="ParsedFontColor">
        <xsl:call-template name="FontColorTypeTemplate">
          <xsl:with-param name="FontColor" select="preceding-sibling::x:StyleDefinitions/x:TitleStyle/@FontColor"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:variable name="ParsedBackgroundColor">
        <xsl:call-template name="BackgroundColorTypeTemplate">
          <xsl:with-param name="BackgroundColor" select="preceding-sibling::x:StyleDefinitions/x:TitleStyle/@BackgroundColor"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:variable name="ParsedLineHeight">
        <xsl:call-template name="LineHeightTypeTemplate">
          <xsl:with-param name="LineHeight" select="preceding-sibling::x:StyleDefinitions/x:TitleStyle/@LineHeight"/>
        </xsl:call-template>
      </xsl:variable>
      
      <xsl:if test="$ParsedFontSize!='' or $ParsedFontFamily!='' or $ParsedFontStretch!='' or $ParsedFontStyle!='' or $ParsedFontWeight!='' or $ParsedFontColor!='' or $ParsedBackgroundColor!='' or $ParsedLineHeight!=''">
        <xsl:attribute name="style">
          <xsl:value-of select="concat($ParsedFontSize,$ParsedFontFamily,$ParsedFontStretch,$ParsedFontStyle,$ParsedFontWeight,$ParsedFontColor,$ParsedBackgroundColor,$ParsedLineHeight)"/>
        </xsl:attribute>     
      </xsl:if>
      <xsl:apply-templates select="text()|x:StyledText|x:LineBreak"/>
    </div>
  </xsl:template>
    
  <xsl:template match="x:Subtitle">
    <div>
      <xsl:attribute name="class">
        <xsl:call-template name="UnderlineStyleTypeTemplate">
          <xsl:with-param name="UnderlineStyle" select="preceding-sibling::x:StyleDefinitions/x:SubtitleStyle/@UnderlineStyle"/>
        </xsl:call-template>
        <xsl:text>subtitle</xsl:text>
      </xsl:attribute>

      <xsl:variable name="ParsedFontSize">
        <xsl:call-template name="FontSizeTypeTemplate">
          <xsl:with-param name="FontSize" select="preceding-sibling::x:StyleDefinitions/x:SubtitleStyle/@FontSize"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:variable name="ParsedFontFamily">
        <xsl:call-template name="FontFamilyTypeTemplate">
          <xsl:with-param name="FontFamily" select="preceding-sibling::x:StyleDefinitions/x:SubtitleStyle/@FontFamily"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:variable name="ParsedFontStretch">
        <xsl:call-template name="FontStretchTypeTemplate">
          <xsl:with-param name="FontStretch" select="preceding-sibling::x:StyleDefinitions/x:SubtitleStyle/@FontStretch"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:variable name="ParsedFontStyle">
        <xsl:call-template name="FontStyleTypeTemplate">
          <xsl:with-param name="FontStyle" select="preceding-sibling::x:StyleDefinitions/x:SubtitleStyle/@FontStyle"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:variable name="ParsedFontWeight">
        <xsl:call-template name="FontWeightTypeTemplate">
          <xsl:with-param name="FontWeight" select="preceding-sibling::x:StyleDefinitions/x:SubtitleStyle/@FontWeight"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:variable name="ParsedFontColor">
        <xsl:call-template name="FontColorTypeTemplate">
          <xsl:with-param name="FontColor" select="preceding-sibling::x:StyleDefinitions/x:SubtitleStyle/@FontColor"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:variable name="ParsedBackgroundColor">
        <xsl:call-template name="BackgroundColorTypeTemplate">
          <xsl:with-param name="BackgroundColor" select="preceding-sibling::x:StyleDefinitions/x:SubtitleStyle/@BackgroundColor"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:variable name="ParsedLineHeight">
        <xsl:call-template name="LineHeightTypeTemplate">
          <xsl:with-param name="LineHeight" select="preceding-sibling::x:StyleDefinitions/x:SubtitleStyle/@LineHeight"/>
        </xsl:call-template>
      </xsl:variable>

      <xsl:if test="$ParsedFontSize!='' or $ParsedFontFamily!='' or $ParsedFontStretch!='' or $ParsedFontStyle!='' or $ParsedFontWeight!='' or $ParsedFontColor!='' or $ParsedBackgroundColor!='' or $ParsedLineHeight!=''">
        <xsl:attribute name="style">
          <xsl:value-of select="concat($ParsedFontSize,$ParsedFontFamily,$ParsedFontStretch,$ParsedFontStyle,$ParsedFontWeight,$ParsedFontColor,$ParsedBackgroundColor,$ParsedLineHeight)"/>
        </xsl:attribute>
      </xsl:if>
      
      <xsl:apply-templates select="text()|x:StyledText|x:LineBreak"/>
    </div>
  </xsl:template>
    
  <xsl:template match="x:Authors">
    <div class="authors">
      <xsl:apply-templates select="x:Author"/>
    </div>   
  </xsl:template>
    
  <xsl:template match="x:Author">
    <a>
      <xsl:if test="@Source">
        <xsl:attribute name="href">
          <xsl:value-of select="@Source"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:call-template name="TextContentTemplate">
        <xsl:with-param name="Tag" select="'span'"/>     
      </xsl:call-template>      
    </a>
  </xsl:template>
  
  <xsl:template match="x:Abstract">
    <div class="abstract">
      <!--<xsl:for-each select="current()/*">
        <xsl:choose>
          <xsl:when test="self::x:Paragraph">
            <xsl:call-template name="ParagraphTemplate"/>
          </xsl:when>
          <xsl:when test="self::x:Image">
            <xsl:call-template name="ImageTemplate"/>
          </xsl:when>
          <xsl:when test="self::x:CodeBlock">
            <xsl:call-template name="CodeBlockTemplate"/>
          </xsl:when>
          <xsl:when test="self::x:BlockQuote">
            <xsl:call-template name="BlockQuoteTemplate"/>
          </xsl:when>
          <xsl:when test="self::x:Video">
            <xsl:call-template name="VideoTemplate"/>
          </xsl:when>
          <xsl:when test="self::x:Audio">
            <xsl:call-template name="AudioTemplate"/>
          </xsl:when>
          <xsl:when test="self::x:OrderedList">
            <xsl:call-template name="OrderedListTemplate"/>
          </xsl:when>
          <xsl:when test="self::x:UnorderedList">
            <xsl:call-template name="UnorderedListTemplate"/>
          </xsl:when>
          <xsl:when test="self::x:Table">
            <xsl:call-template name="TableTemplate"/>
          </xsl:when>
        </xsl:choose>
      </xsl:for-each>-->
      <xsl:apply-templates select="x:Paragraph|x:Image|x:CodeBlock|x:BlockQuote|x:Video|x:Audio|x:OrderedList|x:UnorderedList|x:Table"/>
    </div>
  </xsl:template>

  <xsl:template match="x:Introduction">
    <div class="introduction">
      <xsl:apply-templates select="x:Paragraph|x:Image|x:CodeBlock|x:BlockQuote|x:Video|x:Audio|x:OrderedList|x:UnorderedList|x:Table"/>
    </div>
  </xsl:template>
  
  <xsl:template match="x:Body" mode="Article">
    <!--<xsl:for-each select="./*">
      <xsl:choose>
        <xsl:when test="self::x:Section">
          <xsl:call-template name="Header1SectionTemplate"/>
        </xsl:when>
        <xsl:when test="self::x:Paragraph">
          <xsl:call-template name="ParagraphTemplate"/>
        </xsl:when>
        <xsl:when test="self::x:Image">
          <xsl:call-template name="ImageTemplate"/>
        </xsl:when>
        <xsl:when test="self::x:CodeBlock">
          <xsl:call-template name="CodeBlockTemplate"/>
        </xsl:when>
        <xsl:when test="self::x:BlockQuote">
          <xsl:call-template name="BlockQuoteTemplate"/>
        </xsl:when>
        <xsl:when test="self::x:Video">
          <xsl:call-template name="VideoTemplate"/>
        </xsl:when>
        <xsl:when test="self::x:Audio">
          <xsl:call-template name="AudioTemplate"/>
        </xsl:when>
        <xsl:when test="self::x:OrderedList">
          <xsl:call-template name="OrderedListTemplate"/>
        </xsl:when>
        <xsl:when test="self::x:UnorderedList">
          <xsl:call-template name="UnorderedListTemplate"/>
        </xsl:when>
        <xsl:when test="self::x:Table">
          <xsl:call-template name="TableTemplate"/>
        </xsl:when>
      </xsl:choose>
    </xsl:for-each>-->
    <div class="body">
      <xsl:apply-templates select="x:Section1|x:Paragraph|x:Image|x:CodeBlock|x:BlockQuote|x:Video|x:Audio|x:OrderedList|x:UnorderedList|x:Table"/>
    </div>
  </xsl:template>
  
  <!--End Article-->
  
  <!--Header-->
  <xsl:template match="x:Section1">
    
  </xsl:template>

  <xsl:template match="x:Section5">
    <li>
      <xsl:apply-templates select="x:Title" mode="Section"/>
      <xsl:choose>
        <xsl:when test="x:Section6">
          <ol>
            <!--这里需要读Section6的配置-->
            <xsl:apply-templates select="x:Section6"/>
          </ol>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates select="x:Paragraph|x:Image|x:CodeBlock|x:BlockQuote|x:Video|x:Audio|x:OrderedList|x:UnorderedList|x:Table"/>
        </xsl:otherwise>
      </xsl:choose>
    </li>
  </xsl:template>

  <xsl:template match="x:Section6">
    <li>
      <xsl:apply-templates select="x:Title" mode="Section"/>
      <xsl:apply-templates select="x:Paragraph|x:Image|x:CodeBlock|x:BlockQuote|x:Video|x:Audio|x:OrderedList|x:UnorderedList|x:Table"/>
    </li>
  </xsl:template>

  <xsl:template match="x:Title" mode="Section">
    <xsl:call-template name="StyledTextTemplate"/>
  </xsl:template>
  
  <!--End Header-->
  
  
  
  <!--Table-->
  
  <xsl:template match="x:Table" name="TableTemplate">
    <table>
      <xsl:if test="@CaptionSide">
        <xsl:attribute name="style">
          <xsl:call-template name="TableCaptionSideTypeTemplate">
            <xsl:with-param name="CaptionSide" select="x:Caption/@CaptionSide"/>
          </xsl:call-template>
        </xsl:attribute>
      </xsl:if>      
      <xsl:if test="@HorizontalAlignment">
        <xsl:attribute name="class">
          <xsl:call-template name="HorizontalAlignmentTypeTemplate">
            <xsl:with-param name="HorizontalAlignment" select="@HorizontalAlignment"/>         
          </xsl:call-template>
        </xsl:attribute>
      </xsl:if>
      <xsl:apply-templates select="x:Caption" mode="Table"/>
      <thead>
        <xsl:apply-templates select="x:Header" mode="Table"/>
      </thead>
      <tbody>
        <xsl:apply-templates select="x:Body" mode="Table"/>
      </tbody>
    </table>
  </xsl:template>

  <xsl:template match="x:Header" mode="Table">
    <tr>
      <xsl:apply-templates select="x:HeaderCell" mode="TableHeader"/>
    </tr>    
  </xsl:template>

  <xsl:template match="x:Body" mode="Table">
    <xsl:apply-templates select="x:Row" mode="Table"/>
  </xsl:template>

  <xsl:template match="x:Row" mode="Table">
    <tr>
      <xsl:apply-templates select="x:DataCell|x:HeaderCell" mode="TableBody"/>
    </tr>
  </xsl:template>

  <xsl:template match="x:HeaderCell" mode="TableHeader">
    <xsl:variable name="TextAlignmentRow" select="../@TextAlignment"/>
    <xsl:variable name="BackgroundColorRow" select="../@BackgroundColor"/>

    <xsl:variable name="TextAlignment">
      <xsl:choose>
        <!--这是Cell自带的TextAlignment属性-->
        <xsl:when test="@TextAlignment">
          <xsl:value-of select="@TextAlignment"/>
        </xsl:when>
        <!--这是来自Row的TextAlignment属性-->
        <xsl:when test="$TextAlignmentRow">
          <xsl:value-of select="$TextAlignmentRow"/>
        </xsl:when>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="BackgroundColor">
      <xsl:choose>
        <xsl:when test="@BackgroundColor">
          <xsl:value-of select="@BackgroundColor"/>
        </xsl:when>
        <xsl:when test="$BackgroundColorRow">
          <xsl:value-of select="$BackgroundColorRow"/>
        </xsl:when>
      </xsl:choose>
    </xsl:variable>
    
    <th>
      <xsl:if test="@RowSpan">
        <xsl:attribute name="rowspan">
          <xsl:value-of select="@RowSpan"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@ColumnSpan">
        <xsl:attribute name="colspan">
          <xsl:value-of select="@ColumnSpan"/>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="$TextAlignment!='' or $BackgroundColor!=''">
        <xsl:attribute name="style">
          <xsl:call-template name="TextAlignmentTypeTemplate">
            <xsl:with-param name="TextAlignment" select="$TextAlignment"/>
          </xsl:call-template>
          <xsl:call-template name="BackgroundColorTypeTemplate">
            <xsl:with-param name="BackgroundColor" select="$BackgroundColor"/>
          </xsl:call-template>
        </xsl:attribute>
      </xsl:if>
      <xsl:apply-templates select="text()|x:StyledText|x:Hyperlink"/>
    </th>
  </xsl:template>
  
  <xsl:template match="x:HeaderCell" mode="TableBody">
    <xsl:variable name="Position" select="position()"/>
    <xsl:variable name="TextAlignmentColumn" select="ancestor::x:Table/x:ColumnStyles/x:ColumnStyle[$Position]/@TextAlignment"/>
    <xsl:variable name="BackgroundColorColumn" select="ancestor::x:Table/x:ColumnStyles/x:ColumnStyle[$Position]/@BackgroundColor"/>
    <xsl:variable name="TextAlignmentRow" select="../@TextAlignment"/>
    <xsl:variable name="BackgroundColorRow" select="../@BackgroundColor"/>

    <xsl:if test="@RowSpan">
      <xsl:attribute name="rowspan">
        <xsl:value-of select="@RowSpan"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@ColumnSpan">
      <xsl:attribute name="colspan">
        <xsl:value-of select="@ColumnSpan"/>
      </xsl:attribute>
    </xsl:if>
    
    <xsl:variable name="TextAlignment">
      <xsl:choose>
        <!--这是Cell自带的TextAlignment属性-->
        <xsl:when test="@TextAlignment">
          <xsl:value-of select="@TextAlignment"/>
        </xsl:when>
        <!--这是来自Row的TextAlignment属性-->
        <xsl:when test="$TextAlignmentRow">
          <xsl:value-of select="$TextAlignmentRow"/>
        </xsl:when>
        <!--这是来自ColumnStyle的TextAlignment属性-->
        <xsl:when test="$TextAlignmentColumn">
          <xsl:value-of select="$TextAlignmentColumn"/>
        </xsl:when>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="BackgroundColor">
      <xsl:choose>
        <xsl:when test="@BackgroundColor">
          <xsl:value-of select="@BackgroundColor"/>
        </xsl:when>
        <xsl:when test="$BackgroundColorRow">
          <xsl:value-of select="$BackgroundColorRow"/>
        </xsl:when>
        <xsl:when test="$BackgroundColorColumn">
          <xsl:value-of select="$BackgroundColorColumn"/>
        </xsl:when>
      </xsl:choose>
    </xsl:variable>
    <th>
      <xsl:if test="$TextAlignment!='' or $BackgroundColor!=''">
        <xsl:attribute name="style">
          <xsl:call-template name="TextAlignmentTypeTemplate">
            <xsl:with-param name="TextAlignment" select="$TextAlignment"/>
          </xsl:call-template>
          <xsl:call-template name="BackgroundColorTypeTemplate">
            <xsl:with-param name="BackgroundColor" select="$BackgroundColor"/>
          </xsl:call-template>
        </xsl:attribute>
      </xsl:if>
      <xsl:apply-templates select="text()|x:StyledText|x:Hyperlink"/>
    </th>
  </xsl:template>

  <xsl:template match="x:DataCell" mode="TableBody">
    <!--必须先要缓存当前Context下的Position，否则如果直接应用在[]的话就会切换到ColumnStyle的Context下的position(默认是1)-->
    <xsl:variable name="Position" select="position()"/>
    <xsl:variable name="TextAlignmentColumn" select="ancestor::x:Table/x:ColumnStyles/x:ColumnStyle[$Position]/@TextAlignment"/>
    <xsl:variable name="BackgroundColorColumn" select="ancestor::x:Table/x:ColumnStyles/x:ColumnStyle[$Position]/@BackgroundColor"/>
    <xsl:variable name="TextAlignmentRow" select="../@TextAlignment"/>
    <xsl:variable name="BackgroundColorRow" select="../@BackgroundColor"/>

    <xsl:variable name="TextAlignment">
      <xsl:choose>
        <!--这是Cell自带的TextAlignment属性-->
        <xsl:when test="@TextAlignment">
          <xsl:value-of select="@TextAlignment"/>
        </xsl:when>
        <!--这是来自Row的TextAlignment属性-->
        <xsl:when test="$TextAlignmentRow">
          <xsl:value-of select="$TextAlignmentRow"/>
        </xsl:when>
        <!--这是来自ColumnStyle的TextAlignment属性-->
        <xsl:when test="$TextAlignmentColumn">
          <xsl:value-of select="$TextAlignmentColumn"/>
        </xsl:when>
      </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="BackgroundColor">
      <xsl:choose>
        <xsl:when test="@BackgroundColor">
          <xsl:value-of select="@BackgroundColor"/>
        </xsl:when>
        <xsl:when test="$BackgroundColorRow">
          <xsl:value-of select="$BackgroundColorRow"/>
        </xsl:when>
        <xsl:when test="$BackgroundColorColumn">
          <xsl:value-of select="$BackgroundColorColumn"/>
        </xsl:when>
      </xsl:choose>
    </xsl:variable>
    
    <!--优先单元格属性、然后行、最后列-->
    <td>
      <xsl:if test="$TextAlignment!='' or $BackgroundColor!=''">
        <xsl:attribute name="style">
          <xsl:call-template name="TextAlignmentTypeTemplate">
            <xsl:with-param name="TextAlignment" select="$TextAlignment"/>
          </xsl:call-template>
          <xsl:call-template name="BackgroundColorTypeTemplate">
            <xsl:with-param name="BackgroundColor" select="$BackgroundColor"/>
          </xsl:call-template>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="@RowSpan">
        <xsl:attribute name="rowspan">
          <xsl:value-of select="@RowSpan"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@ColumnSpan">
        <xsl:attribute name="colspan">
          <xsl:value-of select="@ColumnSpan"/>
        </xsl:attribute>
      </xsl:if>
      
      <xsl:apply-templates select="text()|x:StyledText|x:Hyperlink|x:Image"/>
    </td>
  </xsl:template>

  <xsl:template match="x:Caption" mode="Table">
    <caption>
      <xsl:call-template name="TextContentTemplate"/>
    </caption>
  </xsl:template>
  
  <!--End Table-->
  
  <!--List-->
  
  <xsl:template match="x:OrderedList" name="OrderedListTemplate">
    <ol>
      <xsl:if test="@ListStyle or @CounterFontWeight">
        <xsl:attribute name="class">
          <xsl:call-template name="OrderedListStyleTypeTemplate">
            <xsl:with-param name="ListStyle" select="@ListStyle"/>        
          </xsl:call-template>
          <xsl:text> </xsl:text>
          <xsl:call-template name="CounterFontWeightTypeTemplate">
            <xsl:with-param name="CounterFontWeight" select="@CounterFontWeight"/>         
          </xsl:call-template>
        </xsl:attribute>
      </xsl:if>
      <xsl:apply-templates select="x:ListItem"/>   
    </ol>
  </xsl:template>

  <xsl:template match="x:UnorderedList" name="UnorderedListTemplate">
    <ul>
      <xsl:if test="@ListStyle">
        <xsl:attribute name="class">
          <xsl:call-template name="UnorderedListStyleTypeTemplate">
            <xsl:with-param name="ListStyle" select="@ListStyle"/>        
          </xsl:call-template>
        </xsl:attribute>
      </xsl:if>     
    </ul>
    <xsl:apply-templates select="x:ListItem"/>
  </xsl:template>
  
  <xsl:template match="x:ListItem">   
    <li>
      <xsl:apply-templates select="x:Header" mode="List"/>
      <xsl:for-each select="./*">
        <xsl:choose>
          <xsl:when test="self::x:Paragraph">
            <xsl:call-template name="ParagraphTemplate"/>          
          </xsl:when>
          <xsl:when test="self::x:OrderedList">
            <xsl:call-template name="OrderedListTemplate"/>          
          </xsl:when>
          <xsl:when test="self::x:UnorderedList">
            <xsl:call-template name="UnorderedListTemplate"/>          
          </xsl:when>
          <xsl:when test="self::x:Image">
            <xsl:call-template name="ImageTemplate"/>
          </xsl:when>
          <xsl:when test="self::x:CodeBlock">
            <xsl:call-template name="CodeBlockTemplate"/>
          </xsl:when>
          <xsl:when test="self::x:BlockQuote">
            <xsl:call-template name="BlockQuoteTemplate"/>
          </xsl:when>
          <xsl:when test="self::x:Video">
            <xsl:call-template name="VideoTemplate"/>
          </xsl:when>
          <xsl:when test="self::x:Audio">
            <xsl:call-template name="AudioTemplate"/>
          </xsl:when>
          <xsl:when test="self::x:OrderedList">
            <xsl:call-template name="OrderedListTemplate"/>
          </xsl:when>
          <xsl:when test="self::x:UnorderedList">
            <xsl:call-template name="UnorderedListTemplate"/>
          </xsl:when>
          <xsl:when test="self::x:Table">
            <xsl:call-template name="TableTemplate"/>
          </xsl:when>        
        </xsl:choose>     
      </xsl:for-each> 
    </li>
  </xsl:template>
  
  <xsl:template match="x:Header" mode="List">
    <xsl:call-template name="TextContentTemplate">
      <xsl:with-param name="Tag" select="'span'"/>    
    </xsl:call-template>
  </xsl:template>
  
  <!--End List-->
  
  <!--Paragraph-->
  
  <xsl:template name="ParagraphTemplate" match="x:Paragraph">
    <p>
      <xsl:if test="@Indent or @TextAlignment or @FontSize or @FontFamily or @FontStretch or @FontStyle or @FontWeight or @FontColor or @BackgroundColor or @LineHeight">
        <xsl:attribute name="style">
          <xsl:if test="@Indent">
            <xsl:text>text-indent:</xsl:text>
            <xsl:value-of select="@Indent"/>
            <xsl:text>ch;</xsl:text>
          </xsl:if>
          <xsl:call-template name="TextAlignmentTypeTemplate">
            <xsl:with-param name="TextAlignment" select="@TextAlignment"/>
          </xsl:call-template>
          <xsl:call-template name="FontSizeTypeTemplate">
            <xsl:with-param name="FontSize" select="@FontSize"/>       
          </xsl:call-template>
          <xsl:call-template name="FontFamilyTypeTemplate">
            <xsl:with-param name="FontFamily" select="@FontFamily"/>       
          </xsl:call-template>
          <xsl:call-template name="FontStretchTypeTemplate">
            <xsl:with-param name="FontStretch" select="@FontStretch"/>       
          </xsl:call-template>
          <xsl:call-template name="FontStyleTypeTemplate">
            <xsl:with-param name="FontStyle" select="@FontStyle"/>       
          </xsl:call-template>
          <xsl:call-template name="FontWeightTypeTemplate">
            <xsl:with-param name="FontWeight" select="@FontWeight"/>       
          </xsl:call-template>
          <xsl:call-template name="FontColorTypeTemplate">
            <xsl:with-param name="FontColor" select="@FontColor"/>
          </xsl:call-template>
          <xsl:call-template name="BackgroundColorTypeTemplate">
            <xsl:with-param name="BackgroundColor" select="@BackgroundColor"/>
          </xsl:call-template>
          <xsl:call-template name="LineHeightTypeTemplate">
            <xsl:with-param name="LineHeight" select="@LineHeight"/>          
          </xsl:call-template>
        </xsl:attribute>
      </xsl:if>
      <xsl:apply-templates select="text()|x:StyledText|x:DeletedText|x:InsertedText|x:MarkedText|x:Superscript|x:Subscript|x:Quote|x:Hyperlink|x:LineBreak|x:Cite"/>      
    </p>
  </xsl:template>
  
  <!--End Paragraph-->
  
  <!--Cite and References-->
  <xsl:template match="x:References">
    <div>
      <xsl:attribute name="class">
        <xsl:text>references</xsl:text>
      </xsl:attribute>
      <xsl:if test="boolean(x:Header)">
        <xsl:apply-templates select="x:Header" mode="References"/>
      </xsl:if>
      <ol>
        <xsl:attribute name="class">
          <xsl:choose>
            <xsl:when test="@ListStyle">
              <xsl:call-template name="OrderedListStyleTypeTemplate">
                <xsl:with-param name="ListStyle" select="@ListStyle"/>
              </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
              <xsl:call-template name="OrderedListStyleTypeTemplate">
                <xsl:with-param name="ListStyle" select="'Decimal'"/>
              </xsl:call-template>
            </xsl:otherwise>
          </xsl:choose>         
        </xsl:attribute>        
        <xsl:apply-templates select="x:Reference"/>
      </ol>
    </div>    
  </xsl:template>

  <xsl:template name="CiteTemplate" match="x:Cite">
    <cite>
      <xsl:value-of select="text()"/>
      <a>
        <xsl:attribute name="id">
          <xsl:value-of select="concat('cite:',@Id)"/>
        </xsl:attribute>
        <xsl:attribute name="href">
          <xsl:value-of select="concat('#reference:',@ReferenceId)"/>
        </xsl:attribute>       
        <sup>
          <xsl:choose>
            <xsl:when test="@ReferenceDescription">
              <xsl:value-of select="@ReferenceDescription"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="'[]'"/>
            </xsl:otherwise>
          </xsl:choose>         
        </sup>
      </a>
    </cite>
  </xsl:template>

  <xsl:template name="ReferenceTemplate" match="x:Reference">
    <xsl:variable name="Id" select="@Id"/>
    <li>
      <xsl:attribute name="id">
        <xsl:value-of select="concat('reference:',@Id)"/>
      </xsl:attribute>
      <a>
        <xsl:if test="@Source">
          <xsl:attribute name="href">
            <xsl:value-of select="@Source"/>
          </xsl:attribute>
        </xsl:if>
        <xsl:value-of select="text()"/>
      </a>
      <xsl:apply-templates select="//x:Cite[@ReferenceId=$Id]" mode="ReverseReference"/>
    </li>
  </xsl:template>

  <xsl:template name="ReverseReferenceTemplate" match="//x:Cite" mode="ReverseReference">
    <a>
      <xsl:attribute name="href">
        <xsl:value-of select="concat('#cite:',@Id)"/>
      </xsl:attribute>
      <sup>
        <xsl:value-of select="'[]'"/>
      </sup>
    </a>
  </xsl:template>

  <xsl:template match="x:Header" mode="References">
    <div class="references-header">
      <xsl:call-template name="TextContentTemplate">
        <xsl:with-param name="Tag" select="'span'"/>
      </xsl:call-template>
    </div>
  </xsl:template>
  
  <!--End Cite and References-->
  
  <!--Basic Element Template-->
  <xsl:template match="x:BlockQuote" name="BlockQuoteTemplate">
    <blockquote>
      <xsl:if test="@Source">
        <xsl:attribute name="cite">
          <xsl:value-of select="@Source"/>
        </xsl:attribute>
      </xsl:if>    
      <xsl:apply-templates select="x:Paragraph"/>
    </blockquote>
  </xsl:template>
  
  <xsl:template match="x:CodeBlock" name="CodeBlockTemplate">
    <pre>
      <xsl:attribute name="class">
        <xsl:text>line-numbers</xsl:text>
      </xsl:attribute>
      <xsl:attribute name="data-language">
        <xsl:value-of select="@Language"/>
      </xsl:attribute>
      <code>
        <xsl:attribute name="class">
          <xsl:choose>
            <xsl:when test="@Language='C#'">
              <xsl:text>language-cs</xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="concat('language-',translate(@Language,$uppercase,$lowercase))"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>
        <xsl:value-of select="text()"/>
      </code>
    </pre>
  </xsl:template>

  <xsl:template match="x:Hyperlink">
    <!--Source Attribute is required,so check is not necessary-->
    <a>
      <xsl:attribute name="href">
        <xsl:value-of select="@Source"/>
      </xsl:attribute>
      <xsl:choose>
        <xsl:when test="text()=''">
          <xsl:value-of select="@Source"/>       
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="TextContentTemplate">
            <xsl:with-param name="Tag" select="'span'"/>        
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>  
    </a>
  </xsl:template>
    
  <xsl:template match="x:Image" name="ImageTemplate">
    <div>
      <xsl:attribute name="class">
        <xsl:text>image-container</xsl:text>
        <xsl:text> </xsl:text>
        <xsl:if test="@HorizontalAlignment">
          <xsl:call-template name="HorizontalAlignmentTypeTemplate">
            <xsl:with-param name="HorizontalAlignment" select="@HorizontalAlignment"/>
          </xsl:call-template>
        </xsl:if>
      </xsl:attribute>
      <xsl:if test="@TopMargin or @BottomMargin">
        <xsl:attribute name="style">
          <xsl:call-template name="TopMarginTypeTemplate">
            <xsl:with-param name="Margin" select="@TopMargin"/>
          </xsl:call-template>
          <xsl:call-template name="BottomMarginTypeTemplate">
            <xsl:with-param name="Margin" select="@BottomMargin"/>
          </xsl:call-template>
        </xsl:attribute>
      </xsl:if>
      <img>
        <xsl:attribute name="src">
          <xsl:value-of select="@Source"/>
        </xsl:attribute>
        <xsl:attribute name="style">
          <xsl:text>display:block</xsl:text>
        </xsl:attribute>
      </img>
      <xsl:if test="@Label">
        <div>
          <xsl:attribute name="class">
            <xsl:text>image-description</xsl:text>
          </xsl:attribute>
          <span>
            <xsl:value-of select="@Description"/>
          </span>
        </div>
      </xsl:if>
    </div>
  </xsl:template>
    
  <xsl:template match="x:Video" name="VideoTemplate">
    <div>
      <xsl:attribute name="class">
        <xsl:text>video-container</xsl:text>
        <xsl:text> </xsl:text>
        <xsl:if test="@HorizontalAlignment">
          <xsl:call-template name="HorizontalAlignmentTypeTemplate">
            <xsl:with-param name="HorizontalAlignment" select="@HorizontalAlignment"/>
          </xsl:call-template>
        </xsl:if>
      </xsl:attribute>
      <video>
        <xsl:attribute name="src">
          <xsl:value-of select="@Source"/>
        </xsl:attribute>
        <xsl:attribute name="style">
          <xsl:text>display:block</xsl:text>
        </xsl:attribute>
      </video>
      <xsl:if test="@Description">
        <div>
          <xsl:attribute name="class">
            <xsl:text>video-description</xsl:text>
          </xsl:attribute>
          <span>
            <xsl:value-of select="@Description"/>
          </span>
        </div>
      </xsl:if>
    </div>
  </xsl:template>

  <xsl:template match="x:Audio" name="AudioTemplate">
    <div>
      <xsl:attribute name="class">
        <xsl:text>audio-container</xsl:text>
        <xsl:text> </xsl:text>
        <xsl:if test="@HorizontalAlignment">
          <xsl:call-template name="HorizontalAlignmentTypeTemplate">
            <xsl:with-param name="HorizontalAlignment" select="@HorizontalAlignment"/>
          </xsl:call-template>
        </xsl:if>
      </xsl:attribute>
      <audio>
        <xsl:attribute name="src">
          <xsl:value-of select="@Source"/>
        </xsl:attribute>
        <xsl:attribute name="style">
          <xsl:text>display:block</xsl:text>
        </xsl:attribute>
      </audio>
      <xsl:if test="@Description">
        <div>
          <xsl:attribute name="class">
            <xsl:text>audio-description</xsl:text>
          </xsl:attribute>
          <span>
            <xsl:value-of select="@Description"/>
          </span>
        </div>
      </xsl:if>
    </div>
  </xsl:template>
  
  <xsl:template match="x:DeletedText">
    <xsl:call-template name="TextContentTemplate">
      <xsl:with-param name="Tag" select="'del'"/>   
    </xsl:call-template>
  </xsl:template>
  
  <xsl:template match="x:InsertedText">
    <xsl:call-template name="TextContentTemplate">
      <xsl:with-param name="Tag" select="'ins'"/>   
    </xsl:call-template>
  </xsl:template>
  
  <xsl:template match="x:MarkedText">
    <xsl:call-template name="TextContentTemplate">
      <xsl:with-param name="Tag" select="'mark'"/>   
    </xsl:call-template>
  </xsl:template>
  
  <xsl:template match="x:Superscript">
    <xsl:call-template name="TextContentTemplate">
      <xsl:with-param name="Tag" select="'sup'"/>   
    </xsl:call-template>
  </xsl:template>
    
  <xsl:template match="x:Subscript">
    <xsl:call-template name="TextContentTemplate">
      <xsl:with-param name="Tag" select="'sub'"/>   
    </xsl:call-template>
  </xsl:template>
  
  <xsl:template match="x:Quote">
    <q>
      <xsl:if test="@QuoteStyle">
        <xsl:attribute name="class">
          <xsl:call-template name="QuoteStyleTypeTemplate">
            <xsl:with-param name="QuoteStyle" select="@QuoteStyle"/>          
          </xsl:call-template>      
        </xsl:attribute>     
      </xsl:if>     
      <xsl:if test="@Source">
        <xsl:attribute name="cite">
          <xsl:value-of select="@Source"/>
        </xsl:attribute>     
      </xsl:if>     
      <xsl:call-template name="TextContentTemplate">
        <xsl:with-param name="Tag" select="'span'"/>      
      </xsl:call-template>      
    </q>
  </xsl:template>   
    
  <xsl:template name="StyledTextTemplate" match="x:StyledText">
    <xsl:call-template name="TextContentTemplate">
      <xsl:with-param name="Tag" select="'span'"/>    
    </xsl:call-template>
  </xsl:template>
  
  <xsl:template name="TextContentTemplate">
    <xsl:param name="Tag"/>
    <xsl:element name="{$Tag}">
      <xsl:if test="@UnderlineStyle">
        <xsl:attribute name="class">
          <xsl:call-template name="UnderlineStyleTypeTemplate">
            <xsl:with-param name="UnderlineStyle" select="@UnderlineStyle"/>          
          </xsl:call-template>
        </xsl:attribute>     
      </xsl:if>     
      <xsl:if test="@FontSize or @FontFamily or @FontStretch or @FontStyle or @FontWeight or @FontColor or @BackgroundColor">
        <xsl:attribute name="style">        
          <xsl:call-template name="FontSizeTypeTemplate">
            <xsl:with-param name="FontSize" select="@FontSize"/>       
          </xsl:call-template>
          <xsl:call-template name="FontFamilyTypeTemplate">
            <xsl:with-param name="FontFamily" select="@FontFamily"/>       
          </xsl:call-template>
          <xsl:call-template name="FontStretchTypeTemplate">
            <xsl:with-param name="FontStretch" select="@FontStretch"/>       
          </xsl:call-template>
          <xsl:call-template name="FontStyleTypeTemplate">
            <xsl:with-param name="FontStyle" select="@FontStyle"/>       
          </xsl:call-template>
          <xsl:call-template name="FontWeightTypeTemplate">
            <xsl:with-param name="FontWeight" select="@FontWeight"/>       
          </xsl:call-template>
          <xsl:call-template name="FontColorTypeTemplate">
            <xsl:with-param name="FontColor" select="@FontColor"/>
          </xsl:call-template>
          <xsl:call-template name="BackgroundColorTypeTemplate">
            <xsl:with-param name="BackgroundColor" select="@BackgroundColor"/>
          </xsl:call-template>
        </xsl:attribute>     
      </xsl:if>
      <xsl:value-of select="text()"/>
    </xsl:element>
  </xsl:template>
    
  <xsl:template match="x:LineBreak">
    <br/>   
  </xsl:template>
  
  <xsl:template match="x:Space">
    <pre> </pre>
  </xsl:template>
   
  <!--End Basic Element Template-->
  <xsl:template match="GenericClassAttributeTemplate">
    <xsl:param name="UnderlineStyle"/>
    <xsl:param name="OrderedListStyle"/>
    <xsl:param name="UnorderedListStyle"/>
    <xsl:param name="HorizontalAlignment"/>
    <xsl:param name="VerticalAlignment"/>
    <xsl:param name="QuoteStyle"/>
    <xsl:param name="CounterFontWeight"/>

    <xsl:variable name="ParsedUnderlineStyle">
      <xsl:call-template name="UnderlineStyleTypeTemplate">
        <xsl:with-param name="UnderlineStyle" select="$UnderlineStyle"/>
      </xsl:call-template>
    </xsl:variable>
    
    <xsl:attribute name="class">
      
      <xsl:call-template name="OrderedListStyleTypeTemplate">
        <xsl:with-param name="ListStyle" select="$OrderedListStyle"/>
      </xsl:call-template>
      <xsl:call-template name="UnorderedListStyleTypeTemplate">
        <xsl:with-param name="ListStyle" select="$UnorderedListStyle"/>
      </xsl:call-template>
      <xsl:call-template name="HorizontalAlignmentTypeTemplate">
        <xsl:with-param name="HorizontalAlignment" select="$HorizontalAlignment"/>
      </xsl:call-template>
      <xsl:call-template name="VerticalAlignmentTypeTemplate">
        <xsl:with-param name="VerticalAlignment" select="$VerticalAlignment"/>
      </xsl:call-template>
      <xsl:call-template name="QuoteStyleTypeTemplate">
        <xsl:with-param name="QuoteStyle" select="$QuoteStyle"/>
      </xsl:call-template>
      <xsl:call-template name="CounterFontWeightTypeTemplate">
        <xsl:with-param name="CounterFontWeight" select="$CounterFontWeight"/>
      </xsl:call-template>
    </xsl:attribute>
  </xsl:template>

  <xsl:template name="GenericStyleAttributeTemplate">
    <xsl:param name="TextAlignment"/>
    <xsl:param name="FontSize"/>
    <xsl:param name="FontFamily"/>
    <xsl:param name="FontStretch"/>
    <xsl:param name="FontStyle"/>
    <xsl:param name="FontWeight"/>
    <xsl:param name="FontColor"/>
    <xsl:param name="BackgroundColor"/>
    <xsl:param name="LineHeight"/>
    <xsl:param name="TopMargin"/>
    <xsl:param name="BottomMargin"/>
    <xsl:attribute name="style">
      <xsl:call-template name="TextAlignmentTypeTemplate">
        <xsl:with-param name="TextAlignment" select="$TextAlignment"/>
      </xsl:call-template>
      <xsl:call-template name="FontSizeTypeTemplate">
        <xsl:with-param name="FontSize" select="$FontSize"/>
      </xsl:call-template>
      <xsl:call-template name="FontFamilyTypeTemplate">
        <xsl:with-param name="FontFamily" select="$FontFamily"/>
      </xsl:call-template>
      <xsl:call-template name="FontStretchTypeTemplate">
        <xsl:with-param name="FontStretch" select="$FontStretch"/>
      </xsl:call-template>
      <xsl:call-template name="FontStyleTypeTemplate">
        <xsl:with-param name="FontStyle" select="$FontStyle"/>
      </xsl:call-template>
      <xsl:call-template name="FontWeightTypeTemplate">
        <xsl:with-param name="FontWeight" select="$FontWeight"/>
      </xsl:call-template>
      <xsl:call-template name="FontColorTypeTemplate">
        <xsl:with-param name="FontColor" select="$FontColor"/>
      </xsl:call-template>
      <xsl:call-template name="BackgroundColorTypeTemplate">
        <xsl:with-param name="BackgroundColor" select="$BackgroundColor"/>
      </xsl:call-template>
      <xsl:call-template name="LineHeightTypeTemplate">
        <xsl:with-param name="LineHeight" select="$LineHeight"/>
      </xsl:call-template>
      <xsl:call-template name="TopMarginTypeTemplate">
        <xsl:with-param name="Margin" select="$TopMargin"/>
      </xsl:call-template>
      <xsl:call-template name="BottomMarginTypeTemplate">
        <xsl:with-param name="Margin" select="$BottomMargin"/>
      </xsl:call-template>
    </xsl:attribute>
  </xsl:template>
  
  <!--Attribute Template-->
  <xsl:template name="TextAlignmentTypeTemplate">
    <xsl:param name="TextAlignment"/>
    <xsl:choose>
      <xsl:when test="$TextAlignment and $TextAlignment!=''">
        <xsl:value-of select="concat('text-align:',translate($TextAlignment,$uppercase,$lowercase),';')"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
    
  <xsl:template name="FontSizeTypeTemplate">
    <xsl:param name="FontSize"/>
    <xsl:choose>
      <xsl:when test="$FontSize and $FontSize!=''">
        <xsl:value-of select="concat('font-size:',$FontSize,';')"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template name="FontFamilyTypeTemplate">
    <xsl:param name="FontFamily"/>
    <xsl:choose>
      <xsl:when test="$FontFamily and $FontFamily!=''">
        <xsl:value-of select="concat('font-family:',$FontFamily,';')"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template name="FontStretchTypeTemplate">
    <xsl:param name="FontStretch"/>
    <xsl:choose>
      <xsl:when test="$FontStretch and $FontStretch!=''">
        <xsl:value-of select="concat('font-stretch:',translate($FontStretch,$uppercase,$lowercase),';')"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template name="FontStyleTypeTemplate">
    <xsl:param name="FontStyle"/>
    <xsl:choose>
      <xsl:when test="$FontStyle and $FontStyle!=''">
        <xsl:value-of select="concat('font-style:',translate($FontStyle,$uppercase,$lowercase),';')"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template name="FontWeightTypeTemplate">
    <xsl:param name="FontWeight"/>
    <xsl:choose>
      <xsl:when test="$FontWeight and $FontWeight!=''">
        <xsl:choose>
          <xsl:when test="$FontWeight='ExtraBold'">
            <xsl:text>font-weight:bolder;</xsl:text>
          </xsl:when>
          <xsl:when test="$FontWeight='Light'">
            <xsl:text>font-weight:lighter;</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="concat('font-weight:',translate($FontWeight,$uppercase,$lowercase),';')"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text/>
      </xsl:otherwise>
    </xsl:choose>  
  </xsl:template>

  <xsl:template name="FontColorTypeTemplate">
    <xsl:param name="FontColor"/>
    <xsl:choose>
      <xsl:when test="$FontColor and $FontColor!=''">
        <xsl:value-of select="concat('color:',translate($FontColor,$uppercase,$lowercase),';')"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="BackgroundColorTypeTemplate">
    <xsl:param name="BackgroundColor"/>
    <xsl:choose>
      <xsl:when test="$BackgroundColor and $BackgroundColor!=''">
        <xsl:value-of select="concat('background-color:',translate($BackgroundColor,$uppercase,$lowercase),';')"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template name="UnderlineStyleTypeTemplate">
    <xsl:param name="UnderlineStyle"/>
    <xsl:choose>
      <xsl:when test="$UnderlineStyle='SingleLine'">
        <xsl:text>single-underline </xsl:text>
      </xsl:when>
      <xsl:when test="$UnderlineStyle='DoubleLine'">
        <xsl:text>double-underline </xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="OrderedListStyleTypeTemplate">
    <xsl:param name="ListStyle"/>
    <xsl:variable name="ParsedListStyle">
      <xsl:choose>
        <xsl:when test="$ListStyle='SequentialDecimal'">
          <xsl:text>sequential-decimal</xsl:text>
        </xsl:when>
        <xsl:when test="$ListStyle='LowerAlpha'">
          <xsl:text>lower-alpha</xsl:text>
        </xsl:when>
        <xsl:when test="$ListStyle='UpperAlpha'">
          <xsl:text>upper-alpha</xsl:text>
        </xsl:when>
        <xsl:when test="$ListStyle='LowerRoman'">
          <xsl:text>lower-roman</xsl:text>
        </xsl:when>
        <xsl:when test="$ListStyle='UpperRoman'">
          <xsl:text>upper-roman</xsl:text>
        </xsl:when>
        <xsl:when test="$ListStyle='HiraganaIroha'">
          <xsl:text>hiragana-iroha</xsl:text>
        </xsl:when>
        <xsl:when test="$ListStyle='KatakanaIroha'">
          <xsl:text>katakana-iroha</xsl:text>
        </xsl:when>
        <xsl:when test="$ListStyle='SimplifiedChineseInformal'">
          <xsl:text>simplified-chinese-informal</xsl:text>
        </xsl:when>
        <xsl:when test="$ListStyle='SimplifiedChineseFormal'">
          <xsl:text>simplified-chinese-formal</xsl:text>
        </xsl:when>
        <xsl:when test="$ListStyle='TraditionalChineseInformal'">
          <xsl:text>traditional-chinese-informal</xsl:text>
        </xsl:when>
        <xsl:when test="$ListStyle='TraditionalChineseFormal'">
          <xsl:text>traditional-chinese-formal</xsl:text>
        </xsl:when>
        <xsl:when test="$ListStyle='LowerGreek'">
          <xsl:text>lower-greek</xsl:text>
        </xsl:when>
        <xsl:when test="$ListStyle='BracketedSimplifiedChineseInformal'">
          <xsl:text>bracketed-simplified-chinese-informal</xsl:text>
        </xsl:when>
        <xsl:when test="$ListStyle='ChineseBracketedSimplifiedChineseInformal'">
          <xsl:text>chinese-bracketed-simplified-chinese-informal</xsl:text>
        </xsl:when>
        <xsl:when test="$ListStyle='BracketedSimplifiedChineseFormal'">
          <xsl:text>bracketed-simplified-chinese-formal</xsl:text>
        </xsl:when>
        <xsl:when test="$ListStyle='ChineseBracketedSimplifiedChineseFormal'">
          <xsl:text>chinese-bracketed-simplified-chinese-formal</xsl:text>
        </xsl:when>
        <xsl:when test="$ListStyle='BracketedDecimal'">
          <xsl:text>bracketed-decimal</xsl:text>
        </xsl:when>
        <xsl:when test="$ListStyle='ChineseBracketedDecimal'">
          <xsl:text>chinese-bracketed-decimal</xsl:text>
        </xsl:when>
        <xsl:when test="$ListStyle='BracketedLowerAlpha'">
          <xsl:text>bracketed-lower-alpha</xsl:text>
        </xsl:when>
        <xsl:when test="$ListStyle='BracketedUpperAlpha'">
          <xsl:text>bracketed-upper-alpha</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="translate($ListStyle,$uppercase,$lowercase)"/>
        </xsl:otherwise>
      </xsl:choose>    
    </xsl:variable>
    <xsl:if test="$ParsedListStyle!=''">
      <xsl:value-of select="concat('list-style-',$ParsedListStyle,' ')"/>  
    </xsl:if>   
  </xsl:template>
  
  <xsl:template name="UnorderedListStyleTypeTemplate">
    <xsl:param name="ListStyle"/>
    <xsl:variable name="ParsedListStyle">
      <xsl:value-of select="translate($ListStyle,$uppercase,$lowercase)"/>   
    </xsl:variable>
    <xsl:if test="$ParsedListStyle!=''">
      <xsl:value-of select="concat('list-style-',$ParsedListStyle,' ')"/>   
    </xsl:if>
    
  </xsl:template>
  
  <xsl:template name="HorizontalAlignmentTypeTemplate">
    <xsl:param name="HorizontalAlignment"/>
    <xsl:choose>
        <xsl:when test="$HorizontalAlignment='Left'">
          <xsl:text>horizontal-alignment-left </xsl:text>
        </xsl:when>
        <xsl:when test="$HorizontalAlignment='Right'">
          <xsl:text>horizontal-alignment-right </xsl:text>
        </xsl:when>
        <xsl:when test="$HorizontalAlignment='Center'">
          <xsl:text>horizontal-alignment-center </xsl:text>
        </xsl:when>
        <xsl:when test="$HorizontalAlignment='Stretch'">
          <xsl:text>horizontal-alignment-stretch </xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text/>
        </xsl:otherwise>
      </xsl:choose>
  </xsl:template>
  
  <xsl:template name="VerticalAlignmentTypeTemplate">
    <xsl:param name="VerticalAlignment"/>
    <xsl:choose>
      <xsl:when test="$VerticalAlignment='Top'">
        <xsl:text>vertical-alignment-top </xsl:text>
      </xsl:when>
      <xsl:when test="$VerticalAlignment='Center'">
        <xsl:text>vertical-alignment-center </xsl:text>
      </xsl:when>
      <xsl:when test="$VerticalAlignment='Bottom'">
        <xsl:text>vertical-alignment-bottom </xsl:text>
      </xsl:when>
      <xsl:when test="$VerticalAlignment='Stretch'">
        <xsl:text>vertical-alignment-stretch </xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template name="QuoteStyleTypeTemplate">
    <xsl:param name="QuoteStyle"/>
    <xsl:choose>
      <xsl:when test="$QuoteStyle='Chinese'">
        <xsl:text>quote-chinese </xsl:text>
      </xsl:when>
      <xsl:when test="$QuoteStyle='None'">
        <xsl:text>quote-none </xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template name="LineHeightTypeTemplate">
    <xsl:param name="LineHeight"/>
    <xsl:choose>
      <xsl:when test="$LineHeight and $LineHeight!=''">
        <xsl:value-of select="concat('line-height:',$LineHeight,';')"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template name="CounterFontWeightTypeTemplate">
    <xsl:param name="CounterFontWeight"/>
    <xsl:choose>
      <xsl:when test="$CounterFontWeight and $CounterFontWeight!=''">
        <xsl:choose>
          <xsl:when test="$CounterFontWeight='ExtraBold'">
            <xsl:text>counter-font-weight-light</xsl:text>
          </xsl:when>
          <xsl:when test="$CounterFontWeight='Light'">
            <xsl:text>counter-font-weight-bold</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="concat('counter-font-weight-',translate($CounterFontWeight,$uppercase,$lowercase),' ')"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text/>
      </xsl:otherwise>
    </xsl:choose>  
  
  </xsl:template>
  
  <xsl:template name="WidthTypeTemplate">
    <xsl:param name="Width"/>
    <xsl:choose>
      <xsl:when test="$Width and $Width!=''">
        <xsl:value-of select="concat('width:',$Width)"/>     
      </xsl:when>   
    </xsl:choose>
  </xsl:template>

  <xsl:template name="TopMarginTypeTemplate">
    <xsl:param name="Margin"/>
    <xsl:call-template name="MarginTypeTemplate">
      <xsl:with-param name="Direction" select="'Top'"/>
      <xsl:with-param name="Margin" select="$Margin"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="BottomMarginTypeTemplate">
    <xsl:param name="Margin"/>
    <xsl:call-template name="MarginTypeTemplate">
      <xsl:with-param name="Direction" select="'Bottom'"/>
      <xsl:with-param name="Margin" select="$Margin"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="MarginTypeTemplate">
    <xsl:param name="Margin"/>
    <xsl:param name="Direction"/>
    <xsl:if test="$Margin and $Margin!=''">
      <xsl:value-of select="concat('margin-',translate($Direction,$uppercase,$lowercase),':',$Margin,';')"/>
    </xsl:if>
  </xsl:template>

  <xsl:template name="TableCaptionSideTypeTemplate">
    <xsl:param name="CaptionSide"/>
    <xsl:value-of select="concat('caption-side:',translate($CaptionSide,$uppercase,$lowercase),';')"/>
  </xsl:template>

</xsl:stylesheet>
