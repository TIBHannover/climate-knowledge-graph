<?xml version="1.0" encoding="UTF-8"?>
<!--
    ResearchProject-readme.xslt
    Transforms a ResearchProject XML instance (ResearchProject.dtd) into a
    Markdown README suitable for a GitLab or GitHub repository root.

    APPLY – PowerShell (no extra tools required):
        cd C:\gitlab\opp
        .\project-info\scripts\Make-Readme.ps1

    Or manually, from the project-info directory:
        .\scripts\Apply-XSLT.ps1 `
            -Source     project-info-en.xml `
            -Stylesheet ResearchProject-readme.xslt `
            -Output     ..\README.md
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text" encoding="UTF-8"/>

  <!-- ============================================================
       MAIN TEMPLATE
  ============================================================ -->
  <xsl:template match="/ResearchProject">

    <!-- INFOBOX -->
    <xsl:text>&gt; ℹ️ **Generated content** &#8212; from [`project-info/project-info-en.xml`](project-info/project-info-en.xml) using [`project-info/project-info-schema/ResearchProject-readme.xslt`](project-info/project-info-schema/ResearchProject-readme.xslt) &#183; Schema: [schema.org/ResearchProject](https://schema.org/ResearchProject). See [project-info/README.md](project-info/README.md) for the full pipeline documentation. Do not edit this section by hand &#8212; it is overwritten each time the pipeline runs.&#10;&#10;</xsl:text>

    <!-- TITLE -->
    <xsl:text># </xsl:text>
    <xsl:value-of select="name"/>
    <xsl:if test="alternateName">
      <xsl:text> (</xsl:text>
      <xsl:value-of select="alternateName"/>
      <xsl:text>)</xsl:text>
    </xsl:if>
    <xsl:text>&#10;&#10;</xsl:text>

    <!-- STRAPLINE -->
    <xsl:if test="disambiguatingDescription">
      <xsl:text>&gt; </xsl:text>
      <xsl:value-of select="disambiguatingDescription"/>
      <xsl:text>&#10;&#10;</xsl:text>
    </xsl:if>

    <!-- LOGOS -->
    <xsl:if test="image">
      <xsl:for-each select="image/imageObject">
        <xsl:text>&lt;img src="</xsl:text>
        <xsl:value-of select="contentUrl"/>
        <xsl:text>" alt="</xsl:text>
        <xsl:value-of select="caption"/>
        <xsl:text>" height="60"&gt;  </xsl:text>
      </xsl:for-each>
      <xsl:text>&#10;&#10;</xsl:text>
    </xsl:if>

    <!-- DESCRIPTION -->
    <xsl:value-of select="description"/>
    <xsl:text>&#10;&#10;</xsl:text>

    <!-- DIVIDER -->
    <xsl:text>---&#10;&#10;</xsl:text>

    <!-- PROJECT DETAILS TABLE -->
    <xsl:text>## Project Details&#10;&#10;</xsl:text>
    <xsl:text>| | |&#10;</xsl:text>
    <xsl:text>|---|---|&#10;</xsl:text>

    <xsl:if test="parentOrganization">
      <xsl:text>| **Lead** | </xsl:text>
      <xsl:choose>
        <xsl:when test="parentOrganization/@href">
          <xsl:text>[</xsl:text>
          <xsl:value-of select="parentOrganization"/>
          <xsl:text>](</xsl:text>
          <xsl:value-of select="parentOrganization/@href"/>
          <xsl:text>)</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="parentOrganization"/>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:text> |&#10;</xsl:text>
    </xsl:if>

    <xsl:if test="foundingDate or dissolutionDate">
      <xsl:text>| **Period** | </xsl:text>
      <xsl:value-of select="foundingDate"/>
      <xsl:if test="dissolutionDate">
        <xsl:text>&#8211;</xsl:text>
        <xsl:value-of select="dissolutionDate"/>
      </xsl:if>
      <xsl:text> |&#10;</xsl:text>
    </xsl:if>

    <xsl:if test="identifier[@propertyID='GrantID']">
      <xsl:text>| **Grant** | </xsl:text>
      <xsl:value-of select="identifier[@propertyID='GrantID']/@value"/>
      <xsl:text> (</xsl:text>
      <xsl:value-of select="identifier[@propertyID='GrantID']/@propertyID"/>
      <xsl:text>) |&#10;</xsl:text>
    </xsl:if>

    <xsl:if test="url">
      <xsl:text>| **URL** | [</xsl:text>
      <xsl:value-of select="url"/>
      <xsl:text>](</xsl:text>
      <xsl:value-of select="url"/>
      <xsl:text>) |&#10;</xsl:text>
    </xsl:if>

    <xsl:if test="sameAs">
      <xsl:for-each select="sameAs">
        <xsl:choose>
          <xsl:when test="position() = 1">
            <xsl:text>| **Also at** | </xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>| | </xsl:text>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:text>[</xsl:text>
        <xsl:value-of select="."/>
        <xsl:text>](</xsl:text>
        <xsl:value-of select="."/>
        <xsl:text>) |&#10;</xsl:text>
      </xsl:for-each>
    </xsl:if>

    <xsl:if test="knowsLanguage">
      <xsl:text>| **Languages** | </xsl:text>
      <xsl:for-each select="knowsLanguage">
        <xsl:if test="position() &gt; 1">
          <xsl:text>, </xsl:text>
        </xsl:if>
        <xsl:value-of select="."/>
      </xsl:for-each>
      <xsl:text> |&#10;</xsl:text>
    </xsl:if>

    <xsl:text>&#10;</xsl:text>

    <!-- TEAM -->
    <xsl:if test="member">
      <xsl:text>## Team&#10;&#10;</xsl:text>
      <xsl:text>| Name | ORCID |&#10;</xsl:text>
      <xsl:text>|---|---|&#10;</xsl:text>
      <xsl:for-each select="member">
        <xsl:text>| </xsl:text>
        <xsl:choose>
          <xsl:when test="@href">
            <xsl:text>[</xsl:text>
            <xsl:value-of select="."/>
            <xsl:text>](</xsl:text>
            <xsl:value-of select="@href"/>
            <xsl:text>)</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="."/>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:text> | </xsl:text>
        <xsl:if test="contains(@href, 'orcid.org/')">
          <xsl:text>`</xsl:text>
          <xsl:value-of select="substring-after(@href, 'orcid.org/')"/>
          <xsl:text>`</xsl:text>
        </xsl:if>
        <xsl:text> |&#10;</xsl:text>
      </xsl:for-each>
      <xsl:text>&#10;</xsl:text>
    </xsl:if>

    <!-- PARTNER ORGANISATIONS -->
    <xsl:if test="parentOrganization or memberOf">
      <xsl:text>## Partner Organisations&#10;&#10;</xsl:text>

      <xsl:if test="parentOrganization">
        <xsl:text>**Lead**&#10;&#10;</xsl:text>
        <xsl:text>- </xsl:text>
        <xsl:choose>
          <xsl:when test="parentOrganization/@href">
            <xsl:text>[</xsl:text>
            <xsl:value-of select="parentOrganization"/>
            <xsl:text>](</xsl:text>
            <xsl:value-of select="parentOrganization/@href"/>
            <xsl:text>)</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="parentOrganization"/>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:text>&#10;&#10;</xsl:text>
      </xsl:if>

      <xsl:if test="memberOf">
        <xsl:text>**Partners**&#10;&#10;</xsl:text>
        <xsl:for-each select="memberOf">
          <xsl:text>- </xsl:text>
          <xsl:choose>
            <xsl:when test="@href">
              <xsl:text>[</xsl:text>
              <xsl:value-of select="."/>
              <xsl:text>](</xsl:text>
              <xsl:value-of select="@href"/>
              <xsl:text>)</xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="."/>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:text>&#10;</xsl:text>
        </xsl:for-each>
        <xsl:text>&#10;</xsl:text>
      </xsl:if>
    </xsl:if>

    <!-- FUNDING -->
    <xsl:if test="funding">
      <xsl:text>## Funding&#10;&#10;</xsl:text>
      <xsl:for-each select="funding">
        <xsl:text>**</xsl:text>
        <xsl:value-of select="name"/>
        <xsl:text>**</xsl:text>
        <xsl:if test="identifier">
          <xsl:text> &#8211; Grant ID: </xsl:text>
          <xsl:value-of select="identifier/@value"/>
        </xsl:if>
        <xsl:if test="funder">
          <xsl:text> &#8211; </xsl:text>
          <xsl:value-of select="funder"/>
        </xsl:if>
        <xsl:if test="url">
          <xsl:text> &#8211; [</xsl:text>
          <xsl:value-of select="url"/>
          <xsl:text>](</xsl:text>
          <xsl:value-of select="url"/>
          <xsl:text>)</xsl:text>
        </xsl:if>
        <xsl:text>&#10;</xsl:text>
      </xsl:for-each>
      <xsl:text>&#10;</xsl:text>
    </xsl:if>

    <!-- SUBJECT AREAS -->
    <xsl:if test="knowsAbout">
      <xsl:text>## Subject Areas&#10;&#10;</xsl:text>
      <xsl:for-each select="knowsAbout">
        <xsl:if test="position() &gt; 1">
          <xsl:text> </xsl:text>
        </xsl:if>
        <xsl:text>`</xsl:text>
        <xsl:value-of select="."/>
        <xsl:text>`</xsl:text>
      </xsl:for-each>
      <xsl:text>&#10;&#10;</xsl:text>
    </xsl:if>

    <!-- KEYWORDS -->
    <xsl:if test="keywords">
      <xsl:text>## Keywords&#10;&#10;</xsl:text>
      <xsl:call-template name="keyword-pills">
        <xsl:with-param name="text" select="keywords"/>
      </xsl:call-template>
      <xsl:text>&#10;&#10;</xsl:text>
    </xsl:if>

    <!-- LICENCES -->
    <xsl:if test="hasCredential">
      <xsl:text>## Licences &amp; Copyright&#10;&#10;</xsl:text>
      <xsl:for-each select="hasCredential">
        <xsl:text>- **</xsl:text>
        <xsl:value-of select="name"/>
        <xsl:text>**</xsl:text>
        <xsl:if test="description">
          <xsl:text> &#8211; </xsl:text>
          <xsl:value-of select="description"/>
        </xsl:if>
        <xsl:for-each select="url">
          <xsl:text> [</xsl:text>
          <xsl:value-of select="."/>
          <xsl:text>](</xsl:text>
          <xsl:value-of select="."/>
          <xsl:text>)</xsl:text>
        </xsl:for-each>
        <xsl:text>&#10;</xsl:text>
      </xsl:for-each>
      <xsl:text>&#10;</xsl:text>
    </xsl:if>

  </xsl:template>

  <!-- ============================================================
       KEYWORD PILLS
       Splits a comma-separated string into `backtick` pill tokens.
  ============================================================ -->
  <xsl:template name="keyword-pills">
    <xsl:param name="text"/>
    <xsl:choose>
      <xsl:when test="contains($text, ', ')">
        <xsl:text>`</xsl:text>
        <xsl:value-of select="normalize-space(substring-before($text, ', '))"/>
        <xsl:text>` </xsl:text>
        <xsl:call-template name="keyword-pills">
          <xsl:with-param name="text" select="substring-after($text, ', ')"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>`</xsl:text>
        <xsl:value-of select="normalize-space($text)"/>
        <xsl:text>`</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
