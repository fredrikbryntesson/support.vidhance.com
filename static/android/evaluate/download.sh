#!/bin/sh
echo Enter your key:
read KEY
echo Downloading files...
URL=https://aurora.imint.se/data/$KEY/nexus6
wget $URL/camera.msm8084.so
wget $URL/fastboot
wget $URL/flash_android.sh
wget $URL/flash_vidhance.sh
wget $URL/libvidhance_android32.so
wget $URL/rooted_unencrypted_shamu-lrx22c.zip
wget $URL/bootloader-shamu-moto-apq8084-71.05.img
wget $URL/radio-shamu-d4.0-9625-02.55.04.img
