---
hide:
  - navigation
---

<p class="hrf-eyebrow">Manual · Helix SSPA Controller</p>

# Helix SSPA Controller

Control and protection for solid-state HF amplifiers. The controller pairs an
STM32G474 control board with an ESP32-P4 touch display, switches bands
automatically from your radio, and trips in hardware on SWR, filter reflection,
temperature and current.

Pick your hardware revision in the tabs on each page. This manual matches
firmware **[x.y]**; use the version menu at the top to read an older one.

--8<-- "safety-rf.md"

## System overview

The controller sits at the centre of the amplifier: it switches the RF path,
biases the pallet, watches SWR, temperature, voltage and current, and talks to
the radio, the display and the optional modules. Numbered blocks are
explained in the notes on the diagram.

<figure markdown>
  [![HelixRF SSPA Controller V4 system block diagram](assets/wiring/system-block-diagram.png){ loading=lazy }](assets/wiring/system-block-diagram.png)
  <figcaption>System block diagram. Click to enlarge, or
  [download the PDF](assets/wiring/helixrf-sspa-v4-block-diagram.pdf) for printing.</figcaption>
</figure>


<div class="grid cards" markdown>

-   :material-hammer-wrench: **[Build guide](build/index.md)**

    Assembly, wiring and first power-up.

-   :material-tune-variant: **[Setup and calibration](setup/index.md)**

    Radio profiles, band data, power and rotator calibration.

-   :material-chip: **[Firmware and release notes](firmware/index.md)**

    Downloads and changes for each version.

-   :material-headset: **[Free remote support](https://helixrf.com/remote-support/)**

    Stuck on setup or calibration? We connect to your station PC and help you get on the air.

</div>

[Buy the controller](https://helixrf.com/product/helixrf-sspa-controller/){ .md-button .md-button--primary }
[Request remote support](https://helixrf.com/remote-support/){ .md-button }
