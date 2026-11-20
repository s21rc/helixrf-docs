# Build guide

Assembly, wiring and first power-up for the kit version. The assembled and
tested version starts at [Wiring](#wiring).

--8<-- "safety-rf.md"

## In the box

- [Controller board]
- [Display module + cable]
- [Connectors / harness]
- [Quick-start card]

## Tools and parts you need

- [Soldering iron, solder, flux]
- [Multimeter]
- [Supply: voltage and current]

## Assembly

=== "Rev 4.01"

    [Assembly steps for Rev 4.01.]

=== "Rev 4.02"

    [Assembly steps for Rev 4.02.]

## Wiring

=== "Rev 4.01"

    Connect the PA sensor cable to J3.

=== "Rev 4.02"

    Connect the PA sensor cable to J5.

| Connector | Signal | Notes |
| --- | --- | --- |
| [J1] | [Supply in] | [voltage range] |
| [J3 / J5] | PA sensor | See the revision tabs above |
| [Jx] | Band data | Band voltage, BCD, CAT, CI-V or RF sense |
| [Jx] | Rotator | Left / right relay outputs, position pot |

## First power-up

1. [Check supply polarity and voltage before connecting the board.]
2. [Power up without the amplifier connected; the display should start.]
3. [Continue with Setup and calibration.]

[Setup and calibration →](../setup/index.md){ .md-button .md-button--primary }
