#!/bin/bash
#=================================================
# Description: DIY script
# Lisence: MIT
# Author: 0xACE7
#=================================================
# Modify default IP
sed -i 's/192.168.1.1/192.168.177.1/g' package/base-files/files/bin/config_generate
sed -i "s/ip6assign='60'/ip6assign='64'/g" package/base-files/files/bin/config_generate
sed -i "s/globals.ula_prefix='auto'/packet_steering='1'/g" package/base-files/files/bin/config_generate
sed -i 's/2:-dhcp/2:-pppoe/g' package/base-files/files/lib/functions/uci-defaults.sh
sed -i "s|DISTRIB_REVISION='%R'|DISTRIB_REVISION='R$(date +%Y.%m.%d)'|g" package/base-files/files/etc/openwrt_release
echo "DISTRIB_SOURCECODE='openwrt'" >>package/base-files/files/etc/openwrt_release

# Modify Hostname
sed -i 's/ImmortalWrt/Xiaomi_MI_R3G/g' package/base-files/files/bin/config_generate

# Modify Password to ********
sed -i 's/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.:0:0:99999:7:::/root:$1$4xKZB45Q$w0CPT5M6vBWbYNmSWuxfU.:19007:0:99999:7:::/g' package/emortal/default-settings/files/99-default-settings

# Change language=auto to zh_cn
sed -i 's/lang=auto/lang=zh_cn/g' package/emortal/default-settings/files/99-default-settings

# Boost UDP
echo '# optimize udp' >>package/base-files/files/etc/sysctl.d/10-default.conf
echo 'net.core.rmem_max=26214400' >>package/base-files/files/etc/sysctl.d/10-default.conf
echo 'net.core.rmem_default=26214400' >>package/base-files/files/etc/sysctl.d/10-default.conf
echo 'net.core.wmem_max=26214400' >>package/base-files/files/etc/sysctl.d/10-default.conf
echo 'net.core.wmem_default=26214400' >>package/base-files/files/etc/sysctl.d/10-default.conf
echo 'net.core.netdev_max_backlog=2048' >>package/base-files/files/etc/sysctl.d/10-default.conf

# Modify Ntp server
sed -i 's/ntp.tencent.com/ntp.tuna.tsinghua.edu.cn/g' package/emortal/default-settings/files/99-default-settings-chinese
sed -i 's/ntp1.aliyun.com/cn.ntp.org.cn/g' package/emortal/default-settings/files/99-default-settings-chinese
sed -i 's/ntp.tencent.com/edu.ntp.org.cn/g' package/emortal/default-settings/files/99-default-settings-chinese
sed -i 's/ntp.tencent.com/ntp.ntsc.ac.cn/g' package/emortal/default-settings/files/99-default-settings-chinese

# Change luci list name
#sed -i 's/"Design 主题设置"/"主题设置"/g' feeds/ace/luci-app-design-config/po/zh-cn/design-config.po
sed -i 's/"Turbo ACC 网络加速"/"网络加速"/g' feeds/luci/applications/luci-app-turboacc/po/zh-cn/turboacc.po

# Add Dashboard
#wget -O package/luci-mod-dashboard https://github.com/immortalwrt/luci/tree/openwrt-21.02/modules/luci-mod-dashboard

# Change to my banner
sudo rm package/emortal/default-settings/files/openwrt_banner
wget https://raw.githubusercontent.com/0xACE8/OWT/main/reg/banner -O package/emortal/default-settings/files/openwrt_banner

# Fix Mwan3 ipv4 and ipv6 issue
sed -i 's/"ip6tables -t mangle -w"/"\/bin\/true"/g' feeds/packages/net/mwan3/files/lib/mwan3/mwan3.sh
sed -i 's/"iptables -t mangle -w"/"\/bin\/true"/g' feeds/packages/net/mwan3/files/lib/mwan3/mwan3.sh
#rm -rf feeds/luci/applications/luci-app-mwan3
#git clone https://github.com/0xACE8/luci-app-mwan3 feeds/luci/applications/luci-app-mwan3
#rm -rf feeds/packages/net/mwan3
#git clone https://github.com/0xACE8/mwan3 feeds/packages/net/mwan3

# Replace with new version syncdial
#rm -rf feeds/luci/applications/luci-app-syncdial
#git clone https://github.com/0xACE8/luci-app-syncdial feeds/luci/applications/luci-app-syncdial

# App Patch
git clone https://github.com/sirpdboy/luci-app-autotimeset package/luci-app-autotimeset
git clone https://github.com/sirpdboy/luci-app-advanced package/luci-app-advanced
sed -i 's,"control","system",g' package/luci-app-autotimeset/luasrc/controller/autotimeset.lua
sed -i '/firstchild/d' package/luci-app-autotimeset/luasrc/controller/autotimeset.lua
sed -i 's/control]/system]/g' package/luci-app-autotimeset/luasrc/view/autotimeset/log.htm

# Samba4 Patch
sed -i 's/\"nas\"/\"services\"/g' feeds/luci/applications/luci-app-samba4/luasrc/controller/samba4.lua

# Argone upgraded to Xiaomi theme
git clone https://github.com/kenzok78/luci-theme-argone.git package/luci-theme-argone
git clone https://github.com/kenzok78/luci-app-argone-config.git package/luci-app-argone-config

sed -i 's/"Argone 主题设置"/"主题设置"/g' package/luci-app-argone-config/po/zh-cn/argone-config.po
sed -i 's/5e72e4/ff6900/g' package/luci-app-argone-config/root/etc/config/argone
sed -i 's/483d8b/ff6900/g' package/luci-app-argone-config/root/etc/config/argone
sed -i 's/normal/light/g' package/luci-app-argone-config/root/etc/config/argone
sed -i 's/5e72e4/ff6900/g' package/luci-theme-argone/htdocs/luci-static/argone/css/cascade.css
sed -i 's/5e72e4/ff6900/g' package/luci-theme-argone/htdocs/luci-static/argone/less/cascade.less
sed -i 's/483d8b/ff6900/g' package/luci-theme-argone/htdocs/luci-static/argone/css/cascade.css
sed -i 's/483d8b/ff6900/g' package/luci-theme-argone/htdocs/luci-static/argone/less/cascade.less
#sed -i 's/fb6340/d43f3a/g' package/luci-theme-argone/htdocs/luci-static/argone/css/cascade.css
#sed -i 's/fb6340/d43f3a/g' package/luci-theme-argone/htdocs/luci-static/argone/less/cascade.less
rm -rf package/luci-app-argone/htdocs/luci-static/argone/favicon.ico
wget --no-check-certificate -O package/luci-theme-argone/htdocs/luci-static/argone/favicon.ico "https://raw.githubusercontent.com/0xACE8/OWT/main/reg/argone/favicon.ico"
rm -rf package/luci-theme-argone/htdocs/luci-static/argone/img/argone.svg
wget --no-check-certificate -O package/luci-theme-argone/htdocs/luci-static/argone/img/argone.svg "https://raw.githubusercontent.com/0xACE8/OWT/main/reg/argone/img/argone.svg"
rm -rf package/luci-theme-argone/htdocs/luci-static/argone/img/bg1.jpg
wget --no-check-certificate -O package/luci-theme-argone/htdocs/luci-static/argone/img/bg1.jpg "https://raw.githubusercontent.com/0xACE8/OWT/main/reg/argone/img/bg1.jpg"
rm -rf package/luci-theme-argone/htdocs/luci-static/argone/icon/*.png
wget --no-check-certificate -O package/luci-theme-argone/htdocs/luci-static/argone/icon/android-icon-192x192.png "https://raw.githubusercontent.com/0xACE8/OWT/main/reg/argone/icon/android-icon-192x192.png"
wget --no-check-certificate -O package/luci-theme-argone/htdocs/luci-static/argone/icon/apple-icon-60x60.png "https://raw.githubusercontent.com/0xACE8/OWT/main/reg/argone/icon/apple-icon-60x60.png"
wget --no-check-certificate -O package/luci-theme-argone/htdocs/luci-static/argone/icon/apple-icon-72x72.png "https://raw.githubusercontent.com/0xACE8/OWT/main/reg/argone/icon/apple-icon-72x72.png"
wget --no-check-certificate -O package/luci-theme-argone/htdocs/luci-static/argone/icon/apple-icon-144x144.png "https://raw.githubusercontent.com/0xACE8/OWT/main/reg/argone/icon/apple-icon-144x144.png"
wget --no-check-certificate -O package/luci-theme-argone/htdocs/luci-static/argone/icon/favicon-16x16.png "https://raw.githubusercontent.com/0xACE8/OWT/main/reg/argone/icon/favicon-16x16.png"
wget --no-check-certificate -O package/luci-theme-argone/htdocs/luci-static/argone/icon/favicon-32x32.png "https://raw.githubusercontent.com/0xACE8/OWT/main/reg/argone/icon/favicon-32x32.png"
wget --no-check-certificate -O package/luci-theme-argone/htdocs/luci-static/argone/icon/favicon-96x96.png "https://raw.githubusercontent.com/0xACE8/OWT/main/reg/argone/icon/favicon-96x96.png"
wget --no-check-certificate -O package/luci-theme-argone/htdocs/luci-static/argone/icon/ms-icon-144x144.png "https://raw.githubusercontent.com/0xACE8/OWT/main/reg/argone/icon/ms-icon-144x144.png"

# Upgrade hysteria to 1.3.5
#cp feeds/passwall/hysteria/Makefile feeds/packages/net/hysteria/Makefile

# Change wifi ssid: Fuck_Xiaomi
#sed -i 's/ssid=OpenWrt/ssid=CMCC-702/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
#sed -i 's/encryption=none/encryption=psk2/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
#sed -i '/encryption/a\set wireless.default_radio${devidx}.key=_password_' package/kernel/mac80211/files/lib/wifi/mac80211.sh

echo "diy-part2.sh is done."
