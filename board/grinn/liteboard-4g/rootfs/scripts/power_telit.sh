#!/bin/sh

gpioset -m time -s 2 `gpiofind "GSM_ONn"`=1; gpioset `gpiofind "GSM_ONn"`=0
