<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    version="1.0"
    exclude-result-prefixes="tei">
    
    <xsl:output method="html" indent="yes" encoding="UTF-8"/>
    
    <xsl:template match="/tei:TEI">
        <html>
            <head>
                <meta charset="UTF-8"/>
                <title>
                    <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/>
                </title>
                <style>
                    body {
                    font-family: Arial, sans-serif;
                    max-width: 800px;
                    margin: 40px auto;
                    padding: 20px;
                    background: #f9f9f9;
                    color: #333;
                    line-height: 1.5;
                    }
                    h1, h2 {
                    margin-bottom: 0.3em;
                    }
                    .metadata {
                    background: #ffffff;
                    border: 1px solid #ddd;
                    padding: 15px;
                    margin-bottom: 20px;
                    }
                    .label {
                    font-weight: bold;
                    }
                    .video-block {
                    background: #ffffff;
                    border: 1px solid #ddd;
                    padding: 15px;
                    }
                    a {
                    text-decoration: underline;
                    }
                </style>
            </head>
            <body>
                
                
                <h1>
                    <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/>
                </h1>
                
                
                <div class="metadata">
                    <p>
                            <span class="label">Autore: </span>
                            <xsl:apply-templates select="tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:author"/>
                        
                        
                    </p>
                    
                    <p>
                        <span class="label">Dettagli: </span>
                        <!-- prendo il paragrafo dentro sourceDesc per fare una breve introduzione -->
                        <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:p"/>
                    </p>
                    
                </div>
                
                
                <xsl:apply-templates select="tei:text/tei:body"/>
                
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
    
    <!-- Link per placeName con @ref (Wikidata, Geonames, ecc.) -->
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
    
    <!-- (Come sopra) Link per persName e Author con @ref -->
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
        <div class="video-block">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    
    <xsl:template match="tei:div">
        <h2>
            <xsl:value-of select="tei:head"/>
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
    
    <!-- Copia solo il testo -->
    <xsl:template match="text()">
        <xsl:value-of select="."/>
    </xsl:template>
    
</xsl:stylesheet>
