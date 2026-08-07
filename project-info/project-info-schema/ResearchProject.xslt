<?xml version="1.0" encoding="UTF-8"?>
<!--
    ResearchProject.xslt
    Transforms a ResearchProject XML instance (ResearchProject.dtd) into an HTML5 webpage.

    APPLY – PowerShell (built-in, no extra tools needed):
        & {
            $x = [System.Xml.Xsl.XslCompiledTransform]::new($true)
            $x.Load("ResearchProject.xslt")
            $rs = [System.Xml.XmlReaderSettings]::new()
            $rs.DtdProcessing = [System.Xml.DtdProcessing]::Parse
            $r = [System.Xml.XmlReader]::Create("project-info-en.xml", $rs)
            $doc = [System.Xml.XPath.XPathDocument]::new($r); $r.Close()
            $tw = [System.IO.StreamWriter]::new("project-info-en.html", $false,
                      [System.Text.Encoding]::UTF8)
            $x.Transform($doc, $null, $tw); $tw.Close()
        }

    APPLY – xsltproc (Linux / macOS / WSL):
        xsltproc -o project-info-en.html ResearchProject.xslt project-info-en.xml

    APPLY – Saxon (cross-platform):
        java -jar saxon.jar -s:project-info-en.xml -xsl:ResearchProject.xslt -o:project-info-en.html

    BROWSER PREVIEW (Firefox only for local files; all browsers when served over HTTP):
        Add  <?xml-stylesheet type="text/xsl" href="ResearchProject.xslt"?>
        to the XML file, then open it in Firefox.
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html" version="5.0" encoding="UTF-8" indent="yes"/>

  <!-- ==============================================================
       ROOT TEMPLATE
  ============================================================== -->
  <xsl:template match="/ResearchProject">
    <html>
      <xsl:attribute name="lang">
        <xsl:choose>
          <xsl:when test="@xml:lang"><xsl:value-of select="@xml:lang"/></xsl:when>
          <xsl:otherwise>en</xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>

      <head>
        <meta charset="UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

        <xsl:if test="disambiguatingDescription">
          <meta name="description">
            <xsl:attribute name="content">
              <xsl:value-of select="disambiguatingDescription"/>
            </xsl:attribute>
          </meta>
        </xsl:if>
        <xsl:if test="keywords">
          <meta name="keywords">
            <xsl:attribute name="content">
              <xsl:value-of select="keywords"/>
            </xsl:attribute>
          </meta>
        </xsl:if>

        <title>
          <xsl:value-of select="name"/>
          <xsl:if test="alternateName">
            <xsl:text> (</xsl:text>
            <xsl:value-of select="alternateName"/>
            <xsl:text>)</xsl:text>
          </xsl:if>
        </title>

        <style>
/* ---- Reset ---- */
*, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

/* ---- Base ---- */
body {
  font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto,
               "Helvetica Neue", Arial, sans-serif;
  font-size: 16px;
  line-height: 1.65;
  color: #1a1a2e;
  background: #f0f4f8;
}
a { color: #1a5276; text-decoration: none; }
a:hover { color: #2e86c1; text-decoration: underline; }

/* ---- Header ---- */
header {
  background: linear-gradient(135deg, #1a3a5c 0%, #1e5280 100%);
  color: #fff;
  padding: 2.5rem 3rem 2rem;
}
.header-logos {
  display: flex;
  gap: 1rem;
  align-items: center;
  flex-wrap: wrap;
  margin-bottom: 1.75rem;
}
.header-logos img {
  height: 44px;
  width: auto;
  background: #fff;
  padding: 4px 10px;
  border-radius: 5px;
  object-fit: contain;
}
header h1 {
  font-size: 2rem;
  font-weight: 700;
  color: #fff;
  line-height: 1.25;
  margin-bottom: 0.4rem;
}
.acronym-badge {
  display: inline-block;
  background: #2e86c1;
  color: #fff;
  font-size: 0.78rem;
  font-weight: 700;
  letter-spacing: 0.08em;
  padding: 2px 10px;
  border-radius: 20px;
  vertical-align: middle;
  margin-left: 0.6rem;
}
.strapline {
  margin-top: 0.6rem;
  font-size: 1.05rem;
  color: #a8cce8;
  font-style: italic;
}

/* ---- Layout ---- */
main {
  max-width: 1080px;
  margin: 2rem auto 3rem;
  padding: 0 1.5rem;
  display: flex;
  flex-direction: column;
  gap: 1.5rem;
}

/* ---- Cards ---- */
.card {
  background: #fff;
  border-radius: 8px;
  padding: 1.75rem 2rem;
  box-shadow: 0 1px 5px rgba(0,0,0,0.09);
}
.card h2 {
  font-size: 0.75rem;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 0.1em;
  color: #1a5276;
  border-bottom: 2px solid #d6e8f8;
  padding-bottom: 0.5rem;
  margin-bottom: 1.1rem;
}

/* ---- Two-column grid ---- */
.two-col {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 1.5rem;
}
@media (max-width: 680px) {
  .two-col { grid-template-columns: 1fr; }
  header { padding: 1.5rem; }
  header h1 { font-size: 1.5rem; }
}

/* ---- Description ---- */
.description p {
  margin-bottom: 0.9rem;
  color: #2c2c3e;
}
.description p:last-child { margin-bottom: 0; }

/* ---- Definition list ---- */
dl { display: grid; grid-template-columns: max-content 1fr; gap: 0.3rem 1rem; }
dt {
  font-size: 0.78rem;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 0.06em;
  color: #6b7a99;
  align-self: start;
  padding-top: 0.15rem;
  white-space: nowrap;
}
dd { color: #1a1a2e; word-break: break-word; }
dd + dt { margin-top: 0.4rem; }
dd a { word-break: break-all; }

/* ---- Team ---- */
.team-list {
  list-style: none;
  display: flex;
  flex-wrap: wrap;
  gap: 0.75rem;
}
.team-list li {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  background: #f0f4f8;
  border-radius: 6px;
  padding: 0.55rem 1rem;
  border: 1px solid #d6e4f0;
}
.person-name {
  font-weight: 600;
  color: #1a3a5c;
}
.orcid-link {
  display: inline-block;
  background: #a6ce39;
  color: #fff !important;
  font-size: 0.68rem;
  font-weight: 700;
  letter-spacing: 0.05em;
  padding: 1px 7px;
  border-radius: 3px;
  text-decoration: none !important;
}
.orcid-link:hover { background: #8ab830 !important; }

/* ---- Tags / Keywords ---- */
.tag-cloud {
  display: flex;
  flex-wrap: wrap;
  gap: 0.45rem;
}
.tag {
  background: #dbeafe;
  color: #1e3a6e;
  padding: 3px 11px;
  border-radius: 14px;
  font-size: 0.82rem;
  font-weight: 500;
}

/* ---- Subject areas ---- */
.topics {
  list-style: none;
  display: flex;
  flex-wrap: wrap;
  gap: 0.45rem;
}
.topics li {
  background: #d1fae5;
  color: #064e3b;
  padding: 4px 12px;
  border-radius: 4px;
  font-size: 0.85rem;
  border-left: 3px solid #059669;
}

/* ---- Related links ---- */
.link-list {
  list-style: none;
  display: flex;
  flex-direction: column;
  gap: 0.45rem;
}
.link-list li::before { content: "↗\00a0"; color: #2e86c1; }
.link-list a { word-break: break-all; }

/* ---- Licences ---- */
.licence-list {
  list-style: none;
  display: flex;
  flex-direction: column;
  gap: 0.6rem;
}
.licence-list li {
  display: flex;
  flex-wrap: wrap;
  align-items: baseline;
  gap: 0.35rem;
  background: #faf5ff;
  border-left: 3px solid #7c3aed;
  padding: 0.55rem 1rem;
  border-radius: 0 4px 4px 0;
  font-size: 0.9rem;
}
.licence-name { font-weight: 700; color: #4c1d95; }
.licence-desc { color: #374151; }
.licence-url {
  font-size: 0.8rem;
  color: #7c3aed;
  word-break: break-all;
}

/* ---- Footer ---- */
footer {
  text-align: center;
  padding: 2rem 1rem;
  color: #8896b0;
  font-size: 0.82rem;
  border-top: 1px solid #d6e4f0;
}
footer a { color: #2e86c1; }
        </style>
      </head>

      <!-- ===========================================================
           BODY
      =========================================================== -->
      <body vocab="https://schema.org/" typeof="ResearchProject">

        <!-- HEADER -->
        <header>
          <xsl:if test="image/imageObject">
            <div class="header-logos">
              <xsl:for-each select="image/imageObject">
                <img>
                  <xsl:attribute name="src"><xsl:value-of select="contentUrl"/></xsl:attribute>
                  <xsl:attribute name="alt"><xsl:value-of select="caption"/></xsl:attribute>
                </img>
              </xsl:for-each>
            </div>
          </xsl:if>

          <h1>
            <span property="name"><xsl:value-of select="name"/></span>
            <xsl:if test="alternateName">
              <span class="acronym-badge" property="alternateName">
                <xsl:value-of select="alternateName"/>
              </span>
            </xsl:if>
          </h1>

          <xsl:if test="disambiguatingDescription">
            <p class="strapline" property="disambiguatingDescription">
              <xsl:value-of select="disambiguatingDescription"/>
            </p>
          </xsl:if>
        </header>

        <!-- MAIN -->
        <main>

          <!-- About -->
          <section class="card" id="about">
            <h2>About the Project</h2>
            <div class="description" property="description">
              <xsl:call-template name="text-to-paragraphs">
                <xsl:with-param name="text" select="description"/>
              </xsl:call-template>
            </div>
          </section>

          <!-- Details + Partners/Funding -->
          <div class="two-col">

            <section class="card" id="details">
              <h2>Project Details</h2>
              <dl>
                <xsl:if test="url">
                  <dt>Repository</dt>
                  <dd property="url">
                    <a href="{url}"><xsl:value-of select="url"/></a>
                  </dd>
                </xsl:if>

                <xsl:if test="foundingDate or dissolutionDate">
                  <dt>Period</dt>
                  <dd>
                    <span property="foundingDate"><xsl:value-of select="foundingDate"/></span>
                    <xsl:if test="dissolutionDate">
                      <xsl:text>&#160;–&#160;</xsl:text>
                      <span property="dissolutionDate"><xsl:value-of select="dissolutionDate"/></span>
                    </xsl:if>
                  </dd>
                </xsl:if>

                <xsl:for-each select="identifier">
                  <dt>Identifier</dt>
                  <dd property="identifier"><xsl:value-of select="."/></dd>
                </xsl:for-each>

                <xsl:for-each select="sameAs">
                  <dt>See also</dt>
                  <dd>
                    <a href="{.}" property="sameAs"><xsl:value-of select="."/></a>
                  </dd>
                </xsl:for-each>
              </dl>
            </section>

            <section class="card" id="partners">
              <h2>Partners &amp; Funding</h2>
              <dl>
                <xsl:if test="parentOrganization">
                  <dt>Lead</dt>
                  <dd property="parentOrganization">
                    <xsl:choose>
                      <xsl:when test="parentOrganization/@href">
                        <a href="{parentOrganization/@href}">
                          <xsl:value-of select="parentOrganization"/>
                        </a>
                      </xsl:when>
                      <xsl:otherwise><xsl:value-of select="parentOrganization"/></xsl:otherwise>
                    </xsl:choose>
                  </dd>
                </xsl:if>

                <xsl:if test="memberOf">
                  <xsl:for-each select="memberOf">
                    <dt>Partner</dt>
                    <dd property="memberOf">
                      <xsl:choose>
                        <xsl:when test="@href">
                          <a href="{@href}"><xsl:value-of select="."/></a>
                        </xsl:when>
                        <xsl:otherwise><xsl:value-of select="."/></xsl:otherwise>
                      </xsl:choose>
                    </dd>
                  </xsl:for-each>
                </xsl:if>

                <xsl:for-each select="funder">
                  <dt>Funder</dt>
                  <dd property="funder">
                    <xsl:choose>
                      <xsl:when test="@href">
                        <a href="{@href}"><xsl:value-of select="."/></a>
                      </xsl:when>
                      <xsl:otherwise><xsl:value-of select="."/></xsl:otherwise>
                    </xsl:choose>
                  </dd>
                </xsl:for-each>

                <xsl:for-each select="funding">
                  <dt>Grant</dt>
                  <dd property="funding">
                    <xsl:value-of select="name"/>
                    <xsl:if test="identifier">
                      <xsl:text> — </xsl:text>
                      <xsl:value-of select="identifier"/>
                    </xsl:if>
                    <xsl:if test="funder">
                      <xsl:text> (</xsl:text><xsl:value-of select="funder"/><xsl:text>)</xsl:text>
                    </xsl:if>
                    <xsl:if test="url">
                      <xsl:text> </xsl:text>
                      <a href="{url}" title="Grant details">&#8599;</a>
                    </xsl:if>
                  </dd>
                </xsl:for-each>
              </dl>
            </section>

          </div><!-- /.two-col -->

          <!-- Team -->
          <xsl:if test="member">
            <section class="card" id="team">
              <h2>Team</h2>
              <ul class="team-list">
                <xsl:for-each select="member">
                  <li property="member" typeof="schema:Person">
                    <xsl:choose>
                      <xsl:when test="@href">
                        <span class="person-name" property="name"><xsl:value-of select="."/></span>
                        <a class="orcid-link" href="{@href}" property="url"
                           title="View ORCID profile">ORCID</a>
                      </xsl:when>
                      <xsl:otherwise>
                        <span class="person-name" property="name"><xsl:value-of select="."/></span>
                      </xsl:otherwise>
                    </xsl:choose>
                  </li>
                </xsl:for-each>
              </ul>
            </section>
          </xsl:if>

          <!-- Keywords -->
          <xsl:if test="keywords">
            <section class="card" id="keywords">
              <h2>Keywords</h2>
              <div class="tag-cloud">
                <xsl:call-template name="keyword-tags">
                  <xsl:with-param name="text" select="keywords"/>
                </xsl:call-template>
              </div>
            </section>
          </xsl:if>

          <!-- Subject areas -->
          <xsl:if test="knowsAbout">
            <section class="card" id="subject-areas">
              <h2>Subject Areas</h2>
              <ul class="topics">
                <xsl:for-each select="knowsAbout">
                  <li property="knowsAbout"><xsl:value-of select="."/></li>
                </xsl:for-each>
              </ul>
            </section>
          </xsl:if>

          <!-- Licences & Copyright -->
          <xsl:if test="hasCredential">
            <section class="card" id="licences">
              <h2>Licences &amp; Copyright</h2>
              <ul class="licence-list">
                <xsl:for-each select="hasCredential">
                  <li>
                    <span class="licence-name"><xsl:value-of select="name"/></span>
                    <xsl:if test="description">
                      <span class="licence-desc">&#8212; <xsl:value-of select="description"/></span>
                    </xsl:if>
                    <xsl:if test="url">
                      <a class="licence-url" href="{url}"><xsl:value-of select="url"/></a>
                    </xsl:if>
                  </li>
                </xsl:for-each>
              </ul>
            </section>
          </xsl:if>

        </main><!-- /main -->

        <!-- FOOTER -->
        <footer>
          <p>
            <xsl:text>Structured as </xsl:text>
            <a href="https://schema.org/ResearchProject">schema:ResearchProject</a>
            <xsl:text>&#160;|&#160;Metadata: </xsl:text>
            <a href="https://creativecommons.org/publicdomain/zero/1.0/">CC0</a>
            <xsl:text>&#160;|&#160;Content: </xsl:text>
            <a href="https://creativecommons.org/licenses/by-sa/4.0/">CC BY-SA 4.0</a>
            <xsl:text>&#160;|&#160;Code: MIT</xsl:text>
          </p>
        </footer>

      </body>
    </html>
  </xsl:template>

  <!-- ==============================================================
       NAMED TEMPLATE: text-to-paragraphs
       Splits plain text on double newlines, outputs one <p> per block.
       normalize-space() is applied per paragraph so XML indentation
       does not bleed into the output.
  ============================================================== -->
  <xsl:template name="text-to-paragraphs">
    <xsl:param name="text"/>
    <xsl:choose>
      <xsl:when test="contains($text, '&#10;&#10;')">
        <xsl:variable name="chunk" select="substring-before($text, '&#10;&#10;')"/>
        <xsl:if test="normalize-space($chunk) != ''">
          <p><xsl:value-of select="normalize-space($chunk)"/></p>
        </xsl:if>
        <xsl:call-template name="text-to-paragraphs">
          <xsl:with-param name="text" select="substring-after($text, '&#10;&#10;')"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:if test="normalize-space($text) != ''">
          <p><xsl:value-of select="normalize-space($text)"/></p>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- ==============================================================
       NAMED TEMPLATE: keyword-tags
       Splits a comma-separated keyword string into .tag <span>s.
  ============================================================== -->
  <xsl:template name="keyword-tags">
    <xsl:param name="text"/>
    <xsl:choose>
      <xsl:when test="contains($text, ',')">
        <span class="tag">
          <xsl:value-of select="normalize-space(substring-before($text, ','))"/>
        </span>
        <xsl:call-template name="keyword-tags">
          <xsl:with-param name="text" select="substring-after($text, ',')"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:if test="normalize-space($text) != ''">
          <span class="tag"><xsl:value-of select="normalize-space($text)"/></span>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
