#!/bin/bash
#=================================================
# Description: DIY script
# Lisence: MIT
# Author: 0xACE7
#=================================================
# Modify default IP
sed -i 's/192.168.1.1/192.168.177.78/g' package/base-files/files/bin/config_generate

# Set etc/openwrt_release
sed -i 's/ImmortalWrt/Openwrt_Bypass/g' package/base-files/files/bin/config_generate
sed -i "s|DISTRIB_REVISION='%R'|DISTRIB_REVISION='R$(date +%Y.%m.%d)'|g" package/base-files/files/etc/openwrt_release
echo "DISTRIB_SOURCECODE='openwrt'" >>package/base-files/files/etc/openwrt_release
sed -i 's/ImmortalWrt/OpenWrt/g' include/version.mk
sed -i 's/ImmortalWrt/OpenWrt/g' config/Config-images.in
sed -i 's/ImmortalWrt/OpenWrt/g' package/base-files/image-config.in
#sed -i "s/OpenWrt /0xACE7 build $(TZ=UTC-3 date "+%Y.%m.%d") @ OpenWrt /g" package/lean/default-settings/files/zzz-default-settings

# Password is ********
sed -i "s/root::0:0:99999:7:::/root:$1$4xKZB45Q$w0CPT5M6vBWbYNmSWuxfU.:19007:0:99999:7:::/g" package/base-files/files/etc/shadow

# Change language=auto to zh_cn
sed -i 's/lang="auto"/lang="zh_cn"/g' package/emortal/default-settings/files/99-default-settings

# interface
sed -i "s/globals.ula_prefix='auto'/packet_steering='1'/g" package/base-files/files/bin/config_generate
sed -i "/ip6assign='60'/d" package/base-files/files/bin/config_generate
sed -i "9 i\uci set network.lan6=interface\nuci set network.lan6.proto='dhcpv6'\nuci set network.lan6.force_link='1'\nuci set network.lan6.reqaddress='try'\nuci set network.lan6.reqprefix='auto'\nuci set network.lan6.device='@lan'\nuci commit network\n" package/emortal/default-settings/files/99-default-settings

# Time Zone to LA
sed -i 's/CST-8/CST-4/g' package/emortal/default-settings/files/99-default-settings-chinese
sed -i 's/"Asia\/Shanghai"/"America\/Los_Angeles"/g' package/emortal/default-settings/files/99-default-settings-chinese

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
#sed -i '/revert_dns/d' feeds/luci/applications/luci-app-turboacc/root/etc/init.d/turboacc

# Boost UDP
echo '# optimize udp' >>package/base-files/files/etc/sysctl.d/10-default.conf
echo 'net.core.rmem_max=26214400' >>package/base-files/files/etc/sysctl.d/10-default.conf
echo 'net.core.rmem_default=26214400' >>package/base-files/files/etc/sysctl.d/10-default.conf
echo 'net.core.wmem_max=26214400' >>package/base-files/files/etc/sysctl.d/10-default.conf
echo 'net.core.wmem_default=26214400' >>package/base-files/files/etc/sysctl.d/10-default.conf
echo 'net.core.netdev_max_backlog=2048' >>package/base-files/files/etc/sysctl.d/10-default.conf

# update gamespeeder
#rm -rf feeds/packages/lang/golang
#git clone https://github.com/0xACE8/golang.git feeds/packages/lang/golang

rm -rf feeds/packages/net/kcptun
git clone https://github.com/0xACE8/kcptun.git feeds/packages/net/kcptun

rm -rf feeds/luci/applications/luci-app-kcptun 
git clone https://github.com/0xACE8/luci-app-kcptun feeds/luci/applications/luci-app-kcptun

rm -rf feeds/packages/net/udp2raw
git clone https://github.com/0xACE8/udp2raw.git feeds/packages/net/udp2raw

rm -rf feeds/luci/applications/luci-app-udp2raw
git clone https://github.com/0xACE8/luci-app-udp2raw feeds/luci/applications/luci-app-udp2raw


# Update dnscrypt-proxy2
#rm -rf feeds/packages/net/dnscrypt-proxy2
#git clone https://github.com/0xACE8/dnscrypt-proxy2.git feeds/packages/net/dnscrypt-proxy2

# Change to my banner
sudo rm package/base-files/files/etc/banner
wget https://raw.githubusercontent.com/0xACE8/OWT/main/x6u/banner -O package/base-files/files/etc/banner
