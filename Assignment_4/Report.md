# Assignment 4: Spatially Varying Wall Temperature for a Steady-State Compressible Turbulent Flat Plate Testcase
## Setup
The same test case in Assignment 3 was used but with steady-state instead of time-variant.

To enable the spatially varying wall temperature, the following area of the Python wrapper was identified:
'''
# Set this temperature to all the vertices on the specified CHT marker
    for iVertex in range(nVertex_CHTMarker):
      SU2Driver.SetMarkerCustomTemperature(CHTMarkerID, iVertex, WallTemp)
'''

This was modified to be:
'''
# Set this temperature to all the vertices on the specified CHT marker
    for iVertex in range(nVertex_CHTMarker):

      # Assignment 4: Spatially-Varying Wall Temperature
      coord = SU2Driver.GetNumberMarkerNodes(CHTMarkerID, iVertex)
      x = coord[0]
      SpatialWallTemp = WallTemp + (coord[0] * 10)

      SU2Driver.SetMarkerCustomTemperature(CHTMarkerID, iVertex, SpatialWallTemp)
'''
with the previous time-varying function set to a constant, reflecting the time-invariant nature of this simulation.


## Results
The simulated plate temperature is displayed below:

The match with the implemented analytical expressions again confirms the correct implementation of this feature.