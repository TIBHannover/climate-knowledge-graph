<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="UTF-8" indent="yes" doctype-public="-//W3C//DTD HTML 4.01//EN" doctype-system="http://www.w3.org/TR/html4/strict.dtd"/>
  
  <xsl:template match="/work">
    <html>
      <head>
        <meta charset="UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>
          <xsl:value-of select="publication/title"/>
        </title>
        <style>
          * { margin: 0; padding: 0; box-sizing: border-box; }
          body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; line-height: 1.6; color: #333; background-color: #f5f5f5; }
          .container { max-width: 1200px; margin: 0 auto; padding: 20px; }
          header { background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%); color: white; padding: 40px 0; margin-bottom: 30px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
          header h1 { font-size: 2.5em; margin-bottom: 10px; }
          header p { font-size: 1.1em; opacity: 0.9; }
          .publication-desc { background: white; padding: 20px; margin-bottom: 30px; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); }
          .series { background: white; margin-bottom: 30px; padding: 25px; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); border-left: 5px solid #2a5298; }
          .series h2 { color: #1e3c72; margin-bottom: 15px; font-size: 1.8em; }
          .series-meta { display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 15px; margin: 15px 0; padding: 15px; background: #f9f9f9; border-radius: 5px; }
          .meta-item { }
          .meta-label { font-weight: bold; color: #2a5298; font-size: 0.9em; text-transform: uppercase; }
          .meta-value { color: #555; margin-top: 5px; word-break: break-word; }
          .meta-value a { color: #2a5298; text-decoration: none; }
          .meta-value a:hover { text-decoration: underline; }
          .tags { display: flex; flex-wrap: wrap; gap: 8px; margin-top: 10px; }
          .tag { background: #e8f0f8; color: #1e3c72; padding: 5px 12px; border-radius: 20px; font-size: 0.9em; }
          .front-matter, .books { margin-top: 20px; }
          .front-matter h3, .books h3 { color: #1e3c72; margin-top: 20px; margin-bottom: 15px; font-size: 1.3em; border-bottom: 2px solid #e0e0e0; padding-bottom: 10px; }
          .chapter { background: #f9f9f9; padding: 15px; margin-bottom: 12px; border-radius: 5px; border-left: 3px solid #5cafd8; }
          .chapter-header { display: flex; justify-content: space-between; align-items: start; gap: 20px; margin-bottom: 10px; }
          .chapter-title { font-weight: bold; color: #1e3c72; font-size: 1.1em; flex: 1; }
          .chapter-id { background: #e8f0f8; color: #2a5298; padding: 3px 8px; border-radius: 3px; font-size: 0.85em; white-space: nowrap; }
          .chapter-links { display: grid; grid-template-columns: repeat(auto-fit, minmax(150px, 1fr)); gap: 10px; margin-top: 10px; font-size: 0.9em; }
          .chapter-link { }
          .chapter-link a { color: #2a5298; text-decoration: none; display: inline-block; padding: 5px 0; }
          .chapter-link a:hover { text-decoration: underline; }
          .link-label { color: #888; font-size: 0.85em; }
          footer { text-align: center; padding: 20px; color: #888; margin-top: 40px; border-top: 1px solid #e0e0e0; }
          .license { color: #d9534f; font-weight: bold; }
        </style>
      </head>
      <body>
        <div class="container">
          <header>
            <h1>
              <xsl:value-of select="publication/title"/>
            </h1>
            <p>
              <xsl:value-of select="publication/description"/>
            </p>
          </header>
          
          <div class="publication-desc">
            <p>This document presents the structure of the <strong><xsl:value-of select="publication/title"/></strong>, containing multiple special reports and assessment chapters with comprehensive climate research and policy guidance.</p>
          </div>
          
          <xsl:apply-templates select="publication/series"/>
          
          <footer>
            <p>Generated from AR6.xml using XSLT transformation</p>
            <p>
              <xsl:value-of select="publication/title"/> - All content subject to respective licenses
            </p>
          </footer>
        </div>
      </body>
    </html>
  </xsl:template>
  
  <xsl:template match="series">
    <div class="series">
      <h2>
        <xsl:value-of select="title"/>
      </h2>
      
      <div class="series-meta">
        <div class="meta-item">
          <div class="meta-label">Description</div>
          <div class="meta-value">
            <xsl:value-of select="description"/>
          </div>
        </div>
        <div class="meta-item">
          <div class="meta-label">DOI</div>
          <div class="meta-value">
            <a>
              <xsl:attribute name="href">https://doi.org/<xsl:value-of select="doi"/></xsl:attribute>
              <xsl:attribute name="target">_blank</xsl:attribute>
              <xsl:value-of select="doi"/>
            </a>
          </div>
        </div>
        <div class="meta-item">
          <div class="meta-label">License</div>
          <div class="meta-value license">
            <xsl:value-of select="license"/>
          </div>
        </div>
        <div class="meta-item">
          <div class="meta-label">Publication Date</div>
          <div class="meta-value">
            <xsl:value-of select="date"/>
          </div>
        </div>
      </div>
      
      <xsl:if test="tags">
        <div class="tags">
          <xsl:for-each select="tags">
            <xsl:call-template name="split-tags">
              <xsl:with-param name="text">
                <xsl:value-of select="."/>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:for-each>
        </div>
      </xsl:if>
      
      <xsl:if test="front_matter">
        <div class="front-matter">
          <h3>Front Matter</h3>
          <xsl:apply-templates select="front_matter/chapter"/>
        </div>
      </xsl:if>
      
      <xsl:if test="books">
        <div class="books">
          <h3>Main Content</h3>
          <xsl:apply-templates select="books/book/chapters/chapter"/>
        </div>
      </xsl:if>
    </div>
  </xsl:template>
  
  <xsl:template match="chapter">
    <div class="chapter">
      <div class="chapter-header">
        <div class="chapter-title">
          <xsl:value-of select="title"/>
        </div>
        <div class="chapter-id">
          Chapter <xsl:value-of select="@id"/>
        </div>
      </div>
      
      <div class="chapter-links">
        <xsl:if test="source">
          <div class="chapter-link">
            <div class="link-label">Source</div>
            <a>
              <xsl:attribute name="href">
                <xsl:value-of select="source"/>
              </xsl:attribute>
              <xsl:attribute name="target">_blank</xsl:attribute>
              View Online
            </a>
          </div>
        </xsl:if>
        
        <xsl:if test="pdf">
          <div class="chapter-link">
            <div class="link-label">PDF</div>
            <a>
              <xsl:attribute name="href">
                <xsl:value-of select="pdf"/>
              </xsl:attribute>
              <xsl:attribute name="target">_blank</xsl:attribute>
              Download PDF
            </a>
          </div>
        </xsl:if>
        
        <xsl:if test="doi">
          <div class="chapter-link">
            <div class="link-label">DOI</div>
            <a>
              <xsl:attribute name="href">https://doi.org/<xsl:value-of select="doi"/></xsl:attribute>
              <xsl:attribute name="target">_blank</xsl:attribute>
              <xsl:value-of select="doi"/>
            </a>
          </div>
        </xsl:if>
        
        <xsl:if test="wiki">
          <div class="chapter-link">
            <div class="link-label">Wiki</div>
            <a>
              <xsl:attribute name="href">
                <xsl:value-of select="wiki"/>
              </xsl:attribute>
              <xsl:attribute name="target">_blank</xsl:attribute>
              Wiki Page
            </a>
          </div>
        </xsl:if>
        
        <xsl:if test="openalex">
          <div class="chapter-link">
            <div class="link-label">OpenAlex</div>
            <a>
              <xsl:attribute name="href">https://openalex.org/<xsl:value-of select="openalex"/></xsl:attribute>
              <xsl:attribute name="target">_blank</xsl:attribute>
              <xsl:value-of select="openalex"/>
            </a>
          </div>
        </xsl:if>
      </div>
    </div>
  </xsl:template>
  
  <xsl:template name="split-tags">
    <xsl:param name="text"/>
    <xsl:choose>
      <xsl:when test="contains($text, '; ')">
        <span class="tag">
          <xsl:value-of select="normalize-space(substring-before($text, '; '))"/>
        </span>
        <xsl:call-template name="split-tags">
          <xsl:with-param name="text">
            <xsl:value-of select="substring-after($text, '; ')"/>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <span class="tag">
          <xsl:value-of select="normalize-space($text)"/>
        </span>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
