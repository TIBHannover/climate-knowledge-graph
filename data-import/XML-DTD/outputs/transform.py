#!/usr/bin/env python3
"""
XSLT transformation script to convert AR6.xml to HTML
"""

import xml.etree.ElementTree as ET
from lxml import etree
import os

def transform_xml_to_html(xml_file, xsl_file, output_file):
    """
    Transform XML file using XSLT stylesheet and save as HTML
    
    Args:
        xml_file: Path to the XML file
        xsl_file: Path to the XSLT stylesheet
        output_file: Path to save the output HTML file
    """
    try:
        # Parse XML and XSLT files
        xml_doc = etree.parse(xml_file)
        xsl_doc = etree.parse(xsl_file)
        
        # Create XSLT transformer
        transform = etree.XSLT(xsl_doc)
        
        # Apply transformation
        html_doc = transform(xml_doc)
        
        # Write output
        with open(output_file, 'wb') as f:
            f.write(etree.tostring(html_doc, pretty_print=True, encoding='UTF-8'))
        
        print(f"✓ Transformation successful!")
        print(f"✓ HTML file created: {output_file}")
        print(f"✓ File size: {os.path.getsize(output_file)} bytes")
        
        return True
        
    except FileNotFoundError as e:
        print(f"✗ Error: File not found - {e}")
        return False
    except etree.XSLTParseError as e:
        print(f"✗ XSLT Parse Error: {e}")
        return False
    except Exception as e:
        print(f"✗ Error during transformation: {e}")
        return False

if __name__ == "__main__":
    # File paths
    script_dir = os.path.dirname(os.path.abspath(__file__))
    xml_file = os.path.join(script_dir, "AR6.xml")
    xsl_file = os.path.join(script_dir, "AR6.xsl")
    output_file = os.path.join(script_dir, "AR6.html")
    
    print("=" * 60)
    print("AR6 XML to HTML XSLT Transformation")
    print("=" * 60)
    print(f"XML Input:  {xml_file}")
    print(f"XSL Input:  {xsl_file}")
    print(f"HTML Output: {output_file}")
    print("=" * 60)
    
    # Verify files exist
    if not os.path.exists(xml_file):
        print(f"✗ XML file not found: {xml_file}")
        exit(1)
    if not os.path.exists(xsl_file):
        print(f"✗ XSL file not found: {xsl_file}")
        exit(1)
    
    # Run transformation
    success = transform_xml_to_html(xml_file, xsl_file, output_file)
    
    if success:
        print(f"\n✓ Open the HTML file in your browser: {output_file}")
        exit(0)
    else:
        exit(1)
