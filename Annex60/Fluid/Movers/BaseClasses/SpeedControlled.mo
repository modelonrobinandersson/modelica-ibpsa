within Annex60.Fluid.Movers.BaseClasses;
partial model SpeedControlled
  "Partial model for fan or pump with speed (y or Nrpm) as input signal"
 extends Annex60.Fluid.Movers.BaseClasses.FlowMachineInterface(
   V_flow_max(start=V_flow_nominal),
   final rho_default = Medium.density_pTX(
     p=Medium.p_default,
     T=Medium.T_default,
     X=Medium.X_default),
     VMachine_flow = -port_b.m_flow/rho,
     rho = Medium.density(
       Medium.setState_phX(port_a.p,
                           inStream(port_a.h_outflow),
                           inStream(port_a.Xi_outflow))));

 extends Annex60.Fluid.Movers.BaseClasses.PartialFlowMachine(
     final m_flow_nominal = max(_per_y.pressure.V_flow)*rho_default,
     preSou(final control_m_flow=false));

protected
 Modelica.Blocks.Sources.RealExpression dpMac(y=-dpMachine)
    "Pressure drop of the pump or fan"
   annotation (Placement(transformation(extent={{0,20},{20,40}})));

 Modelica.Blocks.Sources.RealExpression PToMedium_flow(y=Q_flow + WFlo) if
      addPowerToMedium "Heat and work input into medium"
   annotation (Placement(transformation(extent={{-100,10},{-80,30}})));
protected
  Modelica.Blocks.Math.Gain gaiSpe(
    u(min=0),
    y(final unit="1",
      nominal=1)) "Gain for speed input signal"
    annotation (Placement(transformation(extent={{6,44},{18,56}})));
equation
  if filteredSpeed then
    connect(gaiSpe.y, filter.u) annotation (Line(
      points={{18.6,50},{18,50},{18,88},{18.6,88}},
      color={0,0,127},
      smooth=Smooth.None));
    connect(filter.y, y_actual) annotation (Line(
      points={{34.7,88},{60.35,88},{60.35,50},{110,50}},
      color={0,0,127},
      smooth=Smooth.None));
    connect(filter.y, y_filtered) annotation (Line(
      points={{34.7,88},{50,88}},
      color={0,0,127},
      smooth=Smooth.None));

  else
    connect(gaiSpe.y, y_actual) annotation (Line(
      points={{18.6,50},{110,50}},
      color={0,0,127},
      smooth=Smooth.None));
  end if;

  connect(inputSwitch.y, gaiSpe.u) annotation (Line(
      points={{1,50},{4.8,50}},
      color={0,0,127},
      smooth=Smooth.None));

 connect(preSou.dp_in, dpMac.y) annotation (Line(
     points={{36,8},{36,30},{21,30}},
     color={0,0,127}));
 connect(PToMedium_flow.y, prePow.Q_flow) annotation (Line(
     points={{-79,20},{-70,20}},
     color={0,0,127}));
 annotation (
   Documentation(info="<html>
<p>This is the base model for fans and pumps that take as
input a control signal in the form of the pump speed <code>Nrpm</code>
or the normalized pump speed <code>y=Nrpm/per.N_nominal</code>.
</p>
</html>",
     revisions="<html>
<ul>
<li>
November 19, 2015, by Michael Wetter:<br/>
Switched the two <code>extends</code> statements to get the
inherited graphic objects on the correct layer.
</li>      
<li>
October 8, 2013, by Michael Wetter:<br/>
Removed parameter <code>show_V_flow</code>.
</li>
<li>
May 25, 2011, by Michael Wetter:<br/>
Revised implementation of energy balance to avoid having to use conditionally removed models.
</li>
<li>
July 27, 2010, by Michael Wetter:<br/>
Redesigned model to fix bug in medium balance.
</li>
<li>March 24 2010, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end SpeedControlled;
