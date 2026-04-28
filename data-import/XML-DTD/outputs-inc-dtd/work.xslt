<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="UTF-8" doctype-public="-//W3C//DTD HTML 4.01//EN" doctype-system="http://www.w3.org/TR/html4/strict.dtd"/>

  <xsl:template match="/">
    <html>
      <head>
        <meta charset="UTF-8"/>
        <title><xsl:value-of select="//publication/title"/></title>
        <style type="text/css">
          body { font-family: Arial, sans-serif; margin: 2em; line-height: 1.6; }
          h1 { color: #333; border-bottom: 3px solid #333; padding-bottom: 0.5em; }
          h2 { color: #555; border-bottom: 2px solid #555; padding-bottom: 0.3em; margin-top: 1.5em; }
          h3 { color: #777; margin-top: 1em; }
          h4 { color: #999; margin-top: 0.5em; margin-bottom: 0.3em; }
          .publication { margin-bottom: 3em; }
          .series { margin-left: 2em; margin-bottom: 2em; }
          .front-matter { margin-left: 2em; background-color: #f9f9f9; padding: 1em; border-left: 4px solid #ddd; }
          .books { margin-left: 2em; }
          .book { margin-left: 2em; background-color: #fafafa; padding: 1em; border-left: 4px solid #ccc; margin-bottom: 1.5em; }
          .chapter { margin-left: 2em; margin-bottom: 0.8em; padding: 0.3em 0; }
          .metadata { font-size: 0.9em; color: #666; margin: 0.5em 0; }
          .metadata-inline { font-size: 0.9em; color: #666; margin: 0.3em 0; display: flex; flex-wrap: wrap; gap: 1em; align-items: center; }
          .metadata-inline span { white-space: nowrap; }
          .metadata span { display: inline-block; margin-right: 1em; }
          .doi, .license, .date, .tags { font-size: 0.85em; color: #888; }
          a { color: #0066cc; text-decoration: none; }
          a:hover { text-decoration: underline; }
          .url { word-break: break-all; font-size: 0.9em; color: #666; }
        </style>
      </head>
      <body>
        <xsl:apply-templates select="work"/>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="work">
    <xsl:apply-templates select="publication"/>
  </xsl:template>

  <xsl:template match="publication">
    <div class="publication">
      <h1><xsl:value-of select="title"/></h1>
      <p class="metadata"><xsl:value-of select="description"/></p>
      <xsl:apply-templates select="series"/>
    </div>
  </xsl:template>

  <xsl:template match="series">
    <div class="series">
      <h2><xsl:value-of select="title"/></h2>
      <p class="metadata"><xsl:value-of select="description"/></p>
      <div class="metadata-inline">
        <xsl:if test="doi">
          <a href="https://doi.org/{doi}" class="doi"><xsl:value-of select="doi"/></a>
        </xsl:if>
        <xsl:if test="license">
          <span class="license"><xsl:value-of select="license"/></span>
        </xsl:if>
        <xsl:if test="date">
          <span class="date"><xsl:value-of select="date"/></span>
        </xsl:if>
        <xsl:if test="tags">
          <span class="tags"><xsl:value-of select="tags"/></span>
        </xsl:if>
      </div>
      <xsl:apply-templates select="front_matter"/>
      <xsl:apply-templates select="books"/>
    </div>
  </xsl:template>

  <xsl:template match="front_matter">
    <div class="front-matter">
      <h3>Front Matter</h3>
      <xsl:apply-templates select="chapter"/>
    </div>
  </xsl:template>

  <xsl:template match="books">
    <div class="books">
      <xsl:apply-templates select="book"/>
    </div>
  </xsl:template>

  <xsl:template match="book">
    <div class="book">
      <h3><xsl:value-of select="title"/></h3>
      <xsl:apply-templates select="chapters"/>
    </div>
  </xsl:template>

  <xsl:template match="chapters">
    <xsl:apply-templates select="chapter"/>
  </xsl:template>

  <xsl:template match="chapter">
    <div class="chapter">
      <h4><xsl:value-of select="title"/></h4>
      <xsl:if test="wiki or source or pdf or doi or openalex">
        <div class="metadata-inline">
          <xsl:if test="wiki">
            <a href="{wiki}">Wiki</a>
          </xsl:if>
          <xsl:if test="source">
            <a href="{source}">Source</a>
          </xsl:if>
          <xsl:if test="pdf">
            <a href="{pdf}">PDF</a>
          </xsl:if>
          <xsl:if test="doi">
            <a href="https://doi.org/{doi}"><xsl:value-of select="doi"/></a>
          </xsl:if>
          <xsl:if test="openalex">
            <a href="https://openalex.org/{openalex}"><xsl:value-of select="openalex"/></a>
          </xsl:if>
        </div>
      </xsl:if>
    </div>
  </xsl:template>

</xsl:stylesheet>
