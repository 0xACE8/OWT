#!/bin/bash
#=================================================
# Description: DIY script
# Lisence: MIT
# Author: 0xACE7
#=================================================
#1. Modify default IP
sed -i 's/192.168.1.1/192.168.177.80/g' package/base-files/files/bin/config_generate

#2. Modify Hostname
sed -i '/uci commit system/i\uci set system.@system[0].hostname='Bypass.Router'' package/lean/default-settings/files/zzz-default-settings

#3. Password is ********
sed -i 's/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.:0:0:99999:7:::/root:$1$4xKZB45Q$w0CPT5M6vBWbYNmSWuxfU.:19007:0:99999:7:::/g' package/lean/default-settings/files/zzz-default-settings

#4. Modify builder
sed -i "s/OpenWrt /0xACE7 build $(TZ=UTC-3 date "+%Y.%m.%d") @ OpenWrt /g" package/lean/default-settings/files/zzz-default-settings

#5. Change luci list name
sed -i 's/"Argone 主题设置"/"主题设置"/g' feeds/ace/luci-app-argone-config/po/zh-cn/argone-config.po
sed -i 's/"#5e72e4"/"#6600cc"/g' feeds/ace/luci-theme-argone/htdocs/luci-static/argone/css/cascade.css
sed -i 's/"#483d8b"/"#f9a602"/g' feeds/ace/luci-theme-argone/htdocs/luci-static/argone/css/cascade.css
sed -i 's/5e72e4/6600cc/g' feeds/kenzo/luci-app-argone-config/root/etc/config/argone
sed -i 's/483d8b/f9a602/g' feeds/kenzo/luci-app-argone-config/root/etc/config/argone
sed -i '/\t\trevert_dns/d' feeds/luci/applications/luci-app-turboacc/root/etc/init.d/turboacc
sed -i 's/"Turbo ACC 网络加速"/"网络加速"/g' feeds/luci/applications/luci-app-turboacc/po/zh-cn/turboacc.po

# Modify firewall
sed -i '/xiaomi.cn/d' package/lean/default-settings/files/zzz-default-settings
sed -i 's/#echo/echo/g' package/lean/default-settings/files/zzz-default-settings
sed -i "45 i\echo 'iptables -t nat -I POSTROUTING -o eth0 -j MASQUERADE' >> /etc/firewall.user" package/lean/default-settings/files/zzz-default-settings
sed -i "46 i\echo 'ip6tables -t nat -I POSTROUTING -o eth0 -j MASQUERADE' >> /etc/firewall.user" package/lean/default-settings/files/zzz-default-settings

# Boost UDP
echo '# optimize udp' >>package/base-files/files/etc/sysctl.d/10-default.conf
echo 'net.core.rmem_max=26214400' >>package/base-files/files/etc/sysctl.d/10-default.conf
echo 'net.core.rmem_default=26214400' >>package/base-files/files/etc/sysctl.d/10-default.conf
echo 'net.core.wmem_max=26214400' >>package/base-files/files/etc/sysctl.d/10-default.conf
echo 'net.core.wmem_default=26214400' >>package/base-files/files/etc/sysctl.d/10-default.conf
echo 'net.core.netdev_max_backlog=2048' >>package/base-files/files/etc/sysctl.d/10-default.conf

# add dns list
mkdir -p package/base-files/files/etc/dnsmasq.d
wget --no-check-certificate -O package/base-files/files/etc/dnsmasq.d/accelerated-domains.china.conf "https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/accelerated-domains.china.conf"

# Change to my banner
sudo rm package/base-files/files/etc/banner
wget https://raw.githubusercontent.com/0xACE8/OWT/main/x6u/banner -O package/base-files/files/etc/banner

# upgrade config
wget --no-check-certificate https://raw.githubusercontent.com/0xACE8/OWT/main/70c/99-init-settings -O package/base-files/files/etc/uci-defaults/99-init-settings


echo "Done!"
