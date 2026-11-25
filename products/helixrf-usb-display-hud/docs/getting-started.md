# Getting started

## 1. Download

Download the firmware from the link in the product description, or from
**My account → Downloads** on [helixrf.com](https://helixrf.com/my-account/downloads/).

The firmware file is named `helixrf_hud.bin`. [TODO: file size, and whether the
download is the bare `.bin` or a package with an installer.]

## 2. Install

[TODO: how the customer puts the firmware on a new display for the first time
(for example a web flasher, a USB flashing tool, or a display shipped with the
firmware installed).]

Once the HUD is running and on your WiFi, later versions are installed from the
web interface. See [Update the firmware](#5-update-the-firmware).

## 3. Connect to WiFi

The web interface, firmware updates and the network radio server need WiFi.
The display and radio control work without it.

<figure markdown>
  ![Settings WiFi tab with network name, password, Scan button and a QR code for the web interface](assets/images/settings-wifi.webp){ loading=lazy }
  <figcaption>Settings → WiFi. The QR code opens the web interface on your phone.</figcaption>
</figure>

1. On the main screen, tap **SETTINGS** (bottom right).
2. Open the **WiFi** tab.
3. Tap **Scan**, then pick your network from the list. Or type the name in
   **Network (SSID)**.
4. Type the **Password**.
5. Tap **Save & Connect**.

When the HUD is connected, the tab shows **Connected to** your network and the
signal strength in dBm. The WiFi icon at the top of the main screen turns green.

To open the web interface, scan the QR code with your phone, or type
**http://helixrf-hud.local/** in a browser on the same network. If that name
does not work on your computer, use the IP address shown under the QR code.

## 4. Activate your licence

The HUD has a **Device ID**, made from the hardware. A licence is an
**activation code** (108 characters) made for that Device ID.

Your unique licence key is emailed within 72 hours of successful payment.
Payment and invoicing are handled by our Merchant of Record, Paddle.com Market Ltd.

<figure markdown>
  ![Settings Licence tab with the Device ID, trial status, activation code field and Activate button](assets/images/settings-licence.webp){ loading=lazy }
  <figcaption>Settings → Licence. The Device ID is blurred in this picture.</figcaption>
</figure>

1. Tap **SETTINGS**, then the **Licence** tab.
2. Note the **Device ID** (for example `K7Q2-M9XD`) and send it to HelixRF.
   [TODO: how the customer sends the Device ID: at checkout, by email, or
   another way.]
3. When the activation code arrives, type it in the **activation code** field.
   Dashes, spaces and upper or lower case do not matter.
4. Tap **Activate**. The status changes to show the licence is active.

You can also activate in the web interface: open the **Licence** page, paste the
code in **Activation code** and click **Activate**. Pasting is easier than typing
108 characters on the screen.

<figure markdown>
  ![Web interface Licence page with Device ID, status and activation code field](assets/images/web-licence.webp){ loading=lazy }
  <figcaption>Licence page in the web interface.</figcaption>
</figure>

If the code is not accepted, the HUD shows one of these messages:

| Message | What to do |
|---|---|
| Enter the activation code first. | The field is empty. Type or paste the code. |
| That is not an activation code. It should be 108 letters and digits. | Part of the code is missing or extra characters were added. Copy it again from the email. |
| The code contains a typing error. Please check it character by character. | One character is wrong. Compare the code with the email. |
| This code does not match this device's ID. | The code was made for another Device ID. Check the Device ID you sent. |
| The code is valid but could not be saved. Please try again. | Tap **Activate** again. If it keeps failing, contact support. |

!!! tip "No key after 72 hours?"
    Check your spam folder first, then
    [contact us](https://helixrf.com/contact/) with your order number.

### 14-day trial

You can try all features for 14 days before you buy, with no registration.
On the **Licence** tab (on the screen or in the web interface), tap
**Start 14-day trial**. The status then shows the days left.

The trial can be started once. Without a licence or a running trial, decoding
and the web live display each run for 2 minutes after every power-on; the
network radio server is off.

## 5. Update the firmware

<figure markdown>
  ![Web interface Firmware page with file chooser and Upload and install button](assets/images/web-firmware.webp){ loading=lazy }
  <figcaption>Firmware page in the web interface.</figcaption>
</figure>

1. Download the new `helixrf_hud.bin` (see [Download](#1-download)).
2. Open the web interface and click **Firmware**. **Running** shows the version
   now installed.
3. Click **Choose File** and pick `helixrf_hud.bin`.
4. Click **Upload & install**. The bar shows the progress, and the HUD restarts
   when the upload is done.

The new firmware must run for 90 seconds without problems before the HUD keeps
it. If it fails, the HUD goes back to the previous version by itself.

!!! warning
    Keep the HUD powered during the upload.

## 6. Connect your radio

Continue with [Setup](setup/index.md).
