<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:schema="http://schema.org/"
    xmlns:frbroo="http://iflastandards.info/ns/fr/frbr/frbroo/"
    version="1.0"
    exclude-result-prefixes="tei rdf schema frbroo">

    <xsl:output method="html" indent="yes" encoding="UTF-8"/>

    <xsl:template match="/tei:TEI">
        <!-- variabile che importa il file RDF esterno -->
        <xsl:variable name="rdf" select="document('RDF.xml')"/>

        <!-- varibili specifiche -->
        <xsl:variable name="work" select="$rdf/rdf:RDF/frbroo:F1_Work[@rdf:about='#Work_CU']"/>
        <xsl:variable name="perf" select="$rdf/rdf:RDF/frbroo:F31_Performance[@rdf:about='#Perf_Volterra_2009']"/>
        <xsl:variable name="rec"  select="$rdf/rdf:RDF/frbroo:F26_Recording[@rdf:about='#Atto1_Parte1']"/>

        <xsl:variable name="authorPerson" select="$rdf/rdf:RDF/schema:Person[@rdf:about='#AS']"/>
        <xsl:variable name="directorPerson" select="$rdf/rdf:RDF/schema:Person[@rdf:about='#SM']"/>

        <xsl:variable name="placeURI" select="$perf/schema:location/@rdf:resource"/>
        <xsl:variable name="place" select="$rdf/rdf:RDF/schema:Place[@rdf:about=$placeURI]"/>

        <html lang="it">
            <head>
                <meta charset="UTF-8"/>
                <title>
                    <xsl:value-of select="normalize-space(tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title)"/>
                </title>

                
                <style>
                    body {
                      font-family: Arial, sans-serif;
                      margin: 40px auto;
                      padding: 20px;
                      background: #f9f9f9;
                      color: #333;
                      line-height: 1.5;
                      max-width: 1100px;
                    }
                    h1, h2, h3 {
                      margin-top: 0;
                      margin-bottom: 0.4em;
                    }
                    a {
                      text-decoration: underline;
                      color: #004b80;
                    }
                    a:hover {
                      color: #002f4d;
                    }

                    /* Layout a due colonne */
                    .page-wrapper {
                      display: flex;
                      gap: 20px;
                      align-items: flex-start;
                    }

                    .sidebar {
                      flex: 0 0 32%;
                      background: #ffffff;
                      border: 1px solid #ddd;
                      border-radius: 4px;
                      padding: 15px;
                      box-sizing: border-box;
                    }

                    .sidebar h2 {
                      font-size: 1.1rem;
                      text-transform: uppercase;
                      letter-spacing: 0.05em;
                      margin-bottom: 0.8rem;
                      border-bottom: 1px solid #eee;
                      padding-bottom: 0.4rem;
                    }

                    .sidebar-section {
                      margin-bottom: 1rem;
                    }

                    .sidebar-section h3 {
                      font-size: 1rem;
                      margin-bottom: 0.3rem;
                    }

                    .sidebar-section p {
                      margin: 0.1rem 0;
                      font-size: 0.92rem;
                    }

                    .label {
                      font-weight: bold;
                    }

                    .main-content {
                      flex: 1;
                      box-sizing: border-box;
                    }

                    .metadata {
                      background: #ffffff;
                      border: 1px solid #ddd;
                      border-radius: 4px;
                      padding: 15px;
                      margin-bottom: 20px;
                    }

                    .video-block {
                      background: #ffffff;
                      border: 1px solid #ddd;
                      border-radius: 4px;
                      padding: 15px;
                    }

                    .video-block p {
                      margin-top: 0.4rem;
                      margin-bottom: 0.4rem;
                    }
                </style>
            </head>

            <body>
                <div class="page-wrapper">

                    <!-- Colonna Metadati -->
                    <aside class="sidebar">
                        <h2>Metadati</h2>

                        
                        <div class="sidebar-section">
                            <h3>Opera</h3>
                            <p>
                                <span class="label">Titolo: </span>
                                <xsl:value-of select="$work/schema:name"/>
                            </p>
                            <xsl:if test="$work/schema:creator/@rdf:resource">
                                <xsl:variable name="authURI" select="$work/schema:creator/@rdf:resource"/>
                                <xsl:variable name="authNode" select="$rdf/rdf:RDF/schema:Person[@rdf:about=$authURI]"/>
                                <p>
                                    <span class="label">Autore: </span>
                                    <xsl:value-of select="$authNode/schema:name"/>
                                </p>
                            </xsl:if>
                        </div>

                        
                        <div class="sidebar-section">
                            <h3>Performance</h3>
                            <p>
                                <span class="label">Tipo: </span>F31_Performance
                            </p>
                            <xsl:if test="$perf/frbroo:R80_performed/@rdf:resource">
                                <p>
                                    <span class="label">Opera rappresentata: </span>
                                    <xsl:value-of select="$work/schema:name"/>
                                </p>
                            </xsl:if>

                            <xsl:if test="$place">
                                <p>
                                    <span class="label">Luogo: </span>
                                    <a href="{$placeURI}">
                                        <xsl:value-of select="$place/schema:name"/>
                                    </a>
                                </p>
                            </xsl:if>

                            <xsl:if test="$perf/schema:startDate">
                                <p>
                                    <span class="label">Data inizio: </span>
                                    <xsl:value-of select="$perf/schema:startDate"/>
                                </p>
                            </xsl:if>
                            <xsl:if test="$perf/schema:endDate">
                                <p>
                                    <span class="label">Data fine: </span>
                                    <xsl:value-of select="$perf/schema:endDate"/>
                                </p>
                            </xsl:if>
                        </div>

                        
                        <div class="sidebar-section">
                            <h3>File Video</h3>
                            <p>
                                <span class="label">Tipo: </span>F26_Recording
                            </p>

                            <xsl:if test="$rec/schema:director/@rdf:resource">
                                <xsl:variable name="dirURI" select="$rec/schema:director/@rdf:resource"/>
                                <xsl:variable name="dirNode" select="$rdf/rdf:RDF/schema:Person[@rdf:about=$dirURI]"/>
                                <p>
                                    <span class="label">Regia: </span>
                                    <xsl:value-of select="$dirNode/schema:name"/>
                                    <xsl:if test="$dirNode/schema:jobTitle">
                                        <xsl:text> (</xsl:text>
                                        <xsl:value-of select="$dirNode/schema:jobTitle"/>
                                        <xsl:text>)</xsl:text>
                                    </xsl:if>
                                </p>
                            </xsl:if>

                            <xsl:if test="normalize-space($rec/schema:contentUrl)">
                                <p>
                                    <span class="label">Video URL: </span>
                                    <a href="{normalize-space($rec/schema:contentUrl)}">
                                        <xsl:value-of select="normalize-space($rec/schema:contentUrl)"/>
                                    </a>
                                </p>
                            </xsl:if>
                        </div>
                    </aside>

                    <!-- Colonna TEI -->
                    <main class="main-content">
                        <h1>
                            <xsl:value-of select="normalize-space(tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title)"/>
                        </h1>

                        
                        <div class="metadata">
                            <p>
                                <span class="label">Autore: </span>
                                <xsl:apply-templates select="tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:author"/>
                            </p>

                            <p>
                                <span class="label">Dettagli: </span>
                                <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:p"/>
                            </p>
                        </div>

                        
                        <div class="video-block">
                            <xsl:apply-templates select="tei:text/tei:body"/>
                        </div>
                    </main>

                </div>
            </body>
        </html>
    </xsl:template>

    
    <xsl:template match="tei:setting">
        <xsl:apply-templates select="tei:placeName"/>
        <xsl:text> — </xsl:text>
        <xsl:for-each select="tei:date">
            <xsl:value-of select="."/>
            <xsl:if test="position() != last()">
                <xsl:text>; </xsl:text>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>

    
    <xsl:template match="tei:placeName">
        <xsl:choose>
            <xsl:when test="@ref">
                <a href="{@ref}">
                    <xsl:apply-templates/>
                </a>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    
    <xsl:template match="tei:persName">
        <xsl:choose>
            <xsl:when test="@ref">
                <a href="{@ref}">
                    <xsl:apply-templates/>
                </a>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    
    <xsl:template match="tei:author">
        <xsl:choose>
            <xsl:when test="@ref">
                <a href="{@ref}">
                    <xsl:apply-templates/>
                </a>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    
    <xsl:template match="tei:body">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="tei:div">
        <h2>
            <xsl:value-of select="normalize-space(tei:head)"/>
        </h2>
        <xsl:apply-templates select="tei:p"/>
    </xsl:template>

    <xsl:template match="tei:p">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    
    <xsl:template match="tei:ref">
        <a href="{@target}">
            <xsl:apply-templates/>
        </a>
    </xsl:template>

    <xsl:template match="text()">
        <xsl:value-of select="."/>
    </xsl:template>

</xsl:stylesheet>
