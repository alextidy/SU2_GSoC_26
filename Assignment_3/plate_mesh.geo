// Parameters 
L_plate = 1.0;
L_leadup = 0.2;
L_domain = L_plate + L_leadup;
h_domain = 0.4;
lc = 1.0;


// Points
Point(1) = {0, 0, 0, lc};            // Bottom Left
Point(2) = {L_leadup, 0, 0, lc};        // Plate LE
Point(3) = {L_domain, 0, 0, lc};     // Plate TE AND bottom right
Point(4) = {0, h_domain, 0, lc};       // Top left
Point(5) = {L_leadup, h_domain, 0, lc}; // Plate LE at top wall
Point(6) = {L_domain, h_domain, 0, lc};   // Top right


// Lines
Line(1) = {1, 2};  // Leadup to Plate
Line(2) = {2, 3};  // Plate
Line(3) = {1, 4}; // Inlet
Line(4) = {4, 5}; // Top wall: corner to LE
Line(5) = {5, 6}; // Top wall: LE to TE
Line(6) = {2, 5}; // Plate LE to top wall
Line(7) = {3, 6}; // Outlet


// Surfaces
Curve Loop(1) = {1, 6, -4, -3}; // Left block
Curve Loop(2) = {2, 7, -5, -6}; // Right block


// Meshing
// x leadup
Transfinite Curve {1, 4} = 40 Using Progression 0.92;

// x plate
Transfinite Curve {2, 5} = 80 Using Progression 1.05;

// y
Transfinite Curve {3, 6, 7} = 40 Using Progression 1.15;

// Converting to quads
Plane Surface(1) = {1};
Plane Surface(2) = {2};
Transfinite Surface {1};
Transfinite Surface {2};
Recombine Surface {1, 2};


// Physical Groups
Physical Curve("inlet") = {3};
Physical Curve("outlet") = {7};
Physical Curve("farfield") = {4, 5};
Physical Curve("symmetry") = {1};
Physical Curve("wall") = {2};
Physical Surface("fluid") = {1, 2};


// Meshing (for gmsh viewing)
Mesh 2;