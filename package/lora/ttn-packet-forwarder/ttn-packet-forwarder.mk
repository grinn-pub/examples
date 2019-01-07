################################################################################
#
# ttn-packet-forwarder
#
################################################################################

TTN_PACKET_FORWARDER_VERSION=8126ce1eb5e3bfa05ce4649a01a4eb35dd80969e
TTN_PACKET_FORWARDER_SITE = $(call github,TheThingsNetwork,packet_forwarder,$(TTN_PACKET_FORWARDER_VERSION))
TTN_PACKET_FORWARDER_LICENSE = special
TTN_PACKET_FORWARDER_LICENSE_FILES = LICENSE

define TTN_PACKET_FORWARDER_BUILD_CMDS
        $(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" \
                -C $(@D) LGW_PATH="$(STAGING_DIR)/lora" CFG_SPI="native" LIBS="-lm -lloragw -lpthread -lrt" all
endef
define TTN_PACKET_FORWARDER_INSTALL_INIT_SYSTEMD
        $(INSTALL) -D -m 0644 $(BR2_EXTERNAL_GRINN_EXAMPLES_PATH)/package/lora/ttn-packet-forwarder/ttn-packet-forwarder.service $(TARGET_DIR)/etc/systemd/system
        ln -sf ../ttn-packet-forwarder.service $(TARGET_DIR)/etc/systemd/system/multi-user.target.wants/ttn-packet-forwarder.service
endef
define TTN_PACKET_FORWARDER_INSTALL_INIT_SYSV
        $(INSTALL) -D -m 0755 $(BR2_EXTERNAL_GRINN_EXAMPLES_PATH)/package/lora/ttn-packet-forwarder/S60ttngw $(TARGET_DIR)/etc/init.d/S60ttngw
endef

define TTN_PACKET_FORWARDER_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)/ttn
	$(INSTALL) -D -m 755 $(@D)/poly_pkt_fwd/poly_pkt_fwd $(TARGET_DIR)/ttn
	$(INSTALL) -D -m 755 $(@D)/util_ack/util_ack $(TARGET_DIR)/ttn
	$(INSTALL) -D -m 755 $(@D)/util_sink/util_sink $(TARGET_DIR)/ttn
	$(INSTALL) -D -m 755 $(@D)/util_tx_test/util_tx_test $(TARGET_DIR)/ttn
	$(INSTALL) -D -m 644 $(BR2_EXTERNAL_GRINN_EXAMPLES_PATH)/package/lora/ttn-packet-forwarder/*.json $(TARGET_DIR)/ttn
	$(INSTALL) -D -m 755 $(BR2_EXTERNAL_GRINN_EXAMPLES_PATH)/package/lora/ttn-packet-forwarder/update_gwid.sh $(TARGET_DIR)/ttn
endef

$(eval $(generic-package))
