# NM Polybar Script

Pure bash script to generate connection format. Used for polybar.

Install it into your PATH, or call it directly.

## Usage
```bash
nm_poly_widget.sh your_device
nm_poly_widget.sh wlan0
```

## Why

The current polybar implementation doesn't uses wireless-tools for it's wireless-network implementation. I use wifi usb dongle that not supported by libnl.


## Screnshot

![ss](screenshot.png)