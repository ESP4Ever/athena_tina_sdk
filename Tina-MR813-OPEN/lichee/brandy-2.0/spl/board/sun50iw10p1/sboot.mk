
#
#config file for sun50iw10
#
#stroage
include $(TOPDIR)/board/sun50iw10p1/common.mk

MODULE=sboot

CFG_SUNXI_MMC =y
CFG_SUNXI_NAND =y
CFG_SUNXI_CE_21 =y
CFG_SUNXI_EFUSE =y
CFG_SUNXI_SMC_30=y
CFG_SUNXI_SBOOT =y
CFG_SUNXI_ITEM_HASH =y
CFG_SUNXI_KEY_PROVISION =y
