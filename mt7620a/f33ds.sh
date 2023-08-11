# Add a feed source
#echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
#echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default
#echo 'src-git ace https://github.com/0xACE8/ace-packages' >>feeds.conf.default
#echo 'src-git roacn https://github.com/roacn/openwrt-packages' >>feeds.conf.default

# Add COMFAST CF-812AC (rtl8812bu) 
#git clone https://github.com/0xACE8/rtl8812bu.git package/kernel/rtl8812bu

sed -i '$a src-git passwall2 https://github.com/xiaorouji/openwrt-passwall2' feeds.conf.default
sed -i '$a src-git kenzo https://github.com/kenzok8/openwrt-packages' feeds.conf.default
sed -i '$a src-git small https://github.com/kenzok8/small' feeds.conf.default
sed -i '$a src-git ace https://github.com/0xACE8/ace-packages' feeds.conf.default
sed -i '$a src-git sirpdboy https://github.com/sirpdboy/netspeedtest' feeds.conf.default
