#!/bin/bash
#=================================================
# Description: DIY script
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#=================================================

# Modify default IP
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

# Mod default-settings
[ -d package/emortal/default-settings/files ] && pushd package/emortal/default-settings/files

cat << 'EOF' >>  99-default-settings

if ! grep '/usr/bin/zsh' /etc/passwd
sed -i 's|/bin/ash|/usr/bin/zsh|g' /etc/passwd
fi

exit 0
EOF

echo "=== gigalog: Start of 99-default-settings contents.. ==="
cat 99-default-settings
echo "=== gigalog: End off 99-default-settings contents.. ==="
popd

pushd package/base-files
sed -i 's/ImmortalWrt/GiGaWRT/g' image-config.in
sed -i 's/ImmortalWrt/GiGaWRT/g' files/bin/config_generate
sed -i 's/UTC/UTC+8/g' files/bin/config_generate
popd

sed -i 's/ImmortalWrt/GiGaWRT/g' config/Config-images.in
sed -i 's/ImmortalWrt/GiGaWRT/g' include/version.mk
sed -i 's/immortalwrt.org/openwrt.org/g' include/version.mk
#sed -i 's|github.com/immortalwrt/immortalwrt/issues|helmiau.com|g' include/version.mk
#sed -i 's|github.com/immortalwrt/immortalwrt/discussions|helmiau.com|g' include/version.mk

# Delete ImmortalWrt source
#find . -type d -name "luci-app-openclash" -exec rm -rf "{}" \;
#find . -type f -name "luci-app-openclash" -exec rm -rf "{}" \;

# Version Update
sed -i '/DISTRIB_DESCRIPTION/d' package/base-files/files/etc/openwrt_release
echo "DISTRIB_DESCRIPTION=' RI-B0-B1 build $(TZ=UTC+8 date "+%Y.%m") '" >> package/base-files/files/etc/openwrt_release
sed -i '/DISTRIB_REVISION/d' package/base-files/files/etc/openwrt_release
echo "DISTRIB_REVISION='[WSS]'" >> package/base-files/files/etc/openwrt_release

# Add date version
#export DATE_VERSION=$(date -d "$(rdate -n -4 -p pool.ntp.org)" +'%Y-%m-%d')
#sed -i "s/%C/%C (${DATE_VERSION})/g" package/base-files/files/etc/openwrt_release

# Update TimeZone
#sed -i 's/ntp.tencent.com/time.google.com/g' package/base-files/files/bin/config_generate
#sed -i 's/ntp1.aliyun.com/time.cloudflare.com/g' package/base-files/files/bin/config_generate
#sed -i 's/ntp.ntsc.ac.cn/clock.sjc.he.net/g' package/base-files/files/bin/config_generate
#sed -i 's/cn.ntp.org.cn/my.pool.ntp.org/g' package/base-files/files/bin/config_generate

############################################################
# Remove some net packages
rm -rf ./feeds/packages/net/https-dns-proxy
rm -rf ./feeds/packages/net/kcptun
rm -rf ./feeds/packages/net/shadowsocks-libev
rm -rf ./feeds/packages/net/xray-core
rm -rf ./feeds/packages/net/brook
rm -rf ./feeds/packages/net/chinadns-ng
rm -rf ./feeds/packages/net/hysteria
rm -rf ./feeds/packages/net/ssocks
rm -rf ./feeds/packages/net/trojan
rm -rf ./feeds/packages/net/trojan-go
rm -rf ./feeds/packages/net/trojan-plus
rm -rf ./feeds/packages/net/sagernet-core
rm -rf ./feeds/packages/net/naiveproxy
rm -rf ./feeds/packages/net/shadowsocks-rust
rm -rf ./feeds/packages/net/shadowsocksr-libev
rm -rf ./feeds/packages/net/simple-obfs
rm -rf ./feeds/packages/net/tcping
rm -rf ./feeds/packages/net/v2ray-core
rm -rf ./feeds/packages/net/v2ray-geodata
rm -rf ./feeds/packages/net/v2ray-plugin
rm -rf ./feeds/packages/net/v2raya
rm -rf ./feeds/packages/net/xray-core
rm -rf ./feeds/packages/net/xray-plugin
rm -rf ./feeds/packages/net/dns2socks
rm -rf ./feeds/packages/net/microsocks
rm -rf ./feeds/packages/net/ipt2socks
rm -rf ./feeds/packages/net/pdnsd-alt
rm -rf ./feeds/packages/net/redsocks2

# Dependencies
svn export https://github.com/xiaorouji/openwrt-passwall/trunk/brook feeds/packages/net/brook
svn export https://github.com/xiaorouji/openwrt-passwall/trunk/chinadns-ng feeds/packages/net/chinadns-ng
svn export https://github.com/xiaorouji/openwrt-passwall/trunk/dns2tcp feeds/packages/net/dns2tcp
svn export https://github.com/xiaorouji/openwrt-passwall/trunk/hysteria feeds/packages/net/hysteria
svn export https://github.com/xiaorouji/openwrt-passwall/trunk/ssocks feeds/packages/net/ssocks
svn export https://github.com/xiaorouji/openwrt-passwall/trunk/sing-box feeds/packages/net/sing-box
svn export https://github.com/xiaorouji/openwrt-passwall/trunk/trojan-go feeds/packages/net/trojan-go
svn export https://github.com/xiaorouji/openwrt-passwall/trunk/trojan-plus feeds/packages/net/trojan-plus
svn export https://github.com/xiaorouji/openwrt-passwall/trunk/sagernet-core feeds/packages/net/sagernet-core
svn export https://github.com/fw876/helloworld/trunk/naiveproxy feeds/packages/net/naiveproxy
svn export https://github.com/immortalwrt/packages/trunk/net/shadowsocks-libev feeds/packages/net/shadowsocks-libev
svn export https://github.com/fw876/helloworld/trunk/shadowsocks-rust feeds/packages/net/shadowsocks-rust
svn export https://github.com/fw876/helloworld/trunk/shadowsocksr-libev feeds/packages/net/shadowsocksr-libev
svn export https://github.com/fw876/helloworld/trunk/simple-obfs feeds/packages/net/simple-obfs
svn export https://github.com/fw876/helloworld/trunk/tcping feeds/packages/net/tcping
svn export https://github.com/fw876/helloworld/trunk/trojan feeds/packages/net/trojan
svn export https://github.com/fw876/helloworld/trunk/v2ray-core feeds/packages/net/v2ray-core
svn export https://github.com/fw876/helloworld/trunk/v2ray-geodata feeds/packages/net/v2ray-geodata
svn export https://github.com/fw876/helloworld/trunk/v2ray-plugin feeds/packages/net/v2ray-plugin
svn export https://github.com/fw876/helloworld/trunk/v2raya feeds/packages/net/v2raya
svn export https://github.com/arqam999/openwrt-passwall/branches/xtls-wss-1-6-1/xray-core feeds/packages/net/xray-core
svn export https://github.com/fw876/helloworld/trunk/xray-plugin feeds/packages/net/xray-plugin
svn export https://github.com/fw876/helloworld/trunk/lua-neturl feeds/packages/net/lua-neturl
svn export https://github.com/immortalwrt/packages/trunk/net/dns2socks feeds/packages/net/dns2socks
svn export https://github.com/immortalwrt/packages/trunk/net/microsocks feeds/packages/net/microsocks
svn export https://github.com/immortalwrt/packages/trunk/net/ipt2socks feeds/packages/net/ipt2socks
svn export https://github.com/immortalwrt/packages/trunk/net/pdnsd-alt feeds/packages/net/pdnsd-alt
svn export https://github.com/immortalwrt/packages/trunk/net/redsocks2 feeds/packages/net/redsocks2
svn export https://github.com/immortalwrt/packages/trunk/net/https-dns-proxy feeds/packages/net/https-dns-proxy
svn export https://github.com/immortalwrt/packages/trunk/net/kcptun feeds/packages/net/kcptun
svn export https://github.com/kiddin9/openwrt-bypass/trunk/lua-maxminddb feeds/packages/net/lua-maxminddb
svn export https://github.com/coolsnowwolf/lede/trunk/package/lean/shortcut-fe package/kernel/shortcut-fe
svn export https://github.com/immortalwrt/packages/trunk/net/dnsforwarder feeds/packages/net/dnsforwarder

############################################################
# luci-app-passwall
rm -r ./feeds/luci/applications/luci-app-passwall
svn export https://github.com/arqam999/openwrt-passwall/branches/luci-nodns/luci-app-passwall feeds/luci/applications/luci-app-passwall

#luci-app-turboacc
svn export https://github.com/immortalwrt/luci/trunk/applications/luci-app-turboacc feeds/luci/applications/luci-app-turboacc

# Autocore
svn export https://github.com/immortalwrt/immortalwrt/branches/openwrt-21.02/package/emortal/autocore feeds/packages/utils/autocore
sed -i 's/"getTempInfo" /"getTempInfo", "getCPUBench", "getCPUUsage" /g' feeds/packages/utils/autocore/files/generic/luci-mod-status-autocore.json

# Coremark
rm -rf ./feeds/packages/utils/coremark
svn export https://github.com/immortalwrt/packages/trunk/utils/coremark feeds/packages/utils/coremark
############################################################

# Clone community packages to package/community
mkdir package/community
pushd package/community

# Add Argon theme configuration
#git clone --depth=1 https://github.com/jerrykuku/luci-app-argon-config

# Add official OpenClash source
git clone --depth=1 -b dev https://github.com/vernesong/OpenClash

# HelmiWrt packages
git clone --depth=1 https://github.com/helmiau/helmiwrt-packages
rm -rf helmiwrt-packages/luci-app-v2raya
# telegrambot
svn co https://github.com/helmiau/helmiwrt-adds/trunk/packages/net/telegrambot helmiwrt-adds/telegrambot
svn co https://github.com/helmiau/helmiwrt-adds/trunk/luci/luci-app-telegrambot helmiwrt-adds/luci-app-telegrambot

# Add luci-theme-neobird theme
git clone --depth=1 https://github.com/helmiau/luci-theme-neobird

if [[ $TOOLCHAIN_IMAGE == *"x86"* ]]; then
	echo "x86 target detected! Adding patches..."
	# Add rtl8723bu (tismart ds686) for x86
	svn co https://github.com/radityabh/raditya-package/branches/Kernel_5.4/rtl8723bu kernel/rtl8723bu
	echo -e "CONFIG_PACKAGE_kmod-rtl8723bu=y" >> $OPENWRT_ROOT_PATH/.config
	# Fix USB to LAN
	# sed -i 's/kmod-usb-net-rtl8152=/kmod-usb-net-rtl8152-vendor=/g' $OPENWRT_ROOT_PATH/.config
	# Add Configs to Kernel Config
	[ -f $OPENWRT_ROOT_PATH/target/linux/x86/config-5.4 ] && cat $GITHUB_WORKSPACE/config/x86-kernel.config >> $OPENWRT_ROOT_PATH/target/linux/x86/config-5.4
	[ -f $OPENWRT_ROOT_PATH/target/linux/x86/generic/config-5.4 ] && cat $GITHUB_WORKSPACE/config/x86-kernel.config >> $OPENWRT_ROOT_PATH/target/linux/x86/generic/config-5.4
	[ -f $OPENWRT_ROOT_PATH/target/linux/x86/64/config-5.4 ] && cat $GITHUB_WORKSPACE/config/x86-kernel.config >> $OPENWRT_ROOT_PATH/target/linux/x86/64/config-5.4
fi

if [[ $TOOLCHAIN_IMAGE == *"armvirt"* ]]; then
	# Add luci-app-amlogic
	echo "armvirt target detected! Adding amlogic service..."
	git clone --depth=1 https://github.com/ophub/luci-app-amlogic
	echo -e "CONFIG_PACKAGE_dosfstools=y" >> $OPENWRT_ROOT_PATH/.config
	echo -e "CONFIG_PACKAGE_util-linux=y" >> $OPENWRT_ROOT_PATH/.config
	echo -e "CONFIG_PACKAGE_uuidgen=y" >> $OPENWRT_ROOT_PATH/.config
	echo -e "CONFIG_PACKAGE_luci-lib-fs=y" >> $OPENWRT_ROOT_PATH/.config
	echo -e "CONFIG_PACKAGE_perl=y" >> $OPENWRT_ROOT_PATH/.config
	# Fix USB to LAN
	# sed -i 's/kmod-usb-net-rtl8152=/kmod-usb-net-rtl8152-vendor=/g' $OPENWRT_ROOT_PATH/.config
fi

if [[ $TOOLCHAIN_IMAGE == *"rockchip-armv8"* ]]; then
	# Add rockchip-armv8 patches
	echo "rockchip-armv8 target detected! Adding patches..."
	sed -i "s|Shadowsocks_Libev_Client=y|Shadowsocks_Libev_Client=n|g" $OPENWRT_ROOT_PATH/.config
	sed -i "s|Shadowsocks_Libev_Server=y|Shadowsocks_Libev_Server=n|g" $OPENWRT_ROOT_PATH/.config
	sed -i "s|Shadowsocks_Rust_Client=n|Shadowsocks_Rust_Client=y|g" $OPENWRT_ROOT_PATH/.config
	sed -i "s|Shadowsocks_Rust_Client=n|Shadowsocks_Rust_Client=y|g" $OPENWRT_ROOT_PATH/.config
fi

if [[ $TOOLCHAIN_IMAGE == *"sunxi-cortexa53"* ]]; then
	# Add sunxi cortexa53
	echo "sunxi cortexa53 target detected! Adding patches..."
	sed -i "s|hostapd-utils=y|hostapd-utils=n|g" $OPENWRT_ROOT_PATH/.config
	sed -i "s|hostapd-common=y|hostapd-common=n|g" $OPENWRT_ROOT_PATH/.config
	sed -i "s|hostapd=y|hostapd=n|g" $OPENWRT_ROOT_PATH/.config
	sed -i "s|wpa-supplicant=y|wpa-supplicant=n|g" $OPENWRT_ROOT_PATH/.config
fi

if [[ $TOOLCHAIN_IMAGE == *"sunxi-cortexa7"* ]]; then
	# Add sunxi cortexa7
	echo "sunxi cortexa7 target detected! Adding patches..."
	sed -i "s|hostapd-utils=y|hostapd-utils=n|g" $OPENWRT_ROOT_PATH/.config
	sed -i "s|hostapd-common=y|hostapd-common=n|g" $OPENWRT_ROOT_PATH/.config
	sed -i "s|hostapd=y|hostapd=n|g" $OPENWRT_ROOT_PATH/.config
	sed -i "s|wpa-supplicant=y|wpa-supplicant=n|g" $OPENWRT_ROOT_PATH/.config
fi

if [[ $TOOLCHAIN_IMAGE == *"bcm2711"* ]]; then
	# Add bcm2711 patches
	echo "bcm2711 target detected! Adding patches..."
	echo -e "CONFIG_USB_LAN78XX=y\nCONFIG_USB_NET_DRIVERS=y" >> $OPENWRT_ROOT_PATH/target/linux/bcm27xx/bcm2711/config-5.4
	sed -i 's/36/44/g;s/VHT80/VHT20/g' $OPENWRT_ROOT_PATH/package/kernel/mac80211/files/lib/wifi/mac80211.sh
else
	# Add non-bcm2711 patches
	echo "non-bcm2711 target detected! Adding patches..."
	pinctrl_bcm2835_dir=$OPENWRT_ROOT_PATH/target/linux/bcm27xx/patches-5.4/950-0316-pinctrl-bcm2835-Add-support-for-BCM2711-pull-up-func.patch
	[ -f $pinctrl_bcm2835_dir ] && rm -f $pinctrl_bcm2835_dir
fi

if [[ $SOURCE_BRANCH == *"21.02"* ]]; then
	echo "OpenWrt $SOURCE_BRANCH detected! adding openwrt-$SOURCE_BRANCH config..."
	sed -i "s|argonv3=y|argon=n|g" $OPENWRT_ROOT_PATH/.config
	sed -i "s|edge=y|edge=n|g" $OPENWRT_ROOT_PATH/.config
	sed -i "s|neobird=y|neobird=n|g" $OPENWRT_ROOT_PATH/.config
	sed -i "s|vnstat=y|vnstat2=y|g" $OPENWRT_ROOT_PATH/.config
	sed -i "s|vnstati=y|vnstati2=y|g" $OPENWRT_ROOT_PATH/.config
fi

# Add Adguardhome
#git clone --depth=1 https://github.com/yang229/luci-app-adguardhome
git clone https://github.com/rufengsuixing/luci-app-adguardhome.git package/new/luci-app-adguardhome
rm -rf ./feeds/packages/net/adguardhome
svn export https://github.com/openwrt/packages/trunk/net/adguardhome feeds/packages/net/adguardhome
sed -i '/init/d' feeds/packages/net/adguardhome/Makefile

popd

# Fix mt76 wireless driver
pushd package/kernel/mt76
sed -i '/mt7662u_rom_patch.bin/a\\techo mt76-usb disable_usb_sg=1 > $\(1\)\/etc\/modules.d\/mt76-usb' Makefile
popd

# Change default shell to zsh
sed -i 's|/bin/ash|/usr/bin/zsh|g' package/base-files/files/etc/passwd

#-----------------------------------------------------------------------------
#   Start of terminal scripts additionals menu
#-----------------------------------------------------------------------------
HWOSDIR="package/base-files/files"
rawgit="https://raw.githubusercontent.com"
[ ! -d $HWOSDIR/usr/bin ] && mkdir -p $HWOSDIR/usr/bin

# Add fix download file.php for xderm and libernet
# run "fixphp" using terminal for use
wget --no-check-certificate -qO $HWOSDIR/bin/fixphp "$rawgit/helmiau/openwrt-config/main/fix-xderm-libernet-gui"


chmod 0755 -R $HWOSDIR/bin/*
chmod 0755 -R $HWOSDIR/usr/bin/*

#-----------------------------------------------------------------------------
#   End of terminal scripts additionals menu
#-----------------------------------------------------------------------------

# Add extra wireless drivers
svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-18.06-k5.4/package/kernel/rtl8812au-ac
svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-18.06-k5.4/package/kernel/rtl8188eu
svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-18.06-k5.4/package/kernel/rtl88x2bu

# Add cpufreq
rm -rf ./feeds/luci/applications/luci-app-cpufreq 
svn co https://github.com/DHDAXCW/luci-bt/trunk/applications/luci-app-cpufreq ./feeds/luci/applications/luci-app-cpufreq
ln -sf ./feeds/luci/applications/luci-app-cpufreq ./package/feeds/luci/luci-app-cpufreq
sed -i 's,1608,1800,g' feeds/luci/applications/luci-app-cpufreq/root/etc/uci-defaults/10-cpufreq
sed -i 's,2016,2208,g' feeds/luci/applications/luci-app-cpufreq/root/etc/uci-defaults/10-cpufreq
sed -i 's,1512,1608,g' feeds/luci/applications/luci-app-cpufreq/root/etc/uci-defaults/10-cpufreq


