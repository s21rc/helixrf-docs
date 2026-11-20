# Getting started

The short path from a wired controller to a working amplifier. Each step links
to the full instructions.

--8<-- "safety-rf.md"

1. **Wire it up.** Follow [Connectors and wiring](build/connectors.md). Power
   up on 12 V only, with the 52 V supply off, and check that the display starts.
2. **Set the current sensor.** Choose the sensor type in the High Side
   Switch's power module settings (shunt, Hall or BTS) and enter its values.
3. **Set the LPF map.** Tell the controller which LPF bank each band uses.
4. **Set the temperature sensors.** Enter each NTC's resistance and beta, and
   the fan low and fan high temperatures.
5. **Set the protection trip levels.** On the protection page, adjust the
   trimmers for voltage, current and temperature.
6. **Choose the band data source** (band voltage, BCD, CAT, CI-V or RF sense)
   and your radio profile.
7. **Calibrate power and SWR**, then test every protection trip into a dummy
   load before going on the air.

See [Setup and calibration](setup/index.md) for each step in detail.

[TODO: add a short video once recorded.]
