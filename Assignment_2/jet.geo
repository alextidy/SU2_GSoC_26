// Parameters 
D_jet = 0.001;
jet_r = D_jet / 2;
h_domain = 40*D_jet;
L_free = 100*D_jet;
lc = 1.0;               // Characteristic length

// Points
Point(1) = {0, 0, 0, lc};          // Jet inlet bottom (origin)
Point(2) = {0, jet_r, 0, lc};      // Jet inlet top / Coflow bottom
Point(3) = {0, h_domain, 0, lc};   // Coflow inlet top
Point(4) = {L_free, 0, 0, lc};     // Outlet bottom
Point(5) = {L_free, jet_r, 0, lc};  // Outlet jet/coflow interface
Point(6) = {L_free, h_domain, 0, lc}; // Outlet top

// Lines
Line(1) = {1, 4};  // Symmetry axis
Line(2) = {1, 2};  // Jet inlet
Line(3) = {2, 3};  // Coflow inlet
Line(4) = {2, 5};  // Jet/Coflow interface line
Line(5) = {4, 5};  // Outlet (Jet part)
Line(6) = {5, 6};  // Outlet (Coflow part)
Line(7) = {3, 6};  // Top boundary

// Surfaces
// Lower block (The Jet core)
Curve Loop(1) = {1, 5, -4, -2};
Plane Surface(1) = {1};

// Upper block (The Coflow / Expansion)
Curve Loop(2) = {4, 6, -7, -3};
Plane Surface(2) = {2};

// Meshing - Structured Quads
// Axial distribution (Horizontal)
Transfinite Curve {1, 4, 7} = 100 Using Progression 1.0;

// Radial distribution (Vertical)
Transfinite Curve {2, 5} = 16 Using Progression 1.0;        // Jet height
Transfinite Curve {3, 6} = 85 Using Progression 1.055;     // Coflow height

Transfinite Surface {1};
Transfinite Surface {2};
Recombine Surface {1, 2};

// Physical groups (Matching your requested IDs)
Physical Curve("symmetry", 11) = {1};
Physical Curve("jet_inlet", 9) = {2};
Physical Curve("pipe_wall", 12) = {}; // Empty since pipe is removed
Physical Curve("coflow_inlet", 13) = {3};
Physical Curve("outlet", 10) = {5, 6};
Physical Curve("top_wall", 14) = {7};
Physical Surface("fluid", 1) = {1, 2};

Mesh 2;