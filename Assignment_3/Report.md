# Assignment 3: Python Wrapper
## Setup
.py and .cfg files were sourced from the provided link. The mesh from the Compressible Turbulent Flat Plate test case was used, as this tutorial mirrors the flow characteristics suggested by the config file. 

The config file was missing BC definition. The used ones were:
- 


## Results
To validate the sovler and mesh, the variation of u+ with y+ was compared against the provided test case results:


A close agreement confirms the result is accurate for a static plate temperature.

The plot displays the variation of bulk plate temperature with time, compared to the prescribed analytical expression:

The match confirms the successful implementation of the Python wrapper.



