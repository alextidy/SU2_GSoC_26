// Parameters 
D_jet = 0.001;
jet_r = D_jet / 2;
h_domain = 10*D_jet;
L_domain = 100*D_jet;
lc = 1.0;               // Characteristic length

// Points - conical domain
Point(1) = {0, 0, 0, lc};        // Bottom left
Point(2) = {0, jet_r, 0, lc};    // Jet inlet
Point(3) = {0, h_domain, 0, lc}; // Top left
Point(4) = {L_domain, 0, 0, lc};        // Bottom right
Point(5) = {L_domain, jet_r, 0, lc};    // Jet outlet
Point(6) = {L_domain, h_domain, 0, lc}; // Top right

// Lines
Line(1) = {1, 4}; // Symmetry axis
Line(2) = {2, 5}; // Jet flow
Line(3) = {3, 6}; // Top boundary
Line(4) = {1, 2}; // Jet inlet
Line(5) = {2, 3}; // Left wall
Line(6) = {4, 5}; // Jet outlet
Line(7) = {5, 6}; // Ambient outlet

// Surfaces
Curve Loop(1) = {1, 6, -2, -4};
Plane Surface(1) = {1};          // Lower Block (Jet)
Curve Loop(2) = {2, 7, -3, -5};
Plane Surface(2) = {2};          // Upper Block (Coflow/Ambient)

// Meshing
// Longitudinal resolution (along the jet flow)
Transfinite Curve {1, 2, 3} = 1000 Using Progression 1; 

// Vertical resolution for the Jet core
Transfinite Curve {4, 6} = 20 Using Progression 1;

// Vertical resolution outside jet
Transfinite Curve {5, 7} = 40 Using Progression 1.02;

Transfinite Surface {1};
Transfinite Surface {2};
Recombine Surface {1, 2}; // Converts triangles to quadrilaterals

// Physical groups
Physical Curve("symmetry", 11) = {1};
Physical Curve("jet_inlet", 9) = {4};
Physical Curve("coflow_inlet", 13) = {5};
Physical Curve("outlet", 10) = {6, 7};
Physical Curve("top_wall", 14) = {3};
Physical Surface("fluid", 1) = {1, 2};

Mesh 2;