# Assignment 5: Addition of Speed of Sound Output

## Implementation
Speed of sound is already calculated in the compressible solvers as the primitive variable SoundSpeed. Therefore, all that is required is to add extra lines to write the variable to the volume, history and screen outputs - no calculations are necessary. All changes were applied to the file that manages output for compressible solvers, CFlowCompOutput.cpp. 

<br />

### Volume Output
Volume output changes were implemented by adding the lines:

    AddVolumeOutput("SOUNDSPEED", "SoundSpeed",               "PRIMITIVE", "Speed of Sound");
within SetVolumeOutputFields() [line 246], and

    SetVolumeOutputValue("SOUNDSPEED", iPoint, Node_Flow->GetSoundSpeed(iPoint));
within LoadVolumeData() [line 347], to declare and set the value of the speed of sound within the volume output, respectively.

<br />

### Screen Output
Screen outputs are altered through commands relating to History. The lines:

    AddHistoryOutput("AVG_SPEED_OF_SOUND", "Avg_SoundSpeed", ScreenOutputFormat::SCIENTIFIC, "PRIMITIVE", "Average speed of sound.");
within SetHistoryOutputFields() [line 167], and 

    SetHistoryOutputValue("AVG_SPEED_OF_SOUND", flow_solver->GetNodes()->GetSoundSpeed(0));
within LoadHistoryData() [line 450] were added to declare and set the value of speed of sound in the screen output, respectively.

<br />

### Implementing Changes

To test and implement these changes, a new build (maintaining MPI and PyWrapper compatibility) was created and installed using the commands:

    ./meson.py setup GSoC_SoundSpeed_build -Denable-pywrapper=true -Dwith-mpi=enabled
    ./ninja -C GSoC_SoundSpeed_build install

<br />

## Results
### Volume Ouput
As the test case in Assignment 2 was run using an incompressilbe solve to match the experimental data provided, the compressible test case from Assignment 3 was rerun. The SoundSpeed output in Paraview can be seen below:

![Results not found](SoundSpeedVol.png)

This matches the expected distribution from the temperature field of the flow, with values close to the speed of sound at sea level standard conditions (340 m/s), confirming correct implementation. 

<br />

### Screen Output
The .cfg file can be altered to show the average speed of sound of the domain by adding AVG_SPEED_OF_SOUND to the following option:

    SCREEN_OUTPUT= (TIME_ITER, INNER_ITER, RMS_DENSITY, RMS_TKE, RMS_DISSIPATION, AVG_SPEED_OF_SOUND)

The first few lines of the output are shown below:

    +-----------------------------------------------------------------------------+
    |   Time_Iter|  Inner_Iter|    rms[Rho]|      rms[k]|      rms[w]|Avg_SoundSpe|
    +-----------------------------------------------------------------------------+
    |           0|           0|   -1.392632|    1.813121|    5.639181|  3.4411e+02|
    |           0|           1|   -1.949346|    1.214128|    5.041010|  3.4451e+02|

This value matches with the approximate expected value from the distribution seen in the volume output above, confirming correct implementation. 
