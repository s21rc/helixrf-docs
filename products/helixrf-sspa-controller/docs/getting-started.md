# Getting started

The short path from a wired controller to a working amplifier. Do the steps
in this order: each one relies on the one before it. Each step links to the
full instructions.

--8<-- "safety-rf.md"

1. **Wire it up.** Follow [Connectors and wiring](build/connectors.md), then
   do the [first power-up](build/index.md#first-power-up) on 12 V only, with
   the PA supply off. Check that the display starts.
2. **Set the current sensor.** Menu → **Power**: choose the sensor type of
   your High Side Switch or power module and enter its values. See
   [Power module](setup/index.md#power-module-current-sensor).
3. **Set the LPF map.** Menu → **LPF Map**: tell the controller which LPF
   bank each band uses. See [LPF map](setup/index.md#lpf-map).
4. **Set the temperature sensors.** Menu → **Temperature**: enter each NTC's
   resistance and beta, and the fan start and full-speed temperatures. See
   [Temperature and fan](setup/index.md#temperature-and-fan).
5. **Set the protection trip levels.** Menu → **Protection**: turn the
   trimmers for voltage (RV3), current (RV4) and temperature (RV5) until each
   trip value reads what you want. See [Protection](setup/index.md#protection).
6. **Calibrate the power meter.** Menu → **RF Calibrate**, with a dummy load
   and a reference wattmeter. See [RF power calibration](setup/index.md#rf-power-calibration).
   Then set the output power trip (RV2) and the LPF SWR trip (RV1).
7. **Choose the band data source** (band voltage, BCD, CAT or CI-V) and your
   radio profile. See [Band data and radio](setup/band-data.md).
8. **Map the antennas** if you use the antenna selector. See
   [Antenna selection](setup/band-data.md#antenna-selection).
9. **Test every protection trip** into a dummy load before going on the air.
   See [Test the protection](setup/index.md#test-the-protection).

Optional: connect the display to your WiFi to use the browser app, the
remote head and firmware updates. See [Network and remote](setup/network.md).

!!! tip "Every settings page has an APPLY button"
    Changes on a settings page take effect when you tap **APPLY**. The page
    then shows **Configuration Saved** once they are stored. Amplifier
    settings are kept in the controller board's EEPROM; display, network and
    CAN settings are kept in the display. Both survive power cycles and
    firmware updates.
