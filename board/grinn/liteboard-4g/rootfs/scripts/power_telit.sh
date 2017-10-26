#!/bin/sh

gpioset `gpiofind "GSM_ONn"`=1
sleep 2
gpioset `gpiofind "GSM_ONn"`=0

