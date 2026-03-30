// Parameters 
D_jet = 0.001;
jet_r = D_jet / 2;
h_domain = 40*D_jet;
L_pipe= 10*D_jet;
L_free = 100*D_jet;
L_total = L_pipe + L_free;
lc = 1.0;               // Characteristic length


// Points
Point(1) = {0, 0, 0, lc};            // Pipe inlet bottom
Point(2) = {0, jet_r, 0, lc};        // Pipe inlet top
Point(3) = {0, h_domain, 0, lc};     // Coflow inlet top
Point(8) = {L_pipe, 0, 0, lc};       // Nozzle exit bottom
Point(7) = {L_pipe, jet_r, 0, lc};   // Nozzle exit top (Lip)
Point(9) = {L_pipe, h_domain, 0, lc};// Top above nozzle
Point(4) = {L_total, 0, 0, lc};      // Outlet bottom
Point(5) = {L_total, jet_r, 0, lc};  // Outlet jet center
Point(6) = {L_total, h_domain, 0, lc};// Outlet top


// Lines
Line(1) = {1, 8};  // Pipe symmetry
Line(2) = {8, 4};  // Free jet symmetry
Line(3) = {1, 2};  // Jet inlet
Line(4) = {2, 7};  // PIPE WALL (No-slip)
Line(5) = {7, 5};  // Jet centerline plume
Line(6) = {8, 7};  // Nozzle exit plane (Internal)
Line(7) = {4, 5};  // Jet outlet
Line(8) = {2, 3};  // Coflow inlet
Line(9) = {3, 9};  // Top boundary (front)
Line(10) = {9, 6}; // Top boundary (back)
Line(11) = {7, 9}; // Above nozzle plane (Internal)
Line(12) = {5, 6}; // Farfield outlet


// Surfaces
Curve Loop(1) = {1, 6, -4, -3};    Plane Surface(1) = {1}; // Pipeflow
Curve Loop(2) = {2, 7, -5, -6};    Plane Surface(2) = {2}; // Jet
Curve Loop(3) = {4, 11, -9, -8};   Plane Surface(3) = {3}; // Above pipe
Curve Loop(4) = {5, 12, -10, -11}; Plane Surface(4) = {4}; // Jet expansion


// Meshing
// Axial
Transfinite Curve {1, 4, 9} = 40 Using Progression 0.9;         // Pre-nozzle
Transfinite Curve {2, 5, 10} = 200 Using Progression 1.001;      // After nozzle

// Radial
Transfinite Curve {3, 6, 7} = 16 Using Progression 0.9;        // Jet
Transfinite Curve {8, 11, 12} = 90 Using Progression 1.055;      // Jet expansion

// Converting to quads
Transfinite Surface {1}; Transfinite Surface {2};
Transfinite Surface {3}; Transfinite Surface {4};
Recombine Surface {1, 2, 3, 4};


// Physical groups
Physical Curve("symmetry", 11) = {1, 2};
Physical Curve("jet_inlet", 9) = {3};
Physical Curve("pipe_wall", 12) = {4};
Physical Curve("coflow_inlet", 13) = {8, 9};
Physical Curve("outlet", 10) = {7, 12};
Physical Curve("top_wall", 14) = {10};
Physical Surface("fluid", 1) = {1, 2, 3, 4};


// Meshing (for gmsh viewing)
Mesh 2;