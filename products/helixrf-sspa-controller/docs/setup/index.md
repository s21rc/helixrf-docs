# Setup and calibration

## Radio profile and band data

The controller reads band voltage, BCD, CAT, CI-V or RF sense. Choose a
built-in radio profile, or create a custom profile with up to 12 bands.

1. [Open Settings → Radio on the display.]
2. [Pick your radio or create a custom profile.]
3. [Check that the band follows your radio.]

## Protection

Hardware comparators trip on high SWR, filter reflection, over-temperature and
over-current, and a latch holds the fault. The default SWR trip is 3:1.

!!! warning "Test protection before operating"
    [Describe how to verify each trip with a dummy load before going on the air.]

## Power calibration

[Forward and reflected power calibration steps.]

## Rotator calibration

Left and right relay outputs, a position-pot input and 3-point calibration,
up to 450° azimuth.

1. [Turn to the first end stop and save.]
2. [Turn to the middle point and save.]
3. [Turn to the second end stop and save.]

## Remote monitoring

A WebSocket server feeds the web UI and the Windows and Android apps. Remote
access is monitor plus rotator only, and PTT stays local.

[Connect to WiFi and open the web UI.]
