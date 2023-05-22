#!/bin/bash
#=================================================
# Description: DIY script
# Lisence: MIT
# Author: 0xACE7
#=================================================
#1. Modify default IP
sed -i 's/192.168.1.1/192.168.177.99/g' package/base-files/files/bin/config_generate

#2. Modify Hostname
sed -i "/uci commit system/i\uci set system.@system[0].hostname='RaspberryPi_3B'" package/lean/default-settings/files/zzz-default-settings

#3. Password is ********
sed -i 's/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.:0:0:99999:7:::/root:$1$4xKZB45Q$w0CPT5M6vBWbYNmSWuxfU.:19007:0:99999:7:::/g' package/lean/default-settings/files/zzz-default-settings

#4. Modify builder
sed -i "s/OpenWrt /0xACE7 build $(TZ=UTC-3 date "+%Y.%m.%d") @ OpenWrt /g" package/lean/default-settings/files/zzz-default-settings

#5. Change luci list name
sed -i 's/"Argonne 主题设置"/"主题设置"/g' feeds/kenzo/luci-app-argone-config/po/zh-cn/argone-config.po
sed -i 's/"Turbo ACC 网络加速"/"网络加速"/g' feeds/luci/applications/luci-app-turboacc/po/zh-cn/turboacc.po

rm -rf feeds/ace/luci-theme-argone/htdocs/luci-static/argone/img/argone.svg
wget --no-check-certificate -O feeds/ace/luci-theme-argone/htdocs/luci-static/argone/img/argone.svg "https://raw.githubusercontent.com/0xACE8/OWT/main/threeb/argone.svg"

sed -i 's/"#5e72e4"/"#bc1142"/g' feeds/kenzo/luci-theme-argone/htdocs/luci-static/argone/css/cascade.css
sed -i 's/"#483d8b"/"#bc1142"/g' feeds/kenzo/luci-theme-argone/htdocs/luci-static/argone/css/cascade.css

#6. Change dns server
sed -i "2i # network config" package/lean/default-settings/files/zzz-default-settings
sed -i "3i uci set network.lan.dns='127.0.0.1'"  package/lean/default-settings/files/zzz-default-settings
sed -i "4i uci set network.lan.delegate='0'" package/lean/default-settings/files/zzz-default-settings
sed -i "5i uci set network.lan.gateway='192.168.177.1'" package/lean/default-settings/files/zzz-default-settings
sed -i "6i # ipv6 network config" package/lean/default-settings/files/zzz-default-settings
sed -i "7i uci set network.lan6='interface'" package/lean/default-settings/files/zzz-default-settings
sed -i "8i uci set network.lan6.proto='dhcpv6'" package/lean/default-settings/files/zzz-default-settings
sed -i "9i uci set network.lan6.ifname='eth0'" package/lean/default-settings/files/zzz-default-settings
sed -i "10i uci set network.lan6.delegate='0'" package/lean/default-settings/files/zzz-default-settings
sed -i "11i uci set network.lan6.reqaddress='try'" package/lean/default-settings/files/zzz-default-settings
sed -i "12i uci set network.lan6.reqprefix='auto'" package/lean/default-settings/files/zzz-default-settings
sed -i "13i uci set network.lan6.peerdns='0'" package/lean/default-settings/files/zzz-default-settings
sed -i "14i uci set network.lan6.dns='::1'" package/lean/default-settings/files/zzz-default-settings
#sed -i '/revert_dns/d' feeds/luci/applications/luci-app-turboacc/root/etc/init.d/turboacc

#6. Boost UDP
echo '# optimize udp' >>package/base-files/files/etc/sysctl.d/10-default.conf
echo 'net.core.rmem_max=26214400' >>package/base-files/files/etc/sysctl.d/10-default.conf
echo 'net.core.rmem_default=26214400' >>package/base-files/files/etc/sysctl.d/10-default.conf
echo 'net.core.wmem_max=26214400' >>package/base-files/files/etc/sysctl.d/10-default.conf
echo 'net.core.wmem_default=26214400' >>package/base-files/files/etc/sysctl.d/10-default.conf
echo 'net.core.netdev_max_backlog=2048' >>package/base-files/files/etc/sysctl.d/10-default.conf

#7. Update kcptun
rm -rf feeds/packages/net/kcptun
git clone https://github.com/0xACE8/kcptun.git feeds/packages/net/kcptun

#8. Update udpspeeder
rm -rf feeds/packages/net/udpspeeder
git clone https://github.com/0xACE8/udpspeeder.git feeds/packages/net/udpspeeder

#9. Update dnscrypt-proxy2
rm -rf feeds/packages/net/dnscrypt-proxy2
git clone https://github.com/0xACE8/dnscrypt-proxy2.git feeds/packages/net/dnscrypt-proxy2

#10. Change to my banner
sudo rm package/base-files/files/etc/banner
wget https://raw.githubusercontent.com/0xACE8/OWT/main/threeb/banner -O package/base-files/files/etc/banner
