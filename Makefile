#
# Copyright (C) 2010-2023 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=autocore
PKG_FLAGS:=nonshared
PKG_RELEASE:=$(COMMITCOUNT)

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/target.mk

define Package/autocore-ramips
  TITLE:=Ramips auto core loadbalance script.
  MAINTAINER:=ifuturenan
  DEPENDS:=@(TARGET_ramips)
endef

define Package/autocore-ramips/description
  A luci autoconfig hotplug script.
endef

define Build/Compile
endef

define Package/autocore-ramips/install
	$(INSTALL_DIR) $(1)/etc
	$(CP) ./files/generic/10_system.js $(1)/etc/rpcd_10_system.js
	$(CP) ./files/generic/luci $(1)/etc/rpcd_luci

	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/generic/090-cover-index_files $(1)/etc/uci-defaults/

	$(INSTALL_DIR) $(1)/sbin
	$(INSTALL_BIN) ./files/ramips/sbin/cpuinfo $(1)/sbin/cpuinfo

	$(INSTALL_DIR) $(1)/usr/share/rpcd/acl.d
	$(CP) ./files/generic/luci-mod-status-autocore.json $(1)/usr/share/rpcd/acl.d/
endef

$(eval $(call BuildPackage,autocore-ramips))
