#!/usr/bin/env bash

# To use correct device-tree blob we have two options:
#
# 1. correct name of DTB file in the U-Boot, correct genimage file, etc.
# 2. replace imx6ul-liteboard.dtb file by this customized by this project; while
#    name of the file is this same U-Boot will be happy and our customized device-tree
#    will be also forwarded to device image.
cp ${BINARIES_DIR}/imx6ul-liteboard-telit.dtb ${BINARIES_DIR}/imx6ul-liteboard.dtb
