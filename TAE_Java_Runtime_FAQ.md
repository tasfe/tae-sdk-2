# TAE Java Runtime FAQ #


  * Q：启动TAE Java Runtime Web服务器之后，如何运行Demo应用？
> > A：通常情况下，通过浏览器访问地址：http://localhost:8080/demo/index.jsp

  * Q：访问http://localhost:8080/demo/index.jsp时，页面提示异常，如何处理？
> > A：通常，这种情况多处于Windows操作系统，并且用户通过JDK安装程序安装Java。因此，java.exe文件在系统盘:\Windows目录下或者子目录中。建议用户首先通过环境变量的方式，配置JAVA\_HOME，然后将$JAVA\_HOME\bin目录追加到$PATH环境变量中去。然后再在系统盘:\Windows目录下搜索java.exe文件，删除后java.exe文件，这样不会影响Java正常使用。同时，解决了页面编译的问题。其本质原因是TAE Java Runtime编译JSP时需要使用JDK的javac实现。因此，开发者仅安装了JRE也无法正常使用

