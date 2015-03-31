# 电量、音量、CPU、MEM等在awesome上显示需要安装Vicious插件
# Vicious 官方wiki：http://awesome.naquadah.org/wiki/Vicious

Ubuntu
 $ sudo apt-get install aptitude
 # 这个是重点
 $ sudo aptitude install awesome-extra

# awesome的主体使用系统自带的另一个主体：
beautiful.init("/usr/share/awesome/themes/zenburn/theme.lua")

# 修改桌面背景：
$ cd /usr/share/awesome/themes/zenburn
$ mkdir bg
$ 将下载下来的背景图片拷到bg目录下

jinlong@king:/usr/share/awesome/themes/zenburn$ ls bg/
a.jpg  b.jpg  d.jpg  e.jpg  test.jpg

# 修改theme.wallpaper_cmd
$ vim theme.lua
theme.wallpaper_cmd = { "awsetbg /usr/share/awesome/themes/zenburn/bg/d.jpg" }

# 具体使用Vicious配置，参考rc.lua

# awesome的API：https://awesome.naquadah.org/doc/api/index.html

# 参考的配置（注：只能拿过来参考）
参考一：http://dotshare.it/dots/62/0/raw/
参考二：http://blog.csdn.net/jixiuffff/article/details/5828148

# 参考的目录里是这两个配置的代码，只供参考（不能直接用，有问题）

# awesome安装指南：
github教程：https://github.com/wzpan/orgwiki/blob/master/software_awesome.org
ubuntu awesome 中文: http://wiki.ubuntu.org.cn/Awesome

# ubuntu 安装vmware：
教程地址：http://dngood.blog.51cto.com/446195/1156769
主要参考这个：http://www.dntk.org/vmware-workstation-11-0-0-zheng-shi-ban-you-xiao-key.html

# 安装awesome后配置注意事项
# 安装后，教程上要你配置.xinitrc，不用去配置这个, 并执行这个：$ ln -s ~/.xinitrc ~/.xprofile
#$ cat .xinitrc 
##/usr/bin/env bash
#
##启动屏保程序
#gnome-screensaver &
#
##启用gnome的主题，否则你的awesome下的gnome程序会非常难看
#gnome-settings-daemon &    
#
##电源管理程序
##gnome-power-statistics &
#
##输入法
#fcitx &
#
##网络管理程序
#nm-applet --sm-disable &                           
#
##自动更新程序
##update-notifier & 
#
##执行which awesome查看awesome路径 
#exec /usr/bin/awesome

#注：千万别配置这个，万一awesome配置失败，启动进入不了awesome，我们还可选择进入ubuntu自带的默认桌面里办公

# 但是一些默认自启动的软件，我们可以把他配置到rc.lua里
-- ME
---{{{ auto start
-- 添加自启动
autorun = true
autorunApps = 
{ 
    "nm-applet --sm-disable &",
    "gnome-settings-daemon &",
    "gnome-screensaver &"
}
---}}}
