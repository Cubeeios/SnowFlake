

 2018年的第一场雪，从32层往外看可以看到肆虐的雪花飞扬，不一会儿窗台上积攒了厚厚的一层，同事说这是上海自08年以来最大的一场雪了。想来真是有幸，17年一整年发生了许多的事情，似乎所有积郁的都在这一场雪了.瑞雪兆丰年，希望2018年能不忘初心，砥砺前行
 
###### SnowFlake是什么
- SnowFlake一套iOS的基于Hybrid框架
- 支持uiwebview/wkwebview容器。
- 支持iOS8以上设备。


###### Hybrid简介

定义:介于Web App与Native App的一种折中方案，底层(框架)部分由iOS/Android开发人员处理，上层(内容展现)部分由Web前端人员处理，用户界面操作逻辑及部分静态资源驻留本地，使得Web App可以对操作迅速反应并在很大程度上实现离线访问。Hybrid App追求趋近于原生App的体验，但目前还较困难。
  ![ico原来的样子](https://github.com/jilei6/SnowFlake/blob/master/SnowFlake2.png) 


###### 环境依赖
 - cocoapods1.0+
 - python3.6



###### 基本配置

- 下载源代码，更新pod安装依赖(cd 至项目根目录下，执行`pod install`)
- 预置前端代码zip压缩包，如：client.zip（注意此处压缩包为通过python打包压缩的包，具体原因及用法后面会讲）
- 修改业务宏定义参数，如:
 
 1.```HybridResource/route.json 文件中
  download_url：（修改为自己的下载地址）
  ```
 2.```SnowfFlake.pch 文件中
  #define CurrentHost @"192.168.10.1" //(初始化需要配置的默认代理转发的域名)
  #define RootSource @"client" （即打包出来的zip的包名即是根目录）
  ```
 3.```SnowfFlake-Bridging-Header.h 文件中
  #define RootHtml @"/index.html"（指定的入口文件）
  ```


- 前端代码压缩包：

  前端给到的代码压缩包可能是如下的结构：
    ![ico原来的样子](https://github.com/jilei6/SnowFlake/blob/master/SnowFlake3.png)  
  1.在python3环境下之行ziptool脚本命令。该脚本中我添加了压缩包的基本信息，比如：版本号、入口文件、根目录以及加密秘钥等信息，所以需要移动端开发人员自行打包
  2.如果执行报错，情pip根据报错信息进行安装Crypto、pyDes等库。
  3.关于Crypto加密库，如果更新过之后依旧报错，我上传了一个稳定版本，可以自行下载替换本地关于Crypto库。
  
   


###### 实现原理
- 1.通过和前端进行深度交互，代理转发所有前端ajax请求。这样做的目的是因为wkwebview目前在拦截所有的请求的过程中，因为性能问题，将所有请求中的body信息全部丢失，所以不能成功请求到Post类型的接口数据(交互框架接入的是[WebViewJavascriptBridge][WebViewJavascriptBridge])所以前端也是需要接入该框架。
- 2.在iOS里面启动一个weberver服务，这个服务映射根目录为前端包文件夹，模拟node服务的方法在本地启动了一个weberver服务，这个模块的核心是：[GCDWebServer][GCDWebServer] ，一个轻量级的移动端web服务插件。将映射本地前端代码渲染页面。一但APP进入了后台，该服务会被停止，不能进行访问，防止在浏览器状态下进行访问
- 3.目前前端代码更新的机制为全量更新，即通过传当前zip的版本号给服务器，服务器校验是否需要更新，以及是否强制更新，并将下载链接返回
- 4.转发如下图 
     ![ico原来的样子](https://github.com/jilei6/SnowFlake/blob/master/SnowFlake5.png)  
  需要注意的是，我这里的请求并没有使用afnetworking 原因是因为在实际转发过程中发现，后端业务api返回的json数据有可能是map即字典类型的，前端可能是需要按照后端返回的字典的顺序进行排序，众所周知字典数据是无序的结构，在使用NSJSONSerialization转化字符串的过程中顺序发生了乱序，这个问题我会再用一片博客进行详细论证。总之，只有通过原始的data类型的数据进行直接转换可以保证数据的时许性。
- 5.其他的业务api如，用户信息保存，校验token，弱网检测等需要根据自己的业务需求和前端进行制定


###### 总结
- 暂时这些吧，SnowFlake尚有许多不完善之处，如果你有好的建议和想法，期望我们可以共同探讨研究。







[WebViewJavascriptBridge]:https://github.com/marcuswestin/WebViewJavascriptBridge
[GCDWebServer]:https://github.com/swisspol/GCDWebServer

















