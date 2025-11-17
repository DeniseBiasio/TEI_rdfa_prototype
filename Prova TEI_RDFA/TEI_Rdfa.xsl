<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    version="1.0">
    
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>
    
    <xsl:template match="/tei:TEI">
        <html>
            <head>
                <title>
                    <xsl:value-of select="//tei:title[@xml:id='Work_CU']"/>
                </title>
  
                <style>
                    body {
                    font-family: Arial, sans-serif;
                    margin: 40px;
                    max-width: 800px;
                    line-height: 1.6;
                    color: #333;
                    }
                    h1, h2 {
                    color: #444;
                    border-bottom: 1px solid #ccc;
                    padding-bottom: 5px;
                    }
                    .block {
                    margin-bottom: 20px;
                    padding: 10px;
                    border: 1px solid #ddd;
                    background: #fafafa;
                    }
                    .label {
                    font-weight: bold;
                    }
                </style>
            </head>
            
            <body>
                
                <h1>
                    <xsl:value-of select="//tei:title[@xml:id='Work_CU']"/>
                </h1>
                
                <!-- AUTORE -->
                <div class="block">
                    <span class="label">Autore: </span>
                    <xsl:value-of select="//tei:author"/>
                </div>
                
                
                <!-- INFORMAZIONI SULLA PERFORMANCE -->
                <div class="block">
                    <h2>Performance</h2>
                    <span class="label">Luogo: </span>
                    <xsl:value-of select="//tei:setting/tei:placeName"/>
                    <br/>
                    <span class="label">Date: </span>
                    <xsl:for-each select="//tei:setting/tei:date">
                        <xsl:value-of select="."/>
                        <xsl:if test="position() != last()">; </xsl:if>
                    </xsl:for-each>
                </div>
                
                <!-- REGIA / PERSONE -->
                <div class="block">
                    <h2>Cast</h2>
                    <xsl:value-of select="//tei:person[@xml:id='SM']/tei:occupation"/>:
                    <xsl:value-of select="//tei:person[@xml:id='SM']/tei:persName"/>
                    
                </div>
                
                <!-- VIDEO -->
                <div class="block">
                    <h2>Registrazione video</h2>
                    <xsl:apply-templates select="//tei:div[@type='Video_Recording']"/>
                </div>
                
            </body>
        </html>
    </xsl:template>
    
    
    <!-- TEMPLATE PER LA SEZIONE VIDEO -->
    <xsl:template match="tei:div[@type='Video_Recording']">
        <div>
            <p>
                <span class="label">Dettagli: </span>
                <xsl:value-of select="//tei:sourceDesc/tei:p"/>
            </p>
            
            <p>
                <span class="label">Link video: </span>
                <xsl:apply-templates select="tei:p[3]/tei:ref"/>
            </p>
        </div>
    </xsl:template>
    
    
    <xsl:template match="tei:ref">
        <a href="{@href}">
            <xsl:apply-templates/>
        </a>
    </xsl:template>
    
</xsl:stylesheet>
