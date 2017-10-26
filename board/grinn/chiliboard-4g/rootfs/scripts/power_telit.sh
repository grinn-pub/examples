#!/bin/sh

gpioset -m time -s 2 `gpiofind "GSM_ONn"`=1
