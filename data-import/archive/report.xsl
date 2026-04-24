<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="UTF-8" indent="yes"/>

  <!-- Root template -->
  <xsl:template match="/series">
    <html>
      <head>
        <meta charset="UTF-8"/>
        <title><xsl:value-of select="title"/></title>
        <style>
          body {
            font-family: Segoe UI, Arial, sans-serif;
            font-size: 14px;
            color: #1a1a2e;
            background: #f5f7fa;
            margin: 0;
            padding: 24px;
          }
          h1 {
            font-size: 1.5em;
            color: #1c3d5a;
            border-bottom: 2px solid #2e86ab;
            padding-bottom: 8px;
            margin-bottom: 16px;
          }
          h2 {
            font-size: 1.15em;
            color: #2e86ab;
            margin-top: 28px;
            margin-bottom: 8px;
          }
          h3 {
            font-size: 1em;
            color: #1c3d5a;
            margin-top: 20px;
            margin-bottom: 6px;
          }
          .meta-table {
            border-collapse: collapse;
            margin-bottom: 20px;
          }
          .meta-table td {
            padding: 4px 10px 4px 0;
            vertical-align: top;
          }
          .meta-table td:first-child {
            font-weight: bold;
            color: #555;
            white-space: nowrap;
            min-width: 90px;
          }
          table.chapters {
            border-collapse: collapse;
            width: 100%;
            margin-bottom: 20px;
            background: #fff;
            box-shadow: 0 1px 3px rgba(0,0,0,0.07);
          }
          table.chapters th {
            background: #2e86ab;
            color: #fff;
            padding: 8px 10px;
            text-align: left;
            font-weight: 600;
          }
          table.chapters td {
            padding: 6px 10px;
            border-bottom: 1px solid #e8edf2;
            vertical-align: top;
          }
          table.chapters tr:last-child td {
            border-bottom: none;
          }
          table.chapters tr:nth-child(even) td {
            background: #f0f6fb;
          }
          .id-badge {
            display: inline-block;
            background: #2e86ab;
            color: #fff;
            border-radius: 3px;
            padding: 1px 6px;
            font-size: 0.85em;
            margin-right: 4px;
          }
          a {
            color: #2e86ab;
            text-decoration: none;
          }
          a:hover {
            text-decoration: underline;
          }
          .tag {
            display: inline-block;
            background: #e1f1f8;
            color: #1c6a8a;
            border-radius: 10px;
            padding: 2px 8px;
            margin: 2px;
            font-size: 0.85em;
          }
          .section-box {
            background: #fff;
            border-radius: 6px;
            box-shadow: 0 1px 4px rgba(0,0,0,0.08);
            padding: 16px 20px;
            margin-bottom: 24px;
          }
        </style>
      </head>
      <body>
        <h1><xsl:value-of select="title"/></h1>

        <!-- Series metadata -->
        <div class="section-box">
          <table class="meta-table">
            <tr>
              <td>Description:</td>
              <td><xsl:value-of select="description"/></td>
            </tr>
            <tr>
              <td>DOI:</td>
              <td>
                <a href="https://doi.org/{doi}">
                  <xsl:value-of select="doi"/>
                </a>
              </td>
            </tr>
            <tr>
              <td>License:</td>
              <td><xsl:value-of select="license"/></td>
            </tr>
            <tr>
              <td>Date:</td>
              <td><xsl:value-of select="date"/></td>
            </tr>
            <tr>
              <td>Tags:</td>
              <td>
                <xsl:call-template name="render-tags">
                  <xsl:with-param name="tags" select="tags"/>
                </xsl:call-template>
              </td>
            </tr>
          </table>
        </div>

        <!-- Front Matter -->
        <xsl:if test="front_matter/report">
          <h2>Front Matter</h2>
          <div class="section-box">
            <table class="chapters">
              <tr>
                <th>Label</th>
                <th>DOI</th>
                <th>OpenAlex</th>
                <th>Links</th>
              </tr>
              <xsl:apply-templates select="front_matter/report"/>
            </table>
          </div>
        </xsl:if>

        <!-- Books -->
        <xsl:apply-templates select="books/book"/>

      </body>
    </html>
  </xsl:template>

  <!-- Front matter report row -->
  <xsl:template match="front_matter/report">
    <tr>
      <td><xsl:value-of select="label"/></td>
      <td>
        <a href="https://doi.org/{doi}">
          <xsl:value-of select="doi"/>
        </a>
      </td>
      <td>
        <xsl:if test="openalex != ''">
          <a href="https://openalex.org/works/{openalex}">
            <xsl:value-of select="openalex"/>
          </a>
        </xsl:if>
      </td>
      <td>
        <xsl:if test="wiki != ''">
          <a href="{wiki}">Wiki</a>
          <xsl:text> </xsl:text>
        </xsl:if>
        <xsl:if test="pdf != ''">
          <a href="{pdf}">PDF</a>
        </xsl:if>
      </td>
    </tr>
  </xsl:template>

  <!-- Book section -->
  <xsl:template match="book">
    <h2>
      <span class="id-badge">
        <xsl:value-of select="@id"/>
      </span>
      <xsl:value-of select="title"/>
    </h2>
    <div class="section-box">
      <table class="chapters">
        <tr>
          <th>#</th>
          <th>Label</th>
          <th>DOI</th>
          <th>OpenAlex</th>
          <th>Links</th>
        </tr>
        <xsl:apply-templates select="chapters/chapter"/>
      </table>
    </div>
  </xsl:template>

  <!-- Chapter row -->
  <xsl:template match="chapter">
    <tr>
      <td><xsl:value-of select="@id"/></td>
      <td><xsl:value-of select="label"/></td>
      <td>
        <a href="https://doi.org/{doi}">
          <xsl:value-of select="doi"/>
        </a>
      </td>
      <td>
        <xsl:if test="openalex != ''">
          <a href="https://openalex.org/works/{openalex}">
            <xsl:value-of select="openalex"/>
          </a>
        </xsl:if>
      </td>
      <td>
        <xsl:if test="wiki != ''">
          <a href="{wiki}">Wiki</a>
          <xsl:text> </xsl:text>
        </xsl:if>
        <xsl:if test="source != ''">
          <a href="{source}">Web</a>
          <xsl:text> </xsl:text>
        </xsl:if>
        <xsl:if test="pdf != ''">
          <a href="{pdf}">PDF</a>
        </xsl:if>
      </td>
    </tr>
  </xsl:template>

  <!-- Tag renderer: splits semicolon-delimited tags -->
  <xsl:template name="render-tags">
    <xsl:param name="tags"/>
    <xsl:choose>
      <xsl:when test="contains($tags, ';')">
        <span class="tag">
          <xsl:value-of select="normalize-space(substring-before($tags, ';'))"/>
        </span>
        <xsl:call-template name="render-tags">
          <xsl:with-param name="tags" select="substring-after($tags, ';')"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:if test="normalize-space($tags) != ''">
          <span class="tag">
            <xsl:value-of select="normalize-space($tags)"/>
          </span>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
