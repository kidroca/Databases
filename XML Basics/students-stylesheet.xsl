<xsl:stylesheet version="2.0"
            xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
            xmlns:st="urn:students">

  <xsl:output method="html"/>

  <xsl:template match="/">
    <html>
      <body>
        <h2>Students</h2>
        <ul>
          <xsl:for-each select="st:students/st:student">
            <li>
              <h3>
                <xsl:value-of select="st:name"/>
              </h3>
              <ul>
                <li>
                  <strong>Sex: </strong> <xsl:value-of select="st:sex"/>
                </li>
                <li>
                  <strong>Email: </strong> <xsl:value-of select="st:email"/>
                </li>
                <li>
                  <strong>Phone: </strong> <xsl:value-of select="st:phone"/>
                </li>
                <li>
                  <strong>Course: </strong> <xsl:value-of select="st:course"/>
                </li>
                <li>
                  <strong>Specialty: </strong> <xsl:value-of select="st:specialty"/>
                </li>
                <li>
                  <strong>Faculty Number: </strong> <xsl:value-of select="st:faculty-number"/>
                </li>
                <li>
                  <strong>Birthday: </strong> <xsl:value-of select="st:birth-date"/>
                </li>
                <li>
                  <strong>Endorsements: </strong> <em>
                    <xsl:value-of select="st:endorsements"/>
                  </em>
                </li>
                <li><strong>Exams: </strong>
                <ul>
                  <xsl:for-each select="st:exams/st:exam">
                    <li>
                      <xsl:value-of select="st:name"/>: <xsl:value-of select="st:score"/>
                    </li>
                  </xsl:for-each>
                </ul>
                </li>
                <li>
                <strong>Enrollment Information: </strong>
                <ul>
                  <li>
                    Date: <xsl:value-of select="st:enrollment-info/st:enrollment-date"/>
                  </li>
                  <li>
                    Exam Score: <xsl:value-of select="st:enrollment-info/st:exam-score"/>
                  </li>
                </ul>
                </li>
              </ul>
            </li>
          </xsl:for-each>
        </ul>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>