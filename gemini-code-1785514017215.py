# Generate draw.io XML file for Diagram #2 (Sequential Workflow Diagram)

drawio_xml_v2 = """<mxfile host="Electron" modified="2026-07-31T18:05:00.000Z" agent="Mozilla/5.0" version="21.6.8" type="device">
  <diagram id="ipcc_sequential_schematic" name="IPCC Sequential Transformation Schematic">
    <mxGraphModel dx="1400" dy="900" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="1654" pageHeight="1169" math="0" shadow="0">
      <root>
        <mxCell id="0" />
        <mxCell id="1" parent="0" />

        <!-- Title -->
        <mxCell id="title" value="# IPCC REPORT - KNOWLEDGE TRANSFORMATION SCHEMATIC" style="text;html=1;strokeColor=none;fillColor=none;align=left;verticalAlign=middle;whiteSpace=wrap;rounded=0;fontSize=26;fontStyle=1;fontColor=#1E293B;" vertex="1" parent="1">
          <mxGeometry x="40" y="30" width="800" height="40" as="geometry" />
        </mxCell>

        <!-- TOP BAR: SYSTEM STATE: OPERATIONAL (AFTER) -->
        <mxCell id="after_container" value="" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#F0F9FF;strokeColor=#0284C7;strokeWidth=2;" vertex="1" parent="1">
          <mxGeometry x="240" y="90" width="1370" height="230" as="geometry" />
        </mxCell>
        <mxCell id="after_header" value="SYSTEM STATE: OPERATIONAL (AFTER)" style="rounded=0;whiteSpace=wrap;html=1;fillColor=#0284C7;strokeColor=none;fontStyle=1;fontSize=14;fontColor=#FFFFFF;align=center;" vertex="1" parent="after_container">
          <mxGeometry x="0" y="0" width="1370" height="32" as="geometry" />
        </mxCell>

        <mxCell id="after_title" value="Dynamic data service" style="text;html=1;strokeColor=none;fillColor=none;align=center;verticalAlign=middle;whiteSpace=wrap;fontSize=20;fontStyle=1;fontColor=#0369A1;" vertex="1" parent="after_container">
          <mxGeometry x="500" y="40" width="370" height="30" as="geometry" />
        </mxCell>

        <!-- Inner Graph network representation -->
        <mxCell id="node_temp" value="Temperature" style="ellipse;whiteSpace=wrap;html=1;fillColor=#FFEDD5;strokeColor=#F97316;fontStyle=1;fontSize=12;" vertex="1" parent="after_container">
          <mxGeometry x="600" y="100" width="110" height="50" as="geometry" />
        </mxCell>
        <mxCell id="node_co2" value="CO2" style="ellipse;whiteSpace=wrap;html=1;fillColor=#DCFCE7;strokeColor=#16A34A;fontStyle=1;fontSize=12;" vertex="1" parent="after_container">
          <mxGeometry x="440" y="90" width="80" height="40" as="geometry" />
        </mxCell>
        <mxCell id="node_sealevel" value="Sea level" style="ellipse;whiteSpace=wrap;html=1;fillColor=#E0F2FE;strokeColor=#0284C7;fontStyle=1;fontSize=12;" vertex="1" parent="after_container">
          <mxGeometry x="510" y="160" width="90" height="40" as="geometry" />
        </mxCell>
        <mxCell id="node_author" value="Author" style="ellipse;whiteSpace=wrap;html=1;fillColor=#F3E8FF;strokeColor=#9333EA;fontStyle=1;fontSize=12;" vertex="1" parent="after_container">
          <mxGeometry x="780" y="90" width="80" height="40" as="geometry" />
        </mxCell>
        <mxCell id="node_datapoint" value="DataPoint" style="ellipse;whiteSpace=wrap;html=1;fillColor=#FEF3C7;strokeColor=#D97706;fontStyle=1;fontSize=12;" vertex="1" parent="after_container">
          <mxGeometry x="780" y="160" width="90" height="40" as="geometry" />
        </mxCell>
        <mxCell id="node_policy" value="Policy actions" style="ellipse;whiteSpace=wrap;html=1;fillColor=#FCE7F3;strokeColor=#DB2777;fontStyle=1;fontSize=12;" vertex="1" parent="after_container">
          <mxGeometry x="640" y="170" width="110" height="40" as="geometry" />
        </mxCell>

        <!-- Edges inside After Graph -->
        <mxCell id="edge1" style="endArrow=none;html=1;strokeWidth=1.5;strokeColor=#64748B;" edge="1" parent="after_container" source="node_co2" target="node_temp" />
        <mxCell id="edge2" style="endArrow=none;html=1;strokeWidth=1.5;strokeColor=#64748B;" edge="1" parent="after_container" source="node_sealevel" target="node_temp" />
        <mxCell id="edge3" style="endArrow=none;html=1;strokeWidth=1.5;strokeColor=#64748B;" edge="1" parent="after_container" source="node_temp" target="node_author" />
        <mxCell id="edge4" style="endArrow=none;html=1;strokeWidth=1.5;strokeColor=#64748B;" edge="1" parent="after_container" source="node_author" target="node_datapoint" />
        <mxCell id="edge5" style="endArrow=none;html=1;strokeWidth=1.5;strokeColor=#64748B;" edge="1" parent="after_container" source="node_temp" target="node_policy" />

        <!-- LEFT SIDEBAR LABEL: TRANSFORMATION PATHWAY -->
        <mxCell id="pathway_label" value="TRANSFORMATION PATHWAY" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#334155;strokeColor=none;fontStyle=1;fontSize=16;fontColor=#FFFFFF;rotation=-90;" vertex="1" parent="1">
          <mxGeometry x="-160" y="550" width="400" height="40" as="geometry" />
        </mxCell>

        <!-- STEP 1: INITIAL STATE (BEFORE) -->
        <mxCell id="step1_box" value="" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#F8FAFC;strokeColor=#94A3B8;strokeWidth=1.5;" vertex="1" parent="1">
          <mxGeometry x="80" y="350" width="220" height="450" as="geometry" />
        </mxCell>
        <mxCell id="step1_header" value="STEP 1: INITIAL STATE (BEFORE)" style="rounded=0;whiteSpace=wrap;html=1;fillColor=#64748B;strokeColor=none;fontStyle=1;fontSize=13;fontColor=#FFFFFF;align=center;" vertex="1" parent="step1_box">
          <mxGeometry x="0" y="0" width="220" height="35" as="geometry" />
        </mxCell>
        <mxCell id="step1_browser" value="&lt;b&gt;[ Browsable Website ]&lt;/b&gt;&lt;br&gt;&lt;br&gt;&amp;bull; Static document tree&lt;br&gt;&amp;bull; HTML pages&lt;br&gt;&amp;bull; Manual browsing" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#FFFFFF;strokeColor=#CBD5E1;fontSize=13;align=center;verticalAlign=middle;" vertex="1" parent="step1_box">
          <mxGeometry x="20" y="120" width="180" height="200" as="geometry" />
        </mxCell>
        <mxCell id="step1_footer" value="&lt;b&gt;Browsable website&lt;/b&gt;" style="text;html=1;strokeColor=none;fillColor=none;align=center;verticalAlign=middle;fontSize=15;fontColor=#334155;" vertex="1" parent="step1_box">
          <mxGeometry x="10" y="370" width="200" height="40" as="geometry" />
        </mxCell>

        <!-- ARROW STEP 1 -> STEP 2 -->
        <mxCell id="arrow_1_2" value="" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;strokeWidth=3;strokeColor=#2563EB;endArrow=classic;endFill=1;" edge="1" parent="1" source="step1_box" target="step2_box">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <!-- STEP 2: MAKE KNOWLEDGE GRAPH -->
        <mxCell id="step2_box" value="" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#EFF6FF;strokeColor=#3B82F6;strokeWidth=1.5;" vertex="1" parent="1">
          <mxGeometry x="340" y="350" width="600" height="450" as="geometry" />
        </mxCell>
        <mxCell id="step2_header" value="STEP 2: MAKE KNOWLEDGE GRAPH" style="rounded=0;whiteSpace=wrap;html=1;fillColor=#2563EB;strokeColor=none;fontStyle=1;fontSize=14;fontColor=#FFFFFF;align=center;" vertex="1" parent="step2_box">
          <mxGeometry x="0" y="0" width="600" height="35" as="geometry" />
        </mxCell>

        <!-- Sub-block: In -->
        <mxCell id="step2_in" value="" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#DBEAFE;strokeColor=#93C5FD;" vertex="1" parent="step2_box">
          <mxGeometry x="20" y="55" width="160" height="370" as="geometry" />
        </mxCell>
        <mxCell id="step2_in_title" value="In" style="rounded=0;whiteSpace=wrap;html=1;fillColor=#3B82F6;fontStyle=1;fontSize=14;fontColor=#FFFFFF;align=center;" vertex="1" parent="step2_in">
          <mxGeometry x="0" y="0" width="160" height="30" as="geometry" />
        </mxCell>
        <mxCell id="step2_in_content" value="&lt;b&gt;Website&lt;/b&gt;&lt;br&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;- Browsable site&lt;/font&gt;" style="text;html=1;strokeColor=none;fillColor=none;align=center;verticalAlign=middle;fontSize=13;" vertex="1" parent="step2_in">
          <mxGeometry x="10" y="120" width="140" height="100" as="geometry" />
        </mxCell>

        <!-- Sub-block: Build -->
        <mxCell id="step2_build" value="" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#FFFFFF;strokeColor=#60A5FA;strokeWidth=1.5;" vertex="1" parent="step2_box">
          <mxGeometry x="200" y="55" width="200" height="370" as="geometry" />
        </mxCell>
        <mxCell id="step2_build_title" value="Build" style="rounded=0;whiteSpace=wrap;html=1;fillColor=#1D4ED8;fontStyle=1;fontSize=14;fontColor=#FFFFFF;align=center;" vertex="1" parent="step2_build">
          <mxGeometry x="0" y="0" width="200" height="30" as="geometry" />
        </mxCell>
        <mxCell id="build_ds" value="&lt;b&gt;&amp;bull; Datasets&lt;/b&gt;&lt;br&gt;&amp;nbsp;&amp;nbsp;&amp;nbsp;&lt;font color=&quot;#64748B&quot;&gt;- Convert to data&lt;/font&gt;" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#F8FAFC;strokeColor=#E2E8F0;align=left;spacingLeft=10;fontSize=12;" vertex="1" parent="step2_build">
          <mxGeometry x="15" y="60" width="170" height="110" as="geometry" />
        </mxCell>
        <mxCell id="build_er_model" value="&lt;b&gt;&amp;bull; ER model&lt;/b&gt;&lt;br&gt;&amp;nbsp;&amp;nbsp;&amp;nbsp;&lt;font color=&quot;#64748B&quot;&gt;- Connect data&lt;/font&gt;" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#F8FAFC;strokeColor=#E2E8F0;align=left;spacingLeft=10;fontSize=12;" vertex="1" parent="step2_build">
          <mxGeometry x="15" y="200" width="170" height="120" as="geometry" />
        </mxCell>

        <!-- Sub-block: Out -->
        <mxCell id="step2_out" value="" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#F0FDF4;strokeColor=#86EFAC;" vertex="1" parent="step2_box">
          <mxGeometry x="420" y="55" width="160" height="370" as="geometry" />
        </mxCell>
        <mxCell id="step2_out_title" value="Out" style="rounded=0;whiteSpace=wrap;html=1;fillColor=#16A34A;fontStyle=1;fontSize=14;fontColor=#FFFFFF;align=center;" vertex="1" parent="step2_out">
          <mxGeometry x="0" y="0" width="160" height="30" as="geometry" />
        </mxCell>
        <mxCell id="step2_out_content" value="&lt;b&gt;Knowledge graph&lt;/b&gt;&lt;br&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;- Structured data resource&lt;/font&gt;" style="text;html=1;strokeColor=none;fillColor=none;align=center;verticalAlign=middle;fontSize=13;" vertex="1" parent="step2_out">
          <mxGeometry x="10" y="120" width="140" height="100" as="geometry" />
        </mxCell>

        <!-- ARROWS WITHIN STEP 2 -->
        <mxCell id="arrow_in_to_build" value="" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;strokeWidth=2;strokeColor=#2563EB;endArrow=classic;endFill=1;" edge="1" parent="step2_box" source="step2_in" target="step2_build">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="arrow_build_to_out" value="" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;strokeWidth=2;strokeColor=#16A34A;endArrow=classic;endFill=1;" edge="1" parent="step2_box" source="step2_build" target="step2_out">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <!-- STEP 3A: KNOWLEDGE GRAPH SERVICES -->
        <mxCell id="step3a_box" value="" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#F0FDF4;strokeColor=#4ADE80;strokeWidth=1.5;" vertex="1" parent="1">
          <mxGeometry x="980" y="350" width="630" height="210" as="geometry" />
        </mxCell>
        <mxCell id="step3a_header" value="STEP 3A: KNOWLEDGE GRAPH SERVICES" style="rounded=0;whiteSpace=wrap;html=1;fillColor=#16A34A;strokeColor=none;fontStyle=1;fontSize=14;fontColor=#FFFFFF;align=center;" vertex="1" parent="step3a_box">
          <mxGeometry x="0" y="0" width="630" height="35" as="geometry" />
        </mxCell>

        <mxCell id="s_qa" value="&lt;b&gt;Q&amp;amp;A&lt;/b&gt;" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#FFFFFF;strokeColor=#86EFAC;fontSize=13;fontStyle=1;fontColor=#15803D;" vertex="1" parent="step3a_box">
          <mxGeometry x="20" y="60" width="130" height="120" as="geometry" />
        </mxCell>
        <mxCell id="s_meta" value="&lt;b&gt;Extend library metadata&lt;/b&gt;" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#FFFFFF;strokeColor=#86EFAC;fontSize=13;fontStyle=1;fontColor=#15803D;align=center;" vertex="1" parent="step3a_box">
          <mxGeometry x="170" y="60" width="130" height="120" as="geometry" />
        </mxCell>
        <mxCell id="s_dist" value="&lt;b&gt;Document distribution&lt;/b&gt;" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#FFFFFF;strokeColor=#86EFAC;fontSize=13;fontStyle=1;fontColor=#15803D;align=center;" vertex="1" parent="step3a_box">
          <mxGeometry x="320" y="60" width="130" height="120" as="geometry" />
        </mxCell>
        <mxCell id="s_bench" value="&lt;b&gt;Data Bench&lt;/b&gt;" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#FFFFFF;strokeColor=#86EFAC;fontSize=13;fontStyle=1;fontColor=#15803D;" vertex="1" parent="step3a_box">
          <mxGeometry x="470" y="60" width="140" height="120" as="geometry" />
        </mxCell>

        <!-- STEP 3B: USERS -->
        <mxCell id="step3b_box" value="" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#FFFBEE;strokeColor=#FDE047;strokeWidth=1.5;" vertex="1" parent="1">
          <mxGeometry x="980" y="590" width="630" height="210" as="geometry" />
        </mxCell>
        <mxCell id="step3b_header" value="STEP 3B: USERS" style="rounded=0;whiteSpace=wrap;html=1;fillColor=#CA8A04;strokeColor=none;fontStyle=1;fontSize=14;fontColor=#FFFFFF;align=center;" vertex="1" parent="step3b_box">
          <mxGeometry x="0" y="0" width="630" height="35" as="geometry" />
        </mxCell>

        <mxCell id="u_public" value="&lt;b&gt;Public&lt;/b&gt;&lt;br&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;- Learn about climate science&lt;/font&gt;" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#FFFFFF;strokeColor=#FEF08A;fontSize=12;align=center;" vertex="1" parent="step3b_box">
          <mxGeometry x="20" y="55" width="180" height="130" as="geometry" />
        </mxCell>
        <mxCell id="u_sci" value="&lt;b&gt;Scientists&lt;/b&gt;&lt;br&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;- Data analysis and contribute to knowledge graph&lt;br&gt;&lt;i&gt;(Inout to knowledge graph)&lt;/i&gt;&lt;/font&gt;" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#FFFFFF;strokeColor=#FEF08A;fontSize=12;align=center;" vertex="1" parent="step3b_box">
          <mxGeometry x="220" y="55" width="200" height="130" as="geometry" />
        </mxCell>
        <mxCell id="u_policy" value="&lt;b&gt;Policy makers&lt;/b&gt;&lt;br&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;- Fast access to docs and data&lt;/font&gt;" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#FFFFFF;strokeColor=#FEF08A;fontSize=12;align=center;" vertex="1" parent="step3b_box">
          <mxGeometry x="440" y="55" width="170" height="130" as="geometry" />
        </mxCell>

        <!-- CONNECTING ARROWS -->
        <mxCell id="arrow_out_to_services" value="" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;strokeWidth=2.5;strokeColor=#16A34A;endArrow=classic;endFill=1;" edge="1" parent="1" source="step2_out" target="step3a_box">
          <mxGeometry relative="1" as="geometry">
            <Array as="points">
              <mxPoint x="950" y="540" />
              <mxPoint x="950" y="455" />
            </Array>
          </mxGeometry>
        </mxCell>

        <mxCell id="arrow_out_to_users" value="" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;strokeWidth=2.5;strokeColor=#CA8A04;endArrow=classic;endFill=1;" edge="1" parent="1" source="step2_out" target="step3b_box">
          <mxGeometry relative="1" as="geometry">
            <Array as="points">
              <mxPoint x="950" y="540" />
              <mxPoint x="950" y="695" />
            </Array>
          </mxGeometry>
        </mxCell>

        <!-- FEEDBACK / SYSTEM STATE ARROWS TO AFTER -->
        <mxCell id="arrow_services_to_after" value="" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;strokeWidth=2;strokeColor=#0284C7;endArrow=classic;endFill=1;" edge="1" parent="1" source="step3a_box" target="after_container">
          <mxGeometry relative="1" as="geometry">
            <Array as="points">
              <mxPoint x="1640" y="455" />
              <mxPoint x="1640" y="205" />
            </Array>
          </mxGeometry>
        </mxCell>

        <mxCell id="arrow_users_to_after" value="" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;strokeWidth=2;strokeColor=#0284C7;endArrow=classic;endFill=1;" edge="1" parent="1" source="step3b_box" target="after_container">
          <mxGeometry relative="1" as="geometry">
            <Array as="points">
              <mxPoint x="1640" y="695" />
              <mxPoint x="1640" y="205" />
            </Array>
          </mxGeometry>
        </mxCell>

        <!-- INOUT BIDIRECTIONAL ARROW BETWEEN SCIENTISTS & KNOWLEDGE GRAPH -->
        <mxCell id="arrow_inout" value="Inout" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;strokeWidth=2;strokeColor=#DC2626;endArrow=classic;startArrow=classic;endFill=1;startFill=1;fontSize=12;fontStyle=1;" edge="1" parent="1" source="u_sci" target="step2_out">
          <mxGeometry relative="1" as="geometry">
            <Array as="points">
              <mxPoint x="1300" y="820" />
              <mxPoint x="840" y="820" />
            </Array>
          </mxGeometry>
        </mxCell>

      </root>
    </mxGraphModel>
  </diagram>
</mxfile>
"""

with open("ipcc_report_schematic_diagram2.drawio", "w", encoding="utf-8") as f:
    f.write(drawio_xml_v2)

print("Diagram 2 generated successfully.")