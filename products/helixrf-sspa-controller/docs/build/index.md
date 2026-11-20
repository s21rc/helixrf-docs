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

Wire the modules to the controller as shown in
[Connectors and wiring](connectors.md). It has the system diagrams, and a
pin-out and wiring sketch for every connector.

Suggested order:

1. 12 V supply ([J22](connectors.md#j22-j23-12-v-power-in)) and the display ([J18](connectors.md#j18-j19-display)).
2. High Side Switch: sense ([J8](connectors.md#j8-j9-psu-monitor)) and control ([J10](connectors.md#j10-j11-psu-protection)).
3. LPF module: power ([J39](connectors.md#j39-j40-lpf-module-power)) and band select ([J43 or J41](connectors.md#j41-j42-and-j43-j44-lpf-band-select)).
4. SWR bridges ([J3, J5](connectors.md#j3-j4-and-j5-j6-swr-bridges)), NTCs ([J28](connectors.md#j28-j29-ntc-temperature-sensors)) and fan ([J20](connectors.md#j20-j21-fan)).
5. PTT and RX/TX relay ([J26](connectors.md#j26-j27-ptt-and-rxtx-relay)), PA bias ([J30](connectors.md#j30-j31-pa-bias)).
6. Radio band data ([J1](connectors.md#j1-j2-band-data-and-rf-sense) or [J16](connectors.md#j16-j17-cat-ci-v)), ALC ([J24](connectors.md#j24-j25-alc-and-tx-inhibit)), and the optional antenna selector and rotator.

[Connectors and wiring →](connectors.md){ .md-button }

## First power-up

1. [Check supply polarity and voltage before connecting the board.]
2. [Power up without the amplifier connected; the display should start.]
3. [Continue with Setup and calibration.]

[Setup and calibration →](../setup/index.md){ .md-button .md-button--primary }
