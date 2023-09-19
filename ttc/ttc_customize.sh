#!/bin/bash
#=================================================
# Description: DIY script
# Lisence: MIT
# Author: 0xACE7
#=================================================
# Modify default IP
sed -i 's/192.168.1.1/192.168.50.68/g' package/base-files/files/bin/config_generate
sed -i "/ip6assign='60'/d" package/base-files/files/bin/config_generate
sed -i "s/globals.ula_prefix='auto'/packet_steering='1'/g" package/base-files/files/bin/config_generate

# Modify Hostname
sed -i 's/ImmortalWrt/Thunder TimeCloud/g' package/base-files/files/bin/config_generate 


#
rm -rf package/emortal/default-settings/files/99-default-settings-chinese
wget --no-check-certificate -O package/emortal/default-settings/files/99-default-settings-chinese "https://raw.githubusercontent.com/0xACE8/OWT/main/ttc/99-default-settings-chinese"

# Modify Password to emtry
sed -i '/root::0:0:99999:7:::/d' package/emortal/default-settings/files/99-default-settings

# Change language=auto to zh_cn
sed -i 's/lang=auto/lang=zh_cn/g' package/emortal/default-settings/files/99-default-settings

# Boost UDP
echo '# optimize udp' >>package/base-files/files/etc/sysctl.d/10-default.conf
echo 'net.core.rmem_max=26214400' >>package/base-files/files/etc/sysctl.d/10-default.conf
echo 'net.core.rmem_default=26214400' >>package/base-files/files/etc/sysctl.d/10-default.conf
echo 'net.core.wmem_max=26214400' >>package/base-files/files/etc/sysctl.d/10-default.conf
echo 'net.core.wmem_default=26214400' >>package/base-files/files/etc/sysctl.d/10-default.conf
echo 'net.core.netdev_max_backlog=2048' >>package/base-files/files/etc/sysctl.d/10-default.conf

# Change luci list name
sed -i 's/"Argone 主题设置"/"主题设置"/g' feeds/ace/luci-app-argone-config/po/zh-cn/argone-config.po
#sed -i 's/"Turbo ACC 网络加速"/"网络加速"/g' feeds/luci/applications/luci-app-turboacc/po/zh-cn/turboacc.po

#
#sed -i 's/5279eb1cb7555cf9292423cc9f672dc43e6e214b3411a6df26a6a1cfa59d88b7/73a2498dc95934c225d358707e7f7d060b5ce81aa45260ada09cbd15207d27d1/g' feeds/passwall_packages/ipt2socks/Makefile

# Change to my banner
#sudo rm package/emortal/default-settings/files/openwrt_banner
#wget https://raw.githubusercontent.com/0xACE8/OWT/main/reg/banner -O package/emortal/default-settings/files/openwrt_banner

# Fix Mwan3 ipv4 and ipv6 issue
#sed -i 's/"ip6tables -t mangle -w"/"\/bin\/true"/g' feeds/packages/net/mwan3/files/lib/mwan3/mwan3.sh
#sed -i 's/"iptables -t mangle -w"/"\/bin\/true"/g' feeds/packages/net/mwan3/files/lib/mwan3/mwan3.sh
#rm -rf feeds/luci/applications/luci-app-mwan3
#git clone https://github.com/0xACE8/luci-app-mwan3 feeds/luci/applications/luci-app-mwan3
#rm -rf feeds/packages/net/mwan3
#git clone https://github.com/0xACE8/mwan3 feeds/packages/net/mwan3

# Replace with new version syncdial
#rm -rf feeds/luci/applications/luci-app-syncdial
#git clone https://github.com/0xACE8/luci-app-syncdial feeds/luci/applications/luci-app-syncdial

# App Patch
#git clone https://github.com/sirpdboy/luci-app-autotimeset package/luci-app-autotimeset
#git clone https://github.com/sirpdboy/luci-app-advanced package/luci-app-advanced
#sed -i 's,"control","system",g' package/luci-app-autotimeset/luasrc/controller/autotimeset.lua
#sed -i '/firstchild/d' package/luci-app-autotimeset/luasrc/controller/autotimeset.lua
#sed -i 's/control]/system]/g' package/luci-app-autotimeset/luasrc/view/autotimeset/log.htm

# Samba4 Patch
#sed -i 's/\"nas\"/\"services\"/g' feeds/luci/applications/luci-app-samba4/luasrc/controller/samba4.lua

# Rollback hysteria v2 to hysteria v1.3.5
#rm -rf feeds/small/hysteria
#git clone https://github.com/0xACE8/hysteria feeds/small/hysteria

# Change wifi ssid: Fuck_Xiaomi
#sed -i 's/ssid=OpenWrt/ssid=CMCC-702/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
#sed -i 's/encryption=none/encryption=psk2/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
#sed -i '/encryption/a\set wireless.default_radio${devidx}.key=_password_' package/kernel/mac80211/files/lib/wifi/mac80211.sh

echo "diy-part2.sh is done."
