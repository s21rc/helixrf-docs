# Technical reference

How the controller is built, with the parts used, for builders and anyone
who wants to know what is inside. Figures are for controller board
**Rev 4.01** and firmware **105**.

## Controller board

| | |
| --- | --- |
| Processor | ST **STM32G474VET6**, Arm Cortex-M4F at 170 MHz, 512 KB flash, 16 MHz crystal. Chosen for its analog peripherals: five fast 12-bit ADCs, with forward and reflected power sampled at the same instant by two ADCs in dual simultaneous mode. |
| PCB | 4-layer, 1.6 mm |
| Supply | 12–14 V DC, 5 A resettable fuse, reverse-polarity protection |
| Settings storage | **CAT24C256** 32 KB I²C EEPROM on the controller board. Every amplifier setting is kept here, so it survives firmware updates and never wears out the STM32's internal flash. Settings that change often, such as PA ENABLE, are written only after 5 minutes without a change, to spare the EEPROM as well. |
| Display link | 3.3 V UART, 115200 baud; firmware updates for the controller pass over the same link |
| Bootloader | 16 KB, CRC-checked firmware images; USB DFU recovery through the processor's ROM bootloader |

### Protection path

The protection does not depend on the processor or the firmware.

- **Comparators:** three **TLV3502** dual high-speed comparators (4.5 ns
  propagation delay) watch antenna SWR, LPF SWR, output power, supply
  voltage, drain current and temperature.
- **Latch:** a **74HC74** flip-flop holds the first trip until PA RESET, so a
  fault that clears by itself still leaves the amplifier off and shows what
  happened. Comparator plus latch respond in tens of nanoseconds.
- **Fast bias cut-off:** the latch drives N-channel MOSFETs (**AO3400A**)
  directly, with 33 Ω gate resistors, to switch off the bias switch
  (**AO3401A** P-MOSFET) and pull the optional gate-kill line to GND.
- **PA supply:** two **IRLML0100** 100 V MOSFETs give the High Side Switch a
  fail-safe and an active-on control line.
- **ALC and TX inhibit:** on a fault, an **ADG419** analog switch pulls the
  radio's ALC to a negative voltage (from an **ICL7660** −12 V charge pump,
  clamped by Zener diodes to about −4 V and −10 V), so the radio's power
  goes down as well. TX inhibit is an open-drain **AO3400A**.
- **Firmware backup:** the processor sees every fault on an interrupt and
  drops the bias and the RX/TX relay within microseconds, independently of
  the latch. The first fault is timestamped, so the display shows the cause
  rather than the faults that the trip itself triggers.

### Inputs and outputs

- **Optocouplers:** five **LTV-217** optocouplers isolate the PTT input and
  the four BCD band-data inputs, for a large voltage margin and no ground
  loop to the radio.
- **LPF drivers:** two types of LPF board are supported. **A2982** 8-channel
  source drivers (outputs switch to +12 V) and a **ULN2803A** 8-channel sink
  driver (outputs switch to GND, clamp diodes on board); 500 mA per output.
- **Antenna selector:** a second **A2982** drives the antenna and spare
  outputs.
- **Frequency counter input:** **SN65LVDS2** LVDS receiver.
- **Data line protection:** **PRTR5V0U2X** ESD protection on the display,
  Neural module and USB lines.

### EMI and RF immunity

Every signal and power line that leaves the board passes through a ferrite
bead and an RC filter to ground, to keep RF from the amplifier out of the
control circuits.

### Power supply

A three-stage supply keeps the efficiency high and the heat low:

1. **LMR51430** synchronous buck converter, 12 V to 6.6 V.
2. **MIC29302** 3 A low-dropout regulator, 6.6 V to 5 V (display, CAT and
   band-data supplies).
3. **TLV73333** low-dropout regulator, 3.3 V for the processor and the analog
   circuits.

The fan and the relay drivers run from separate LC-filtered 12 V rails.

## Display

| | |
| --- | --- |
| Processor | Espressif **ESP32-P4**, dual-core RISC-V (rated to 400 MHz; firmware 105 runs it at 360 MHz), 32 MB flash |
| Screen | 1024 × 600 pixels, MIPI-DSI, capacitive touch (**GT911**) |
| WiFi | **ESP32-C6** co-processor |
| CAN | **TJA1051** transceiver, 125 kbit/s, 120 Ω termination on board |
| Settings storage | Display, network, remote and CAN settings in the display's own non-volatile memory (NVS) |
| Firmware | Two firmware slots: a failed or unwanted update can be rolled back |

## Timing

| Event | Time |
| --- | --- |
| Comparator response | 4.5 ns (TLV3502) |
| Key-up: RX/TX relay to bias on | 20 ms |
| Key-down: bias off to relay release | 5 ms |
| PTT release debounce | 2 ms |
| PA RESET pulse to external modules (nRST-RLY) | 300 ms |
| Meter update while transmitting | 4 per second (power bar 20 per second) |

## Components (controller board)

Counted from the Rev 4.01 schematic.

| Type | Count |
| --- | ---: |
| Integrated circuits | 20 |
| Transistors | 15 |
| Diodes | 29 |
| LEDs | 4 |
| Resistors | 204 |
| Trimmers | 5 |
| Capacitors | 197 |
| Ferrite beads | 76 |
| Inductors | 3 |
| Crystal | 1 |
| Fuse | 1 |
| Push buttons | 2 |
| Test points | 7 |
| Solder jumpers | 2 |
| Connector footprints | 47 |
