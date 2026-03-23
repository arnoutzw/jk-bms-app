#set document(title: "JK BMS Monitor — User Manual", author: "Black Sphere Industries")
#set page(paper: "a4", margin: (top: 2.5cm, bottom: 2.5cm, left: 2cm, right: 2cm))
#set text(font: "New Computer Modern", size: 11pt)
#set heading(numbering: "1.1")

// Title page
#align(center)[
  #v(3cm)
  #text(size: 28pt, weight: "bold")[JK BMS Monitor]
  #v(0.5cm)
  #text(size: 16pt, fill: rgb("#666"))[User Manual]
  #v(1cm)
  #text(size: 12pt)[Black Sphere Industries]
  #v(0.3cm)
  #text(size: 11pt, fill: rgb("#999"))[Version 1.0 --- March 2026]
  #v(3cm)
]
#pagebreak()

#outline(title: "Table of Contents", indent: 1.5em)
#pagebreak()

= Introduction

JK BMS Monitor is a browser-based application for monitoring JK Battery Management Systems via Web Bluetooth. It connects directly to JK BMS devices over Bluetooth Low Energy (BLE) and displays real-time battery telemetry including cell voltages, temperatures, current flow, state of charge, and protection status.

The application supports simultaneous monitoring of up to three BMS devices, with each device assigned a distinct color-coded slot (green, blue, orange). It implements the JK BMS BLE protocol as documented in the `esphome-jk-bms` project, supporting three protocol variants: JK02_24S, JK02_32S, and JK04.

Key capabilities:
- Real-time BLE communication with JK BMS devices
- Support for up to 32 cell monitoring per device
- Multi-device monitoring (up to 3 simultaneous connections)
- Cell voltage visualization with bar charts and statistics
- Temperature monitoring (MOS, battery probes, internal)
- MOSFET status monitoring (charge, discharge, balance)
- Raw hex data inspection for protocol debugging
- Activity logging per device
- PWA support for mobile use

= Getting Started

== System Requirements

- *Browser*: Google Chrome, Microsoft Edge, or Opera (Web Bluetooth API required)
- *Operating System*: Android, Windows, macOS, or Chrome OS (iOS/Safari do not support Web Bluetooth)
- *Hardware*: A JK BMS with Bluetooth capability

Web Bluetooth is *not* supported in Firefox or Safari. The app displays a warning banner if the browser lacks support.

== Accessing the Application

JK BMS Monitor is available at:

#align(center)[
  #link("https://jk-bms-app.pages.dev/")[`https://jk-bms-app.pages.dev/`]
]

It can also be accessed through the BSI Portal at `blacksphereindustries.nl`.

== Connecting a BMS

+ Ensure your JK BMS is powered on and Bluetooth is enabled
+ Open the app in a compatible browser
+ Click the *"Add BMS"* button
+ In the browser's Bluetooth device picker, select your JK BMS
+ The app establishes a BLE connection and begins receiving telemetry data

= Features

== Multi-Device Monitoring

The app supports connecting up to three JK BMS devices simultaneously. Each connected device is assigned a color-coded slot:

- *Slot 0* (Green) --- First connected device
- *Slot 1* (Blue) --- Second connected device
- *Slot 2* (Orange) --- Third connected device

When all three slots are occupied, the "Add BMS" card is hidden. Disconnecting a device frees its slot for a new connection.

== Battery Overview

Each device panel displays at a glance:

- *Pack Voltage* --- Total battery pack voltage in volts
- *Pack Current* --- Current flow in amps (positive = charging, negative = discharging)
- *Pack Power* --- Computed power in watts
- *State of Charge (SOC)* --- Battery charge percentage with a color-gradient progress bar
- *State of Health (SOH)* --- Battery health percentage
- *Remaining Capacity* --- Current usable capacity in Ah
- *Full Capacity* --- Total battery capacity in Ah
- *Charge Cycles* --- Lifetime charge cycle count
- *Cycle Capacity* --- Total energy cycled in Ah
- *Runtime* --- Estimated remaining runtime

== Cell Voltage Monitoring

The cell voltage section provides:

- *Cell Summary* --- Shows minimum, average, and maximum cell voltages at a glance
- *Cell Bar Chart* --- Each cell is displayed as a horizontal bar with:
  - Cell number label
  - Color-coded bar (red = low, yellow = marginal, green = OK, orange = high)
  - Exact voltage reading
- *Delta Voltage* --- The difference between the highest and lowest cell, a key indicator of cell balance

== Temperature Monitoring

Temperature readings are displayed in a grid layout:

- *MOS Temperature* --- MOSFET transistor temperature
- *Battery Temp 1 & 2* --- External battery probe temperatures
- *Internal Temp* --- Internal BMS board temperature

Temperatures are color-coded:
- Green: Normal operating range
- Orange: Warm (approaching limits)
- Red: Hot (near or exceeding protection thresholds)

== MOSFET and Protection Status

A three-column status grid shows:

- *Charge MOS* --- On/Off status (green/red) of the charge MOSFET
- *Discharge MOS* --- On/Off status of the discharge MOSFET
- *Balance* --- Active/Inactive status of cell balancing

The balance current is also displayed when balancing is active.

== Error Detection

The app decodes the BMS error bitmask and displays active faults:
- Charge/discharge overtemperature and undertemperature
- Cell/pack overvoltage and undervoltage
- Charge/discharge overcurrent and short circuit
- MOSFET overtemperature
- Cell count mismatch
- Current sensor anomaly
- Wire resistance fault
- Coprocessor communication error

== Device Information

The Info tab displays:
- BMS model name
- Firmware version
- Hardware version
- Serial number
- Device name

== Debug Tools

=== Hex Dump
The Debug tab provides a raw hex dump view of BLE frames with color-coded sections:
- Header bytes (amber)
- Data payload (white)
- CRC bytes (yellow)
- Offset addresses (gray)

=== Activity Log
A scrollable log records connection events, frame counts, protocol detection, and errors with color-coded severity:
- Info (amber)
- OK (green)
- Warning (yellow)
- Error (red)

== Tabbed Interface

Each device panel uses tabs to organize information:
- *Overview* --- Battery stats, cell voltages, temperatures
- *Info* --- Device identification
- *Debug* --- Hex dump and activity log

= User Interface

== Layout

The app uses a responsive grid layout:
- *Header* --- Sticky top bar with app title, BLE icon, and global connection status
- *Device Grid* --- Auto-filling grid of device panels (min 340px per card)
- *Add Card* --- Dashed-border card for adding new BMS connections

== Device Panels

Each connected device is rendered as a card with:
- *Panel Header* --- Slot badge (colored), device name, connection status dot, and disconnect button
- *Panel Body* --- Tabbed content area
- *Status Indicator* --- Animated dot showing connection state:
  - Green with glow: Connected
  - Yellow with pulse: Connecting
  - Red: Disconnected

== Responsive Design

On mobile screens (< 400px), the grid collapses to a single column and stat values are resized for readability. The app supports safe-area insets for notched mobile devices.

== Theme Support

The app supports dark and light themes via CSS custom properties. When embedded in the BSI Portal, theme changes are relayed via `postMessage` using the BSI Theme Bridge pattern. In standalone mode, a theme toggle is available.

= Workflows

== Monitoring a Single Battery Pack

+ Open the app and click "Add BMS"
+ Select your JK BMS from the Bluetooth picker
+ The Overview tab appears with real-time data
+ Monitor cell voltages for balance issues (check delta voltage)
+ Watch temperatures during charge/discharge cycles
+ Check MOSFET status to verify charge/discharge is enabled

== Comparing Multiple Battery Packs

+ Connect the first BMS (green slot)
+ Click "Add BMS" again for the second device (blue slot)
+ Optionally connect a third device (orange slot)
+ Compare cell voltage distributions across packs
+ Identify packs with poor cell balance (high delta voltage)

== Debugging BLE Communication

+ Connect to a BMS device
+ Switch to the Debug tab
+ Observe the hex dump for incoming BLE frames
+ Check the activity log for protocol detection and frame counts
+ Use this information to diagnose communication issues

= Architecture

The application is a single HTML file with all JavaScript and CSS inline. It uses the Web Bluetooth API for BLE communication and implements the JK BMS protocol parser.

== Architecture Overview

#figure(
  image("uml-architecture.svg", width: 100%),
  caption: [System architecture showing the BLE communication layer, protocol parser, and UI rendering.]
)

== Class Diagram

#figure(
  image("uml-class-diagram.svg", width: 100%),
  caption: [Class diagram showing the slot management system, BMS data model, and BLE protocol constants.]
)

== Full System Diagram

#figure(
  image("uml-diagrams.svg", width: 100%),
  caption: [Comprehensive system diagram including BLE services, frame parsing, and multi-device state management.]
)

== Main BLE Connection Sequence

#figure(
  image("uml-seq-main.svg", width: 100%),
  caption: [Sequence diagram showing the BLE connection flow from device discovery through GATT service setup to data streaming.]
)

== Data Processing Sequence

#figure(
  image("uml-seq-secondary.svg", width: 100%),
  caption: [Sequence diagram showing how incoming BLE frames are buffered, parsed, and rendered to the UI.]
)

== Application States

#figure(
  image("uml-states.svg", width: 100%),
  caption: [State diagram showing connection states (disconnected, connecting, connected, reconnecting) and slot lifecycle.]
)

= Configuration

== BLE Protocol Constants

The application uses the following BLE service and characteristic UUIDs:
- Service UUID: `0xFFE0`
- Notify Characteristic: `0xFFE1`
- Write Characteristic: `0xFFE2`

Command codes:
- Cell Info Request: `0x96`
- Device Info Request: `0x97`

Frame types:
- Settings: `0x01`
- Cell Data: `0x02`
- Device Info: `0x03`

== Protocol Variants

The app auto-detects the protocol variant based on frame structure:
- *JK02_24S* --- For 24-cell JK02 series BMS
- *JK02_32S* --- For 32-cell JK02 series BMS
- *JK04* --- For JK04 series BMS

== Heartbeat

A heartbeat signal is sent every 5 seconds (`HEARTBEAT_INTERVAL = 5000ms`) to maintain the BLE connection and request updated telemetry data.

= Troubleshooting

== Browser Compatibility Warning

If you see the yellow warning banner "Web Bluetooth is not supported," you must switch to a compatible browser:
- *Supported*: Chrome (Android/Desktop), Edge, Opera
- *Not Supported*: Firefox, Safari, iOS browsers

== BMS Not Found in Bluetooth Picker

- Ensure the BMS is powered on and not connected to another device
- Move closer to the BMS (BLE range is typically 5--10 meters)
- Try powering the BMS off and on again
- Check that Bluetooth is enabled on your computer/phone

== Connection Drops

The app includes automatic reconnection logic. If a connection drops:
- The status dot turns red
- The app attempts to reconnect automatically
- Check the Debug log for error details
- Ensure the BMS is still powered and in range

== No Data After Connection

- Switch to the Debug tab and check the hex dump for incoming frames
- Verify the frame counter is incrementing
- If no frames arrive, the BMS may require a firmware update
- Try disconnecting and reconnecting

== Incorrect Cell Count

If the app shows fewer cells than expected, the protocol variant may be misdetected. Check the activity log for the detected protocol version. The app auto-detects between JK02_24S, JK02_32S, and JK04 based on frame structure.
