#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
#sed -i '$a src-git lienol https://github.com/Lienol/openwrt-package' feeds.conf.default

# git clone https://github.com/fw876/helloworld.git package/luci-app-ssr-plus

# passwall-package 
git clone https://github.com/fw876/helloworld.git package/ssr
git clone https://github.com/xiaorouji/openwrt-passwall.git package/passwall

# 添加 smartdns
git clone https://github.com/vi-si/openwrt-smartdns.git package/openwrt-smartdns
git clone https://github.com/vi-si/luci-app-smartdns-1.git feeds/luci/applications/luci-app-smartdns

mkdir -p tools/ucl && wget -P tools/ucl https://raw.githubusercontent.com/coolsnowwolf/lede/master/tools/ucl/Makefile 
mkdir -p tools/upx && wget -P tools/upx https://raw.githubusercontent.com/coolsnowwolf/lede/master/tools/upx/Makefile
sed  -i '/tools-$(CONFIG_TARGET_orion_generic)/atools-y += ucl upx' tools/Makefile
sed  -i '/dependencies/a\\$(curdir)/upx/compile := $(curdir)/ucl/compile' tools/Makefile

#update golang
pushd feeds/packages/lang
rm -rf golang && svn co https://github.com/openwrt/packages/trunk/lang/golang
popd
