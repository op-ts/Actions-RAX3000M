#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# 通过修改diy-part1.sh文件修改feeds.conf.default配置。

# Add a feed source
#sed -i '$a src-git lienol https://github.com/Lienol/openwrt-package' feeds.conf.default
#sed -i '$a src-git Whitecolor https://github.com/Whitestorys/openwrt-extra-packages.git' feeds.conf.default
sed -i '$a src-git kenzo https://github.com/kenzok8/openwrt-packages' feeds.conf.default
sed -i '$a src-git small https://github.com/kenzok8/small-package' feeds.conf.default
# sed -i '$a src-git 281677160 https://github.com/281677160/openwrt-package' feeds.conf.default
# sed -i '$a src-git haiibo https://github.com/haiibo/openwrt-packages' feeds.conf.default
#sed -i '$a src-git ytalm https://github.com/ytalm/my-packages' feeds.conf.default
#sed -i '$a src-git Aibx https://github.com/Aibx/OpenWRT-Packages' feeds.conf.default
#sed -i '$a src-git passwall2 https://github.com/xiaorouji/openwrt-passwall2' feeds.conf.default

#内核版本是会随着源码更新而改变的，在coolsnowwolf/lede的源码查看最好，以X86机型为例，源码的target/linux/x86文件夹可以看到有几个内核版本，x86文件夹里Makefile可以查看源码正在使用内核版本
#修改版本内核（下面两行代码前面有#为源码默认最新5.4内核,没#为4.19内核,默认修改X86的，其他机型L大源码那里target/linux查看，对应修改下面的路径就好）
#sed -i 's/KERNEL_PATCHVER:=5.4/KERNEL_PATCHVER:=4.19/g' ./target/linux/x86/Makefile  #修改内核版本
#sed -i 's/KERNEL_TESTING_PATCHVER:=5.4/KERNEL_TESTING_PATCHVER:=4.19/g' ./target/linux/x86/Makefile  #修改内核版本

#添加自定义插件链接（自己想要什么就github里面搜索然后添加）
# git clone -b 18.06 https://github.com/garypang13/luci-theme-edge.git package/lean/luci-theme-edge  #主题-edge-动态登陆界面
# git clone https://github.com/xiaoqingfengATGH/luci-theme-infinityfreedom.git package/lean/luci-theme-infinityfreedom  #透明主题
# git clone https://github.com/jerrykuku/lua-maxminddb     #git lua-maxminddb 依赖
# git clone https://github.com/jerrykuku/luci-app-vssr
# git clone https://github.com/xiaorouji/openwrt-passwall2  #passwall出国软件

# rm -rf ./package/lean/luci-theme-argon && git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/lean/luci-theme-argon  #新的argon主题
# 全新的[argon-主题]此主题玩法很多,这里看说明【https://github.com/jerrykuku/luci-theme-argon/blob/18.06/README_ZH.md】
# 用WinSCP连接openwrt，在/www/luci-static/argon里面创建background文件夹（如果本身就有background就不需要创建）来存放jpg png gif格式图片可以自定义登陆界面，gif图片为动态登陆界面

# 添加第三方应用
mkdir kiddin9
pushd kiddin9
git clone --depth=1 https://github.com/kiddin9/openwrt-packages .
popd

mkdir Modem-Support
pushd Modem-Support
git clone --depth=1 https://github.com/Siriling/5G-Modem-Support .
popd

mkdir MyConfig
pushd MyConfig
git clone --depth=1 https://github.com/Siriling/OpenWRT-MyConfig .
popd

# mkdir package/community
pushd package

# 系统相关应用
#Poweroff
git clone --depth=1 https://github.com/esirplayground/luci-app-poweroff .
# mkdir luci-app-poweroff
# cp -rf ../kiddin9/luci-app-poweroff/* luci-app-poweroff
#Diskman
rm -rf ../package/feeds/luci/luci-app-diskman
rm -rf ../feeds/luci/applications/luci-app-diskman
mkdir luci-app-diskman
cp -rf ../kiddin9/luci-app-diskman/* luci-app-diskman
#Fileassistant
mkdir luci-app-fileassistant
cp -rf ../kiddin9/luci-app-fileassistant/* luci-app-fileassistant
#Guest-wifi
mkdir luci-app-guest-wifi
cp -rf ../kiddin9/luci-app-guest-wifi/* luci-app-guest-wifi
#Onliner
mkdir luci-app-onliner
cp -rf ../kiddin9/luci-app-onliner/* luci-app-onliner
#Eqos
# mkdir luci-app-eqos
# cp -rf ../kiddin9/luci-app-eqos/* luci-app-eqos
#Wolplus
mkdir luci-app-wolplus
cp -rf ../kiddin9/luci-app-wolplus/* luci-app-wolplus
#WiFischedule
mkdir luci-app-wifischedule
cp -rf ../kiddin9/luci-app-wifischedule/* luci-app-wifischedule
#RAMfree
mkdir luci-app-ramfree
cp -rf ../kiddin9/luci-app-ramfree/* luci-app-ramfree
#ttyd（终端）
# mkdir luci-app-ttyd
# cp -rf ../kiddin9/luci-app-ttyd/* luci-app-ttyd
#NetData（系统监控）
mkdir luci-app-netdata
cp -rf ../kiddin9/luci-app-netdata/* luci-app-netdata
#rtbwmon（实施流量）
mkdir luci-app-rtbwmon
cp -rf ../kiddin9/luci-app-rtbwmon/* luci-app-rtbwmon

# 存储相关应用
mkdir autoshare-samba
mkdir luci-app-samba4
cp -rf ../kiddin9/autoshare-samba/* autoshare-samba
cp -rf ../kiddin9/luci-app-samba4/* luci-app-samba4

# 科学上网和代理应用
#OpenClash
# svn export https://github.com/vernesong/OpenClash/trunk/luci-app-openclash
# svn export https://github.com/Siriling/OpenWRT-MyConfig/trunk/configs/istoreos/general/applications/luci-app-openclash temp/luci-app-openclash
# cp -rf temp/luci-app-openclash/* luci-app-openclash
mkdir luci-app-openclash
cp -rf ../kiddin9/luci-app-openclash/* luci-app-openclash
cp -rf ../MyConfig/configs/istoreos/general/applications/luci-app-openclash/* luci-app-openclash
#加入OpenClash核心
# chmod -R a+x $GITHUB_WORKSPACE/scripts/preset-clash-core.sh
# if [ "$1" = "rk33xx" ]; then
#     $GITHUB_WORKSPACE/scripts/preset-clash-core.sh arm64
# elif [ "$1" = "rk35xx" ]; then
#     $GITHUB_WORKSPACE/scripts/preset-clash-core.sh arm64
# elif [ "$1" = "x86" ]; then
#     $GITHUB_WORKSPACE/scripts/preset-clash-core.sh amd64
# fi

# 去广告
#ADGuardHome（kiddin9）
mkdir luci-app-adguardhome
cp -rf ../kiddin9/luci-app-adguardhome/* luci-app-adguardhome
cp -rf ../MyConfig/configs/istoreos/general/applications/luci-app-adguardhome/* luci-app-adguardhome
sed -i 's/拦截DNS服务器/拦截DNS服务器（默认用户名和密码均为root）/' luci-app-adguardhome/po/zh_Hans/adguardhome.po
sed -i 's/+PACKAGE_$(PKG_NAME)_INCLUDE_binary:adguardhome//' luci-app-adguardhome/Makefile
#ADGuardHome（kenzok8）
# cp -rf temp/luci-app-adguardhome/* luci-app-adguardhome
# sed -i 's/默认账号和密码均为：admin/默认用户名和密码均为root/' luci-app-adguardhome/po/zh-cn/AdGuardHome.po
# sed -i 's/网页管理账号和密码:admin ,端口:/端口/' luci-app-adguardhome/po/zh-cn/AdGuardHome.po
#dnsfilter
# svn export https://github.com/kenzok8/small-package/trunk/luci-app-dnsfilter
#ikoolproxy
# svn export https://github.com/kenzok8/small-package/trunk/luci-app-ikoolproxy

#内网穿透
#Zerotier
# mkdir luci-app-zerotier
# cp -rf ../kiddin9/luci-app-zerotier/* luci-app-zerotier

# 其他
#Socat
mkdir luci-app-socat
cp -rf ../kiddin9/luci-app-socat/* luci-app-socat
#Unblockneteasemusic
# mkdir UnblockNeteaseMusic
# mkdir luci-app-unblockneteasemusic
# cp -rf ../kiddin9/UnblockNeteaseMusic/* UnblockNeteaseMusic
# cp -rf ../kiddin9/luci-app-unblockneteasemusic/* luci-app-unblockneteasemusic
#OpenAppFilter
# svn export https://github.com/destan19/OpenAppFilter/trunk OpenAppFilter

#主题
# mkdir luci-theme-argon
mkdir luci-app-argon-config
# cp -rf ../kiddin9/luci-theme-argon/* luci-theme-argon
cp -rf ../kiddin9/luci-app-argon-config/* luci-app-argon-config

# iStore应用
mkdir taskd
mkdir luci-lib-taskd
mkdir luci-lib-xterm
mkdir luci-app-store
mkdir quickstart
mkdir luci-app-quickstart
cp -rf ../kiddin9/taskd/* taskd
cp -rf ../kiddin9/luci-lib-taskd/* luci-lib-taskd
cp -rf ../kiddin9/luci-lib-xterm/* luci-lib-xterm
cp -rf ../kiddin9/luci-app-store/* luci-app-store
cp -rf ../kiddin9/quickstart/* quickstart
cp -rf ../kiddin9/luci-app-quickstart/* luci-app-quickstart

# 5G通信模组拨号工具
mkdir quectel_QMI_WWAN
mkdir quectel_cm_5G
# mkdir quectel_MHI
# mkdir luci-app-hypermodem
cp -rf ../Modem-Support/quectel_QMI_WWAN/* quectel_QMI_WWAN
cp -rf ../Modem-Support/quectel_cm_5G/* quectel_cm_5G
# cp -rf ../Modem-Support/quectel_MHI/* quectel_MHI
# cp -rf ../Modem-Support/luci-app-hypermodem/* luci-app-hypermodem

# 5G模组短信插件
mkdir sms-tool
mkdir luci-app-sms-tool
cp -rf ../Modem-Support/sms-tool/* sms-tool
cp -rf ../Modem-Support/luci-app-sms-tool/* luci-app-sms-tool
cp -rf ../MyConfig/configs/istoreos/general/applications/luci-app-sms-tool/* luci-app-sms-tool

# 5G模组管理插件+AT工具
mkdir luci-app-modem
cp -rf ../Modem-Support/luci-app-modem/* luci-app-modem
sed -i "/kmod-pcie_mhi/d" luci-app-modem/Makefile
popd
