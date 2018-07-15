within IBPSA.Fluid.HeatExchangers.GroundHeatExchangers.Data.ConfigurationData;
record Template
  "Template for ConfigurationData records"
  extends Modelica.Icons.Record;

  parameter IBPSA.Fluid.HeatExchangers.GroundHeatExchangers.Types.BoreHoleConfiguration borCon
    "Borehole configuration";

  parameter Boolean use_Rb = false
    "True if the value borehole thermal resistance Rb should be given and used";
  parameter Real Rb(unit="(m.K)/W") = 0.0
    "Borehole thermal resistance Rb. Only to fill in if known";
  parameter Modelica.SIunits.MassFlowRate mBor_flow_nominal
    "Nominal mass flow rate per borehole";
  parameter Modelica.SIunits.MassFlowRate mBorFie_flow_nominal = mBor_flow_nominal*nbBor
    "Nominal mass flow of borefield";
  parameter Modelica.SIunits.Pressure dp_nominal
    "Pressure losses for the entire borefield";

  //------------------------- Geometrical parameters ---------------------------
  parameter Modelica.SIunits.Height hBor "Total height of the borehole"
    annotation (Dialog(group="Borehole"));
  parameter Modelica.SIunits.Radius rBor "Radius of the borehole"
    annotation (Dialog(group="Borehole"));
  parameter Modelica.SIunits.Height dBor "Borehole buried depth" annotation (Dialog(group="Borehole"));
  parameter Integer nbBor "Total number of boreholes"
    annotation (Dialog(group="Borehole"));

  parameter Real[nbBor,2] cooBor
    "Cartesian coordinates of the boreholes in meters."
    annotation (Dialog(group="Borehole"));

  // -- Tube
  parameter Modelica.SIunits.Radius rTub "Outer radius of the tubes"
    annotation (Dialog(group="Tubes"));
  parameter Modelica.SIunits.ThermalConductivity kTub "Thermal conductivity of the tube"
    annotation (Dialog(group="Tubes"));

  parameter Modelica.SIunits.Length eTub "Thickness of a tube"
    annotation (Dialog(group="Tubes"));

  parameter Modelica.SIunits.Length xC
    "Shank spacing, defined as the distance between the center of a pipe and the center of the borehole"
    annotation (Dialog(group="Tubes"));

  //------------------------- Advanced parameters ------------------------------

  /*--------Flow: */
  parameter Modelica.SIunits.MassFlowRate mBor_flow_small(min=0) = 1E-4*abs(mBor_flow_nominal)
    "Small mass flow rate for regularization of zero flow"
    annotation (Dialog(tab="Nominal condition"));

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram( coordinateSystem(preserveAspectRatio=false)),
    Documentation(
info="<html>
<p>This record is a template for the records in
<a href=\"modelica://IBPSA.Fluid.HeatExchangers.GroundHeatExchangers.Data.ConfigurationData\">
IBPSA.Fluid.HeatExchangers.GroundHeatExchangers.Data.ConfigurationData</a>.</p>
</html>",
revisions="<html>
<ul>
<li>
July 28, 2018, by Damien Picard:<br/>
First implementation.
</li>
</ul>
</html>"));
end Template;
