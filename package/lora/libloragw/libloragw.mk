################################################################################
#
# libloragw
#
################################################################################

LIBLORAGW_VERSION = v4.1.3
LIBLORAGW_SITE = $(call github,Lora-net,lora_gateway,$(LIBLORAGW_VERSION))
LIBLORAGW_LICENSE = special
LIBLORAGW_LICENSE_FILES = LICENSE
LIBLORAGW_INSTALL_STAGING = YES

define LIBLORAGW_BUILD_CMDS
        $(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" \
                -C $(@D) all
endef

define LIBLORAGW_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)/lora

	$(INSTALL) -D -m 755 $(@D)/reset_lgw.sh $(TARGET_DIR)/lora
	$(INSTALL) -D -m 755 $(@D)/libloragw/test_* $(TARGET_DIR)/lora
	$(INSTALL) -D -m 755 $(@D)/util_pkt_logger/util_pkt_logger $(TARGET_DIR)/lora
	$(INSTALL) -D -m 755 $(@D)/util_tx_continuous/util_tx_continuous $(TARGET_DIR)/lora
	$(INSTALL) -D -m 755 $(@D)/util_tx_test/util_tx_test $(TARGET_DIR)/lora
	$(INSTALL) -D -m 755 $(@D)/util_spi_stress/util_spi_stress $(TARGET_DIR)/lora
	$(INSTALL) -D -m 644 $(BR2_EXTERNAL_GRINN_EXAMPLES_PATH)/package/lora/libloragw/*.json $(TARGET_DIR)/lora
endef
define LIBLORAGW_INSTALL_STAGING_CMDS
	$(INSTALL) -d $(STAGING_DIR)/lora
	$(INSTALL) -D -m 555 $(@D)/libloragw/libloragw.a $(STAGING_DIR)/lora
	ln -fs $(STAGING_DIR)/lora/libloragw.a $(STAGING_DIR)/lib/libloragw.a
	$(INSTALL) -D -m 555 $(@D)/libloragw/library.cfg $(STAGING_DIR)/lora
	$(INSTALL) -d $(STAGING_DIR)/lora/inc
	$(INSTALL) $(@D)/libloragw/inc/* $(STAGING_DIR)/lora/inc/
endef

$(eval $(generic-package))
