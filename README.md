# NM Polybar Script

Pure bash script to generate connection format. Used for polybar.

Install it into your PATH, or call it directly.

## Requirements

- nmcli
- ifstat -> `sudo apt install ifstat` [optional]

## Usage
```bash
nm_poly_widget.sh your_device
nm_poly_widget.sh wlan0
```

## Why

The current polybar implementation doesn't uses wireless-tools for it's wireless-network implementation. I use wifi usb dongle that not supported by libnl.


## Screnshot

without `ifstat`

![ss](screenshot.png)

using `ifstat`

![using ifstat](using_ifstat.png)