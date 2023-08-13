#!/bin/bash
#=================================================
# Description: DIY script
# Lisence: MIT
# Author: 0xACE7
#=================================================
# Modify default IP
sed -i 's/192.168.1.1/192.168.177.78/g' package/base-files/files/bin/config_generate

# Modify Hostname
sed -i 's/ImmortalWrt/Openwrt_Bypass/g' package/base-files/files/bin/config_generate

# Password is ********
#sed -i 's/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.:0:0:99999:7:::/root:$1$4xKZB45Q$w0CPT5M6vBWbYNmSWuxfU.:19007:0:99999:7:::/g' package/emortal/default-settings/files/99-default-settings

# Modify builder
#sed -i "s/OpenWrt /0xACE7 build $(TZ=UTC-3 date "+%Y.%m.%d") @ OpenWrt /g" package/lean/default-settings/files/zzz-default-settings

# Change language=auto to zh_cn
sed -i 's/lang="auto"/lang="zh_cn"/g' package/emortal/default-settings/files/99-default-settings

# Time Zone to LA
sed -i 'CST-8/CST-4/g' package/emortal/default-settings/files/99-default-settings-chinese
sed -i '"Asia/Shanghai"/"America/Los_Angeles"/g' package/emortal/default-settings/files/99-default-settings-chinese

#7. Modify Ntp server
sed -i 's/ntp.tencent.com/edu.ntp.org.cn/g' package/emortal/default-settings/files/99-default-settings-chinese
sed -i 's/ntp1.aliyun.com/time.apple.com/g' package/emortal/default-settings/files/99-default-settings-chinese
#sed -i 's/ntp.ntsc.ac.cn/edu.ntp.org.cn/g' package/emortal/default-settings/files/99-default-settings-chinese
#sed -i 's/ntp.tencent.com/ntp.ntsc.ac.cn/g' package/emortal/default-settings/files/99-default-settings-chinese

# Change luci list name
sed -i 's/"Argon 主题设置"/"主题设置"/g' feeds/luci/applications/luci-app-argon-config/po/zh_Hans/argon-config.po
sed -i 's/"#5e72e4"/"#6600cc"/g' feeds/luci/themes/luci-theme-argon/htdocs/luci-static/argon/css/cascade.css
sed -i 's/"#483d8b"/"#f9a602"/g' feeds/luci/themes/luci-theme-argon/htdocs/luci-static/argon/css/cascade.css
#sed -i 's/"Turbo ACC 网络加速"/"网络加速"/g' feeds/luci/applications/luci-app-turboacc/po/zh-cn/turboacc.po

# Change dns server
#sed -i "2i # network config" package/lean/default-settings/files/zzz-default-settings
#sed -i "3i uci set network.lan.dns='127.0.0.1'"  package/lean/default-settings/files/zzz-default-settings
#sed -i "4i uci set network.lan.delegate='0'" package/lean/default-settings/files/zzz-default-settings
#sed -i "5i uci set network.lan.gateway='192.168.177.1'" package/lean/default-settings/files/zzz-default-settings
#sed -i "6i # ipv6 network config" package/lean/default-settings/files/zzz-default-settings
#sed -i "7i uci set network.lan6='interface'" package/lean/default-settings/files/zzz-default-settings
#sed -i "8i uci set network.lan6.proto='dhcpv6'" package/lean/default-settings/files/zzz-default-settings
#sed -i "9i uci set network.lan6.ifname='eth0'" package/lean/default-settings/files/zzz-default-settings
#sed -i "10i uci set network.lan6.delegate='0'" package/lean/default-settings/files/zzz-default-settings
#sed -i "11i uci set network.lan6.reqaddress='try'" package/lean/default-settings/files/zzz-default-settings
#sed -i "12i uci set network.lan6.reqprefix='auto'" package/lean/default-settings/files/zzz-default-settings
#sed -i "13i uci set network.lan6.peerdns='0'" package/lean/default-settings/files/zzz-default-settings
#sed -i "14i uci set network.lan6.dns='::1'" package/lean/default-settings/files/zzz-default-settings
#sed -i '/revert_dns/d' feeds/luci/applications/luci-app-turboacc/root/etc/init.d/turboacc

# Boost UDP
echo '# optimize udp' >>package/base-files/files/etc/sysctl.d/10-default.conf
echo 'net.core.rmem_max=26214400' >>package/base-files/files/etc/sysctl.d/10-default.conf
echo 'net.core.rmem_default=26214400' >>package/base-files/files/etc/sysctl.d/10-default.conf
echo 'net.core.wmem_max=26214400' >>package/base-files/files/etc/sysctl.d/10-default.conf
echo 'net.core.wmem_default=26214400' >>package/base-files/files/etc/sysctl.d/10-default.conf
echo 'net.core.netdev_max_backlog=2048' >>package/base-files/files/etc/sysctl.d/10-default.conf

# Update kcptun
#rm -rf feeds/packages/net/kcptun
#git clone https://github.com/0xACE8/kcptun.git feeds/packages/net/kcptun

# Update udpspeeder
#rm -rf feeds/packages/net/udpspeeder
#git clone https://github.com/0xACE8/udpspeeder.git feeds/packages/net/udpspeeder

# Update dnscrypt-proxy2
#rm -rf feeds/packages/net/dnscrypt-proxy2
#git clone https://github.com/0xACE8/dnscrypt-proxy2.git feeds/packages/net/dnscrypt-proxy2

# Change to my banner
sudo rm package/base-files/files/etc/banner
wget https://raw.githubusercontent.com/0xACE8/OWT/main/x6u/banner -O package/base-files/files/etc/banner
