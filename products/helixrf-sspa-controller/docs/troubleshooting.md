# Troubleshooting

Common problems, what causes them and how to fix them. Two tools help with
almost all of them:

- **Diagnose** (menu → Diagnose) shows the live reading of every analog
  input. See [Diagnostics](setup/index.md#diagnostics).
- **The test points** show whether each supply rail is there. See
  [Test points](build/index.md#test-points).

--8<-- "safety-rf.md"

## Power and display

| Problem | Check |
| --- | --- |
| Nothing lights, the power LED is off | Measure the supply at J22 and at **TP5**. If TP5 reads 0 V, the supply may be reversed: the input fuse trips. Correct the polarity and wait a minute for the fuse to cool. |
| Power LED on, display stays dark | Measure **TP1** (5 V). Check the display cable at [J18](build/connectors.md#j18-j19-display): pin 4 is +5 V, pin 1 GND. |
| A supply rail is missing or low | Unplug the connectors one at a time, starting with the display, fan and relay boards. A rail that comes back points to a short or an overload on that connector. |
| The picture is upside down | Menu → **Display** → untick **Rotate display**, APPLY, and restart. |

## Display and controller not talking

The display and the controller talk over a 3.3 V serial link on
[J18](build/connectors.md#j18-j19-display). The signs of a broken link:

- **Info** shows **Controller Firmware** as 0.
- Temperatures, voltage and current stay at 0; PA ENABLE and the band
  buttons do nothing.
- APPLY never shows **Configuration Saved**.

!!! warning "TX goes to RX"
    The controller's **TX (J18 pin 3)** must go to the display's **RX**, and
    the controller's **RX (J18 pin 2)** to the display's **TX**. Some display
    manufacturers label their connector the other way round (from the other
    end of the cable), so a cable wired "TX to TX" by the labels can be
    right, and one wired "TX to RX" can be wrong. Check the pin-out in your
    display's own manual.

    If the link does not work, switch everything off and swap the wires on
    pins 2 and 3. Both lines are 3.3 V logic, so the display must use 3.3 V
    on its serial port, not 5 V.

Also check:

- GND (pin 1) is connected at both ends.
- The cable is short and kept away from the PA output coax.
- Both boards run firmware of the same release (menu → **Info**).

## Keying and the RX/TX relay

| Problem | Check |
| --- | --- |
| **TRANSMIT** does not light when you key the radio | PA ENABLE must be on (bright green); in standby the amplifier never keys. Check the PTT wiring at [J26](build/connectors.md#j26-j27-ptt-and-rxtx-relay): the radio's SEND / TX-GND output must pull pin 2 to GND when transmitting. |
| PA ENABLE does not change | Press and **hold** it. It does not change while transmitting or while the protection is latched (PA RESET red). |
| The amplifier does not key after a fault, a reset or power-up | Unkey the radio once. The amplifier never keys into a PTT that was already held; it needs a fresh key-down. |
| TRANSMIT lights, but no relay click | Measure J26 pin 4: +12 V while transmitting. Check the relay coil and its GND return. |
| The relay chatters on SSB | Check the PTT cable for RF pickup: use shielded cable, and fit a ferrite on it at the amplifier end. |

## Protection

| Problem | Check |
| --- | --- |
| **PA RESET** does nothing | A fault is still present: its indicator is **red**. Fix the cause first. PA RESET is also refused while transmitting. |
| **ANT SWR** trips at key-up, even into a dummy load | The forward and reflected wires from the antenna bridge may be swapped. In **Diagnose**, transmit at low power into the dummy load: **ANT REF** must be far lower than **ANT FWD**. Also check the coax and the load itself. |
| **LPF SWR** trips on one band only | The [LPF map](setup/index.md#lpf-map) sends that band to the wrong filter, the filter relay does not switch, or the filter is faulty. If all filters are good, RV1 is set too sensitive. |
| **CURRENT** or **VOLTAGE** trips at normal power | Check the trip value on the Protection page against your operating level, and the current sensor settings (a wrong sensor type makes the reading, and the trip value shown, wrong). |
| **TEMP.** trips too early | Check the NTC values on the Temperature page, and that NTC 1 sits on the heatsink, not on a hot spot such as a resistor. |
| **RF IN** trips | The external drive-protection input ([J14 pin 4](build/connectors.md#expansion-and-service-connectors)) is high. Reduce the drive, or check the module that drives this input. If nothing is connected there, check for a short to a supply. |

## Readings

| Problem | Check |
| --- | --- |
| Power reads 0 while transmitting | The power meter is not calibrated: see [RF power calibration](setup/index.md#rf-power-calibration). |
| SWR shows `--` | Normal while receiving. SWR is measured only while transmitting. |
| SWR jumps about at low power | The reflected signal is near the detector's noise floor. Read SWR at a higher power. |
| Power reads wrong after calibration | Calibrate again with a steady carrier and the wattmeter in the line. LOW, MID and HIGH must increase in order. |
| Current reads negative | Tick **INVERT MODE** on the Power page (shunt and Hall sensors). |
| Current or voltage reads 0 | Check the wiring at [J8](build/connectors.md#j8-j9-psu-monitor) and the sensor type on the Power page. |
| Voltage or current a little off | Correct it with **VOLTAGE CALIBRATION** / **CURRENT CALIBRATION** on the Power page. |
| A temperature reads far below room temperature | That NTC is open or not connected. |
| A temperature reads very high | That NTC or its wiring is shorted. |
| Both temperatures read wrong by a few degrees | Enter the correct resistance and beta for your NTCs on the Temperature page. |

!!! danger "Check NTC 1 before operating"
    The hardware over-temperature trip uses NTC 1. If NTC 1 is open or
    unplugged, it reads very cold and the trip can never fire. Always check
    that TEMP1 reads a sensible temperature before going on the air.

## Fan

| Problem | Check |
| --- | --- |
| Fan always at full speed | 4-wire fan: check the PWM wire on J20 pin 2 (most PC fans run flat out when the PWM wire is open). If the speed falls as the amplifier warms up, tick **Invert PWM**. |
| Fan never speeds up | Check the FAN PWM range on the Temperature page, and that the NTCs read correctly. |
| Fan does not run at all | Measure **TP4** (fan 12 V). 2-wire fans connect between pins 4 and 3, 4-wire fans between pins 4 and 1. |

The fan never stops completely: 10 % is the minimum.

## Band selection

| Problem | Check |
| --- | --- |
| The amplifier does not follow the radio's band | **AUTO BAND** must be on (lit). The method on the Band Data page must not be None, and the profile must have a value for that band (a band left at 0 is ignored). |
| It selects the wrong band | Band voltage: the windows overlap or are too wide; check **LIVE BAND VOLTAGE** on each band. BCD: compare **LIVE BAND DATA** with the ticks for that band. |
| Band data reads 0 on every band | Check the band-data cable at [J1](build/connectors.md#j1-j2-band-data-and-rf-sense), and that band data is switched on in the radio's menu. |
| A band button does nothing | No band changes while transmitting. In AUTO the radio chooses the band: hold AUTO BAND to switch to manual. |
| The band changes only after unkeying | Normal. A band change from the radio during TX is applied when you unkey. |
| APPLY on a band page does nothing just after power-up | The display is still receiving the radio profiles from the controller. Wait a few seconds and tap APPLY again. |

### CAT and CI-V

| Problem | Check |
| --- | --- |
| **CAT** chip stays off | Baud rate (and CI-V address for Icom) must match the radio exactly; do not use Auto baud on the radio. |
| Icom: band follows only when you change it on the amplifier | Turn **CI-V Transceive** on in the radio. |
| No data at all | Logic level: solder jumper **JP2** must match the radio or interface (5 V or 3.3 V). An RS-232 port (±12 V) needs a level converter. For CI-V use J16 pin 3, not pin 2. |
| Frequency widget shows `--.---.---` | No CAT or CI-V data. Check the CAT chip first. |

## Antennas and rotator

| Problem | Check |
| --- | --- |
| The RX antenna relay never switches | It works only with PA ENABLE on, while receiving, on a band with **RX ANT** ticked on the Antenna page. |
| The wrong antenna is selected | Check the Antenna page, and the relay order at [J45](build/connectors.md#j45-j46-antenna-selector): the TX antennas use a cumulative code, not one wire per antenna. |
| **>>** turns the rotator the wrong way | Swap the two relay wires at [J32](build/connectors.md#j32-j33-rotator). |
| The rotator does not move | Tick **Enable rotator control** on the Rotator page. Check the relay supply in the rotator control box. |
| The heading is wrong | Redo the 3-point calibration, and check **CCW stop heading**. **Rotator ADC** must change smoothly over the whole turn. |
| The rotator stops before the target | The position reading stopped changing (a stall or a loose pot wire), or the run took too long. Check the pot wiring and the mechanics. |

## Network and browser app

| Problem | Check |
| --- | --- |
| `helixrf-sspa4.local` does not open | Use the IP address shown on the Network page instead. Some phones (Android in particular) do not find `.local` names. The PC or phone must be on the same network. |
| The page opens but shows no data | **Enable browser app** must be ticked (menu → Remote). Check that AIRPLANE MODE is off. |
| The dot shows not live | The browser lost the connection: check the WiFi signal on the Info page, and reload the page. |
| The remote head does not connect | Tick **Enable remote display head**, then tap **PAIR** and confirm the code shown on the head. |
| A rotator program cannot connect | The rotator must be enabled. Use port **4001**. Only one program can connect at a time. |

## CAN power supply

| Problem | Check |
| --- | --- |
| **CAN** chip stays off | Choose the supply under **CONNECTED MODULE**. Check CAN-H and CAN-L (not swapped), GND, and the 120 Ω termination at the supply end. |
| CAN chip on, but no readings | The supply is on the bus but not answering. Choose None, then choose the supply again: that restarts discovery. |
| Flatpack2 telemetry disappears for about 20 s after APPLY | Normal: the supply is storing the new default voltage. |

## Firmware update

| Problem | Check |
| --- | --- |
| The update page refuses to start | Stop transmitting. |
| The controller file is rejected | Use `controller4-vNNN.bin`, not the `_full.bin` (that one is for USB recovery only). |
| The controller update stopped part way | Open the Firmware Update page again and click **Retry flashing**. The controller waits in its bootloader until it gets a good image. |
| The controller does not start at all | Recover it over USB: see [Recovering the controller](firmware/index.md#recovering-the-controller-usb). |
| The new display firmware misbehaves | Use the **Restore display4-vNNN** button on the Firmware Update page. |

## Still stuck?

Note what you see (the indicators, the Info page versions and a photo of the
Diagnose page help a lot) and
[request free remote support](https://helixrf.com/remote-support/). We
connect to your station PC and help you get on the air.
