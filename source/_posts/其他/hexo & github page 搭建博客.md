---
title: hexo & github page 搭建博客
date: 2019-08-17 23:31:24
tags: 其他
categories: 其他
---

### Hexo搭建的GitHub博客

#### 搭建

搭建过程参考这篇文章：[手把手教你使用 Hexo + Github Pages 搭建个人独立博客](https://juejin.im/entry/57144e7179bc44005fa66b9a)

##### Hexo 主题配置建议设置为 next 主题

* 克隆仓库

  ```
  // git clone命令将Next仓库克隆到hexo目录下的themes/next
  git clone https://github.com/theme-next/hexo-theme-next.git themes/next
  ```

  

* 设置Next主题

  ```
  // 在站点根目录下，设置以下代码：
  # Extensions
  ## Plugins: https://hexo.io/plugins/
  ## Themes: https://hexo.io/themes/
  theme: hexo-theme-next   #此处填入你在themes目录下的next主题文件名
  ```

  

#### 个性化设置

大致设置过程参见这篇文章： [Hexo搭建的GitHub博客之优化大全](https://zhuanlan.zhihu.com/p/33616481)

##### 开启文章阅读次数功能

* 第一种方法：LeanCloud (参考这篇文章：https://www.jianshu.com/p/702a7aec4d00)

  * 去 [LeanCloud ](https://leancloud.cn/dashboard/applist.html#/apps) ，创建新应用，创建 Counter 类

  * 修改主题文件

    ```
    leancloud_visitors:
      enable: true #将原来的false改为true
      app_id: #<app_id>
      app_key: #<app_key>
    ```

    

* 第二种方法： 开启不蒜子统计功能

  * 在主题配置文件中 _config.yml ：

    ```
    # Show Views/Visitors of the website/page with busuanzi.
    # Get more information on http://ibruce.info/2015/04/04/busuanzi/
    busuanzi_count:
      enable: true
      site_uv: true #total visitors
      site_uv_icon:  #user-circle
      site_uv_header: 你是来访的第
      site_uv_footer: 位小伙伴
      site_pv: false #total views
      site_pv_icon: eye
      site_pv_header: 访问次数：
      site_pv_footer: 次
      post_views: false
      post_views_icon: eye
    ```

  * 不过因为域名过期问题，next 默认集成的 valine 脚本无法访问，解决办法参见：[hexo博客解决不蒜子统计无法显示问题](https://www.jianshu.com/p/fd3accaa2ae0)

    

##### 开启 valine 评论功能

大致设置过程参考这篇文章： [Hexo博客使用valine评论系统无效果及终极解决方案](https://www.jianshu.com/p/f4658df66a15)



**需要特别注意的是：**

valine评论和文章阅读次数功能均基于LeanCloud，两者有冲突。

解决的办法是：**基于LeanCloud开启 valine 评论，基于不蒜子开启文章统计功能**。