<?xml version="1.0" encoding="UTF-8"?>
<!--
    ResearchProject-wikitext.xslt
    Transforms a ResearchProject XML instance into MediaWiki wikitext.

    Uses image URLs from the XML as external web sources and renders them
    as HTML <img> tags inside the generated wikitext.
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text" encoding="UTF-8"/>

  <xsl:template match="/ResearchProject">
    <xsl:text>&lt;!--
Generated file. Do not edit by hand.
Source: project-info/project-info-en.xml
Stylesheet: project-info/project-info-schema/ResearchProject-wikitext.xslt
--&gt;&#10;&#10;</xsl:text>

    <xsl:text>= </xsl:text>
    <xsl:value-of select="name"/>
    <xsl:if test="alternateName">
      <xsl:text> (</xsl:text>
      <xsl:value-of select="alternateName"/>
      <xsl:text>)</xsl:text>
    </xsl:if>
    <xsl:text> =&#10;&#10;</xsl:text>

    <xsl:if test="dateModified">
      <xsl:text>''Last updated: </xsl:text>
      <xsl:value-of select="dateModified"/>
      <xsl:text>''&#10;&#10;</xsl:text>
    </xsl:if>

    <xsl:if test="disambiguatingDescription">
      <xsl:text>''</xsl:text>
      <xsl:value-of select="disambiguatingDescription"/>
      <xsl:text>''&#10;&#10;</xsl:text>
    </xsl:if>

    <xsl:value-of select="description"/>
    <xsl:text>&#10;&#10;</xsl:text>

    <xsl:text>== Project details ==&#10;</xsl:text>
    <xsl:text>{| class="wikitable"&#10;</xsl:text>
    <xsl:text>! Item !! Info&#10;</xsl:text>

    <xsl:if test="parentOrganization">
      <xsl:text>|-&#10;| Lead || </xsl:text>
      <xsl:choose>
        <xsl:when test="parentOrganization/@href">
          <xsl:text>[</xsl:text>
          <xsl:value-of select="parentOrganization/@href"/>
          <xsl:text> </xsl:text>
          <xsl:value-of select="parentOrganization"/>
          <xsl:text>]</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="parentOrganization"/>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:text>&#10;</xsl:text>
    </xsl:if>

    <xsl:if test="foundingDate or dissolutionDate">
      <xsl:text>|-&#10;| Period || </xsl:text>
      <xsl:value-of select="foundingDate"/>
      <xsl:if test="dissolutionDate">
        <xsl:text> - </xsl:text>
        <xsl:value-of select="dissolutionDate"/>
      </xsl:if>
      <xsl:text>&#10;</xsl:text>
    </xsl:if>

    <xsl:if test="identifier[@propertyID='GrantID']">
      <xsl:text>|-&#10;| Grant || </xsl:text>
      <xsl:value-of select="identifier[@propertyID='GrantID']/@value"/>
      <xsl:text>&#10;</xsl:text>
    </xsl:if>

    <xsl:if test="url">
      <xsl:text>|-&#10;| URL || </xsl:text>
      <xsl:call-template name="external-link-from-value">
        <xsl:with-param name="value" select="url"/>
      </xsl:call-template>
      <xsl:text>&#10;</xsl:text>
    </xsl:if>

    <xsl:if test="sameAs">
      <xsl:for-each select="sameAs">
        <xsl:text>|-&#10;</xsl:text>
        <xsl:choose>
          <xsl:when test="position() = 1">
            <xsl:text>| Also at || </xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>|  || </xsl:text>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:call-template name="external-link-from-value">
          <xsl:with-param name="value" select="."/>
        </xsl:call-template>
        <xsl:text>&#10;</xsl:text>
      </xsl:for-each>
    </xsl:if>

    <xsl:if test="knowsLanguage">
      <xsl:text>|-&#10;| Languages || </xsl:text>
      <xsl:for-each select="knowsLanguage">
        <xsl:if test="position() &gt; 1">
          <xsl:text>, </xsl:text>
        </xsl:if>
        <xsl:value-of select="."/>
      </xsl:for-each>
      <xsl:text>&#10;</xsl:text>
    </xsl:if>

    <xsl:text>|}&#10;&#10;</xsl:text>

    <xsl:if test="member">
      <xsl:text>== Team ==&#10;</xsl:text>
      <xsl:text>{| class="wikitable"&#10;</xsl:text>
      <xsl:text>! Name !! ORCID&#10;</xsl:text>
      <xsl:for-each select="member">
        <xsl:text>|-&#10;| </xsl:text>
        <xsl:choose>
          <xsl:when test="@href">
            <xsl:text>[</xsl:text>
            <xsl:value-of select="@href"/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="."/>
            <xsl:text>]</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="."/>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:text> || </xsl:text>
        <xsl:if test="contains(@href, 'orcid.org/')">
          <xsl:text>[</xsl:text>
          <xsl:value-of select="@href"/>
          <xsl:text> </xsl:text>
          <xsl:value-of select="substring-after(@href, 'orcid.org/')"/>
          <xsl:text>]</xsl:text>
        </xsl:if>
        <xsl:text>&#10;</xsl:text>
      </xsl:for-each>
      <xsl:text>|}&#10;&#10;</xsl:text>
    </xsl:if>

    <xsl:if test="parentOrganization or memberOf">
      <xsl:text>== Partner organizations ==&#10;</xsl:text>

      <xsl:if test="parentOrganization">
        <xsl:text>; Lead&#10;: </xsl:text>
        <xsl:choose>
          <xsl:when test="parentOrganization/@href">
            <xsl:text>[</xsl:text>
            <xsl:value-of select="parentOrganization/@href"/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="parentOrganization"/>
            <xsl:text>]</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="parentOrganization"/>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:text>&#10;</xsl:text>
      </xsl:if>

      <xsl:if test="memberOf">
        <xsl:text>; Partners&#10;</xsl:text>
        <xsl:for-each select="memberOf">
          <xsl:text>* </xsl:text>
          <xsl:choose>
            <xsl:when test="@href">
              <xsl:text>[</xsl:text>
              <xsl:value-of select="@href"/>
              <xsl:text> </xsl:text>
              <xsl:value-of select="."/>
              <xsl:text>]</xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="."/>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:text>&#10;</xsl:text>
        </xsl:for-each>
      </xsl:if>

      <xsl:text>&#10;</xsl:text>
    </xsl:if>

    <xsl:if test="funding">
      <xsl:text>== Funding ==&#10;</xsl:text>
      <xsl:for-each select="funding">
        <xsl:text>* '''</xsl:text>
        <xsl:value-of select="name"/>
        <xsl:text>'''</xsl:text>
        <xsl:if test="identifier">
          <xsl:text> - Grant ID: </xsl:text>
          <xsl:value-of select="identifier/@value"/>
        </xsl:if>
        <xsl:if test="funder">
          <xsl:text> - </xsl:text>
          <xsl:value-of select="funder"/>
        </xsl:if>
        <xsl:if test="url">
          <xsl:text> - [</xsl:text>
          <xsl:value-of select="url"/>
          <xsl:text>]</xsl:text>
        </xsl:if>
        <xsl:text>&#10;</xsl:text>
      </xsl:for-each>
      <xsl:text>&#10;</xsl:text>
    </xsl:if>

    <xsl:if test="knowsAbout">
      <xsl:text>== Subject areas ==&#10;</xsl:text>
      <xsl:for-each select="knowsAbout">
        <xsl:text>* </xsl:text>
        <xsl:value-of select="normalize-space(.)"/>
        <xsl:text>&#10;</xsl:text>
      </xsl:for-each>
      <xsl:text>&#10;</xsl:text>
    </xsl:if>

    <xsl:if test="keywords">
      <xsl:text>== Keywords ==&#10;</xsl:text>
      <xsl:call-template name="keyword-list">
        <xsl:with-param name="text" select="keywords"/>
      </xsl:call-template>
      <xsl:text>&#10;</xsl:text>
    </xsl:if>

    <xsl:if test="hasCredential">
      <xsl:text>== Licences and copyright ==&#10;</xsl:text>
      <xsl:for-each select="hasCredential">
        <xsl:text>* '''</xsl:text>
        <xsl:value-of select="name"/>
        <xsl:text>'''</xsl:text>
        <xsl:if test="description">
          <xsl:text> - </xsl:text>
          <xsl:value-of select="description"/>
        </xsl:if>
        <xsl:for-each select="url">
          <xsl:text> [</xsl:text>
          <xsl:value-of select="."/>
          <xsl:text>]</xsl:text>
        </xsl:for-each>
        <xsl:text>&#10;</xsl:text>
      </xsl:for-each>
    </xsl:if>

  </xsl:template>

  <xsl:template name="external-link-from-value">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="contains($value, ' - https://')">
        <xsl:text>[</xsl:text>
        <xsl:value-of select="substring-after($value, ' - ')"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="substring-before($value, ' - ')"/>
        <xsl:text>]</xsl:text>
      </xsl:when>
      <xsl:when test="contains($value, ' - http://')">
        <xsl:text>[</xsl:text>
        <xsl:value-of select="substring-after($value, ' - ')"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="substring-before($value, ' - ')"/>
        <xsl:text>]</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>[</xsl:text>
        <xsl:value-of select="$value"/>
        <xsl:text>]</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="keyword-list">
    <xsl:param name="text"/>
    <xsl:choose>
      <xsl:when test="contains($text, ',')">
        <xsl:text>* </xsl:text>
        <xsl:value-of select="normalize-space(substring-before($text, ','))"/>
        <xsl:text>&#10;</xsl:text>
        <xsl:call-template name="keyword-list">
          <xsl:with-param name="text" select="substring-after($text, ',')"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>* </xsl:text>
        <xsl:value-of select="normalize-space($text)"/>
        <xsl:text>&#10;</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>