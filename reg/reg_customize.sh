#!/bin/bash
#=================================================
# Description: DIY script
# Lisence: MIT
# Author: 0xACE7
#=================================================
#1. Modify default IP
sed -i 's/192.168.1.1/192.168.177.1/g' package/base-files/files/bin/config_generate
sed -i "s/ip6assign='60'/ip6assign='64'/g" package/base-files/files/bin/config_generate
sed -i 's/2:-dhcp/2:-pppoe/g' package/base-files/files/lib/functions/uci-defaults.sh

#2. Modify Hostname
sed -i 's/ImmortalWrt/Xiaomi_R3G/g' package/base-files/files/bin/config_generate

#3. Modify Password to ********
sed -i 's/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.:0:0:99999:7:::/root:$1$4xKZB45Q$w0CPT5M6vBWbYNmSWuxfU.:19007:0:99999:7:::/g' package/emortal/default-settings/files/99-default-settings

#4. Modify builder
sed -i 's/immortalwrt_luci /0xACE7 build $(TZ=UTC-3 date "+%Y.%m.%d") @ OpenWrt /g' /etc/opkg/distfeeds.conf
sed -i '/DISTRIB_RELEAS/d' /etc/openwrt_release
echo "DISTRIB_RELEASE='SNAPSHOT'" >> /etc/openwrt_release
sed -i '/DISTRIB_REVISION/d' /etc/openwrt_release
echo "DISTRIB_REVISION='0xACE7-18.06'" >> /etc/openwrt_release
sed -i '/DISTRIB_DESCRIPTION/d' /etc/openwrt_release
echo "DISTRIB_DESCRIPTION='Xiaomi R3G '" >> /etc/openwrt_release

#5. Change language=auto to zh_cn
sed -i 's/lang=auto/lang=zh_cn/g' package/emortal/default-settings/files/99-default-settings

#6. Boost UDP
echo '# optimize udp' >>package/base-files/files/etc/sysctl.d/10-default.conf
echo 'net.core.rmem_max=26214400' >>package/base-files/files/etc/sysctl.d/10-default.conf
echo 'net.core.rmem_default=26214400' >>package/base-files/files/etc/sysctl.d/10-default.conf
echo 'net.core.wmem_max=26214400' >>package/base-files/files/etc/sysctl.d/10-default.conf
echo 'net.core.wmem_default=26214400' >>package/base-files/files/etc/sysctl.d/10-default.conf
echo 'net.core.netdev_max_backlog=2048' >>package/base-files/files/etc/sysctl.d/10-default.conf

#7. Modify Ntp server
sed -i 's/ntp.tencent.com/ntp.ntsc.ac.cn/g' package/emortal/default-settings/files/99-default-settings-chinese
sed -i 's/ntp1.aliyun.com/cn.ntp.org.cn/g' package/emortal/default-settings/files/99-default-settings-chinese
sed -i 's/ntp.tencent.com/edu.ntp.org.cn/g' package/emortal/default-settings/files/99-default-settings-chinese
sed -i 's/ntp.tencent.com/ntp.ntsc.ac.cn/g' package/emortal/default-settings/files/99-default-settings-chinese

#8. Change luci list name and xiaomi logo color
#sed -i 's/"Design 主题设置"/"主题设置"/g' feeds/ace/luci-app-design-config/po/zh-cn/design-config.po
sed -i 's/"Argonne 主题设置"/"主题设置"/g' feeds/ace/luci-app-argone-config/po/zh-cn/argone-config.po
#sed -i 's/"Turbo ACC 网络加速"/"网络加速"/g' feeds/luci/applications/luci-app-turboacc/po/zh-cn/turboacc.po
sed -i 's/"#5e72e4"/"#ff6900"/g' feeds/ace/luci-theme-argone/htdocs/luci-static/argone/css/cascade.css
sed -i 's/"#483d8b"/"#ff6900"/g' feeds/ace/luci-theme-argone/htdocs/luci-static/argone/css/cascade.css

#9. Change to my banner and argone logo to mi logo
sudo rm package/emortal/default-settings/files/openwrt_banner
wget https://raw.githubusercontent.com/0xACE8/OWT/main/reg/banner -O package/emortal/default-settings/files/openwrt_banner

rm -rf feeds/ace/luci-theme-argone/htdocs/luci-static/argone/img/argone.svg
wget --no-check-certificate -O feeds/ace/luci-theme-argone/htdocs/luci-static/argone/img/argone.svg "https://upload.wikimedia.org/wikipedia/commons/a/ae/Xiaomi_logo_%282021-%29.svg"

#10. Change wifi ssid: Fuck_Xiaomi
#sed -i 's/ssid=OpenWrt/ssid=openwrt/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

#11. Change wifi key: Fuck_Xiaomi
#sed -i 's/encryption=none/encryption=psk2/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
#使用sed 在第四行后添加新字
#sed -e 120a\set wireless.default_radio${devidx}.key=XiaoWanSM package/kernel/mac80211/files/lib/wifi/mac80211.sh
#sed -i '/set wireless.default_radio${devidx}.encryption=psk2/a\set wireless.default_radio${devidx}.key=password' package/kernel/mac80211/files/lib/wifi/mac80211.sh
