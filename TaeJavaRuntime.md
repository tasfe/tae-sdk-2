# 引言 #

> TAE Java运行时是基于Java Web的淘宝应用引擎，简化开发、部署、运维等成本


---


## Java Rutime 开发服务器下载 ##

[点击下载](http://tae-sdk-2.googlecode.com/files/TAE%20Java%20Runtime.zip)


---


# 支持技术 #

> 基础支持：标准Servlet 3.0 技术(兼容Servlet 2.x），JSP 2.1

> 框架支持：不限制特定的框架（请注意，从安全和稳定性的角度出发，官方将会提供推荐的框架版本依赖，推荐列表将被添加）

> 数据库支持：MySQL 5.x

> 内建服务：TAE Java运行时提供了内建的服务API，提供一些基础服务，例如：分布式缓存服务、分布式session、日志服务等。分布式文件、fetUrl等功能目前开发中。


---


# 开发规范 #

> ## 内建服务（Build-in Service） API接口 ##


> ### 分布式缓存服务 ###

> 为应用重复使用生命周期内的临时缓存解决方案，不建议开发人员强烈依赖于缓存，作为持久化的存储技术方案。

> ### 分布式文件服务 ###

> 为应用提供文件存储服务，支持文本文件和二进制文件，不建议开发人员存放内容太大的文件，比如超过5M。

> ### HTTP获取服务 ###

> 提供基本的HTTP GET和POST获取服务

> ### 日志服务 ###

> 通用的日志服务，暴露slf4j API接口，开发人员可以自行选择日志的实现，比如logj4、Java Logging或Logback等

> ### 数据库源 ###
> 提供标准接口：javax.sql.DataSource的实现，开发者无需关心线上的服务配置，只需要在线下环境配置。具体请参考：[数据库配置](http://code.google.com/p/tae-sdk-2/wiki/TaeJavaRuntime#数据库配置)

> 开发者可以参考文档：
[TAE OPEN API JavaDoc](http://tae-sdk-2.googlecode.com/files/tae-open-api-1.0.0-SNAPSHOT-javadoc.jar)


> 开发不许关心内置服务API的具体实现，只需要关心服务API接口。为了方便开发，提供了服务暴露工具类：com.taobao.tae.open.api.Services，通过Getter方法获取相关的Serivce接口


---


# 安全规范 #

> ## SQL注入 ##
> > 非常常见的安全问题，开发人员无需过分关注SQL注入问题，TAE Java运行时环境将会自行处理。不过，为了以防万一，请注意开发人员在设计师数据库时，尽可能地避免复杂的字符拼接的SQL，并且不要直接暴露SQL交互接口。特别提示：由于SQL注入问题，线上系统，可能会在应用关联的数据库表中添加安全字段，这些字段不会影响应用功能性。


> ## Cookie ##
> > 为了防止应用有意或无意地篡改用户Cookie信息，应用只能读取Cookie，无法通过新增Cookie信息。从代码层面来说，javax.servlet.http.HttpServletResponse#addCookie(javax.servlet.http.Cookie)方法将被禁止。


> ## HTTP响应（Response）头 ##
> > 暂时无法读取相应头中的信息


> ## Session ##
> > 暂时不开放写入Session的功能，即javax.servlet.http.HttpSession#setAttribute(String,Object)方法调用无效。在应用设计时，可以考虑使用CacheService来替代Session存储的功能。如果仍然无法满足需求，请提交需求给维护人：桃谷


> ## Redirect（重定向） ##
> > 外链存在的安全安全风险，因此重定向的URL只能是相对路径或者白名单域名
> > 白名单域名列表：
> > .taobao.com


> ## XSS ##
> > 常见的安全问题，开发者无需关心处理该问题，TAE Java运行时环境将会自行处理


> ## CSRF ##
> > 常见的安全问题，开发者无需关心处理该问题，TAE Java运行时环境将会自行处理


> ## 文件上传 ##
> > 暂时不开放，可以使用FileService作为替代技术方案，未来可能支持


---


# 部署规范 #

请参考：[具体操作步骤](http://code.google.com/p/tae-sdk-2/downloads/detail?name=TAE%20Java%20Runtime.zip&can=2&q=#makechanges)


---


# 数据库配置 #


> TAE Java Runtime 仅支持MySQL数据，因此在设计应用时，需要考虑SQL脚本的数据库偏好问题。同时，由于TAE Java Runtime 线上系统数据库源无需配置，因此，接下来介绍线下开发的配置方法。

> 当[下载TAE Java Runtime Web服务器（开发版）](http://code.google.com/p/tae-sdk-2/downloads/detail?name=TAE%20Java%20Runtime.zip&can=2&q=#makechanges)并且解压后，根目录下有一个名为etc的目录，该目录为配置目录。为了保证Java Runtime的运行正常，除非必要，请不要随意修改里面的内容。

> ## 修改数据库源信息 ##

> 在etc目录下有一个名为tae-jndi.xml的XML文件，利用专业工具打开，通过关键字："taeappdatasource"搜索定位，启动部门配置内容如下：
> > 

&lt;New id="taeappdatasource" class="org.eclipse.jetty.plus.jndi.Resource"&gt;


> > > 

&lt;Arg&gt;



&lt;/Arg&gt;


> > > 

&lt;Arg&gt;

jdbc/appds

&lt;/Arg&gt;


> > > 

&lt;Arg&gt;


> > > > 

&lt;New class="com.alibaba.druid.pool.DruidDataSource"&gt;




> 

&lt;Set name="url"&gt;


> > 

&lt;SystemProperty name="jdbc.url" default="jdbc:mysql://10.232.64.176:5300/"/&gt;



> 

&lt;/Set&gt;



> 

&lt;Set name="username"&gt;


> > 

&lt;SystemProperty name="jdbc.user.name" default="tae"/&gt;



> 

&lt;/Set&gt;



> 

&lt;Set name="password" value=""&gt;


> > 

&lt;SystemProperty name="jdbc.password" default="tae"/&gt;



> 

&lt;/Set&gt;



> 

&lt;Set name="testWhileIdle"&gt;

true

&lt;/Set&gt;



> 

&lt;/New&gt;


> 

&lt;/Arg&gt;


> 

&lt;/New&gt;



**特别提示：请不要修改其他的配置项**

能够修改的配置项为：


&lt;SystemProperty name="jdbc.url" default="jdbc:mysql://10.232.64.176:5300/" /&gt;




&lt;SystemProperty name="jdbc.user.name" default="tae" /&gt;




&lt;SystemProperty name="jdbc.password" default="tae" /&gt;



熟悉JDBC的开发者，很容易理解其中的意思，即可以通过系统Properties配置，也可以通过当前配置文件配置：

jdbc.url : jdbc数据库URL连接字符创
jdbc.user.name : jdbc数据库连接用户名
jdbc.password : jdbc数据库连接密码















