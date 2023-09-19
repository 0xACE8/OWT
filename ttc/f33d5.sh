rm -rf feeds.conf.default
wget --no-check-certificate -O feeds.conf.default "https://raw.githubusercontent.com/0xACE8/OWT/main/ttc/feeds.conf.default"
#sed -i '/packages/d' feeds.conf.default
#sed -i '/luci/d' feeds.conf.default
#sed -i '/routing/d' feeds.conf.default
#sed -i '/telephony/d' feeds.conf.default
#sed -i '$a src-git ace https://github.com/0xACE8/4c3-p4ck463' feeds.conf.default
#sed -i '$a src-git passwall_packages https://github.com/xiaorouji/openwrt-passwall-packages.git;main' feeds.conf.default
#sed -i '$a src-git packages https://github.com/padavanonly/packages.git;openwrt-18.06' feeds.conf.default
#sed -i '$a src-git luci https://github.com/padavanonly/luci.git;openwrt-18.06-k5.4' feeds.conf.default
#sed -i '$a src-git routing https://github.com/openwrt/routing.git' feeds.conf.default
#sed -i '$a src-git telephony https://github.com/openwrt/telephony.git' feeds.conf.default
#sed -i '$a src-git passwall https://github.com/xiaorouji/openwrt-passwall.git;main' feeds.conf.default
#sed -i '$a src-git passwall2 https://github.com/xiaorouji/openwrt-passwall2.git;main' feeds.conf.default
#cat feeds.conf.default
#sleep 2
