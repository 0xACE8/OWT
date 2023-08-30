#!/bin/bash
#=================================================
# Description: DIY script
# Lisence: MIT
# Author: 0xACE7
#=================================================
# Modify default IP
sed -i 's/192.168.1.1/192.168.177.80/g' package/base-files/files/bin/config_generate

# Set etc/openwrt_release
sed -i 's/ImmortalWrt/Bypass_Router/g' package/base-files/files/bin/config_generate
sed -i "s|DISTRIB_REVISION='%R'|DISTRIB_REVISION='R$(date +%Y.%m.%d)'|g" package/base-files/files/etc/openwrt_release
echo "DISTRIB_SOURCECODE='openwrt'" >>package/base-files/files/etc/openwrt_release
sed -i 's/ImmortalWrt/OpenWrt/g' include/version.mk
#sed -i 's/ImmortalWrt/OpenWrt/g' config/Config-images.in
#sed -i 's/ImmortalWrt/OpenWrt/g' package/base-files/image-config.in
#sed -i "s/OpenWrt /0xACE7 build $(TZ=UTC-3 date "+%Y.%m.%d") @ OpenWrt /g" package/lean/default-settings/files/zzz-default-settings

# Password is ********
sed -i "s/root::0:0:99999:7:::/root:$1$4xKZB45Q$w0CPT5M6vBWbYNmSWuxfU.:19007:0:99999:7:::/g" package/base-files/files/etc/shadow

# Change language=auto to zh_cn
sed -i 's/lang="auto"/lang="zh_cn"/g' package/emortal/default-settings/files/99-default-settings

# interface
# lan && lan6
sed -i "175 i\ \t\t\t\tset network.\$1\.gateway='192.168.177.1'" package/base-files/files/bin/config_generate
sed -i "s/globals.ula_prefix='auto'/packet_steering='1'/g" package/base-files/files/bin/config_generate
sed -i "/ip6assign='60'/d" package/base-files/files/bin/config_generate
sed -i "9 i\uci set network.lan6=interface\nuci set network.lan6.proto='dhcpv6'\nuci set network.lan6.force_link='1'\nuci set network.lan6.reqaddress='try'\nuci set network.lan6.reqprefix='auto'\nuci set network.lan6.device='@lan'\nuci commit network\n" package/emortal/default-settings/files/99-default-settings
# firewall
sed -i "17 i\ \tlist network\t\t'lan6'" package/network/config/firewall/files/firewall.config
#sed -i "s/ \t/\t/g" package/network/config/firewall/files/firewall.config
# dhcp
#sed -i "s/ \t/\t/g" package/network/services/dnsmasq/files/dhcp.conf

# Time Zone to LA
sed -i 's/CST-8/CST-4/g' package/emortal/default-settings/files/99-default-settings-chinese
sed -i 's/"Asia\/Shanghai"/"America\/Los_Angeles"/g' package/emortal/default-settings/files/99-default-settings-chinese

# Modify Ntp server
sed -i 's/ntp.tencent.com/ntp.tuna.tsinghua.edu.cn/g' package/emortal/default-settings/files/99-default-settings-chinese
sed -i 's/ntp1.aliyun.com/cn.ntp.org.cn/g' package/emortal/default-settings/files/99-default-settings-chinese
sed -i 's/ntp.tencent.com/edu.ntp.org.cn/g' package/emortal/default-settings/files/99-default-settings-chinese
sed -i 's/ntp.tencent.com/ntp.ntsc.ac.cn/g' package/emortal/default-settings/files/99-default-settings-chinese

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
git clone https://github.com/sirpdboy/luci-app-advanced package/luci-app-advanced
rm -rf feeds/packages/net/kcptun
git clone https://github.com/0xACE8/kcptun.git feeds/packages/net/kcptun
rm -rf feeds/luci/applications/luci-app-kcptun 
git clone https://github.com/0xACE8/luci-app-kcptun feeds/luci/applications/luci-app-kcptun
rm -rf feeds/packages/net/udp2raw
git clone https://github.com/0xACE8/udp2raw.git feeds/packages/net/udp2raw
rm -rf feeds/luci/applications/luci-app-udp2raw
git clone https://github.com/0xACE8/luci-app-udp2raw feeds/luci/applications/luci-app-udp2raw
rm -rf feeds/ace8/luci-app-udpspeeder
git clone https://github.com/0xACE8/luci-app-udpspeeder feeds/ace8/luci-app-udpspeeder

# Update dnscrypt-proxy2
#rm -rf feeds/packages/net/dnscrypt-proxy2
#git clone https://github.com/0xACE8/dnscrypt-proxy2.git feeds/packages/net/dnscrypt-proxy2
sed -i 's/127.0.0.53:53/127.0.0.1:5335/g' feeds/packages/net/dnscrypt-proxy2/Makefile
sed -i '59 i\ \tsed -i "s\/ipv6_servers = false\/ipv6_servers = true\/g" \$(1)\/etc\/dnscrypt-proxy2\/dnscrypt-proxy.toml' feeds/packages/net/dnscrypt-proxy2/Makefile
sed -i '60 i\ \tsed -i "s\/odoh_servers = false\/odoh_servers = true\/g" \$(1)\/etc\/dnscrypt-proxy2\/dnscrypt-proxy.toml' feeds/packages/net/dnscrypt-proxy2/Makefile
sed -i '61 i\ \tsed -i "s\/http3 = false\/http3 = true\/g" \$(1)\/etc\/dnscrypt-proxy2\/dnscrypt-proxy.toml' feeds/packages/net/dnscrypt-proxy2/Makefile
sed -i '62 i\ \tsed -i "s\/cache_size = 4096\/cache_size = 10240\/g" \$(1)\/etc\/dnscrypt-proxy2\/dnscrypt-proxy.toml' feeds/packages/net/dnscrypt-proxy2/Makefile
#sed -i '63 i\ \tsed -i "s/# proxy/proxy/g" $(1)/etc/dnscrypt-proxy2/dnscrypt-proxy.toml' feeds/packages/net/dnscrypt-proxy2/Makefile
#sed -i '64 i\ \tsed -i "s/127.0.0.1:9050/127.0.0.1:1070/g" $(1)/etc/dnscrypt-proxy2/dnscrypt-proxy.toml' feeds/packages/net/dnscrypt-proxy2/Makefile
sed -i '65 i\ \tsed -i "s/# blocked_names_file/blocked_names_file/g" $(1)/etc/dnscrypt-proxy2/dnscrypt-proxy.toml' feeds/packages/net/dnscrypt-proxy2/Makefile

# Change to my banner
sudo rm package/base-files/files/etc/banner
wget https://raw.githubusercontent.com/0xACE8/OWT/main/x6u/banner -O package/base-files/files/etc/banner

echo "diy-part2.sh is done."
