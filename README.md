# CSmtp - C++实现的支持SSL/TLS的SMTP邮件发送器

CSmtp是一个C++实现的支持SSL/TLS的SMTP邮件发送器，通过CSmtp可以实现SMTP协议的邮件发送，支持SSL/TLS加密。

## 开始使用

CSmtp项目提供两个发布件：`mail_sender邮件发送应用`和`csmtp功能静态库`

如果需要集成进代码中，请引用csmtp功能库（参考demo文件夹下项目的实现）；也可以直接使用mail_sender程序，通过命令行参数直接发送邮件。

### 构建

> Windows平台提供可以直接使用的发布版本，包含csmtp.lib和mail_sender.exe，构建环境为Windows 10 - Visual Studio 2015 MSVC 140 - win32/x64。

#### Windows构建

在该项目文件夹下，打开cmd命令行窗口。

Windows下已二进制引入OpenSSL的发布库，在csmtp-ref文件夹下。执行以下命令将其解压：

```shell
build extract
```

如果系统没有安装CMake，请先安装CMake或下载CMake的portable压缩包解压，并修改`script\config.bat`文件，将CMake路径加入到临时环境变量PATH中，然后执行以下命令：

```shell
build config
```

最后执行以下命令构建项目，构建项目至少需要Visual Studio 2015：

```shell
build msvc Release x64 VS2015
```

当前支持VS2015、VS2017、VS2019，通过第四个参数进行指定。第二个参数指定生成的是Debug或Release，第三个参数指定生成的二进制是32位或64位。

> 测试构建环境：Windows 10 - Visual Studio 2015 MSVC 140 - OpenSSL 1.1.1l

#### Linux构建

Linux下构建需要安装OpenSSL，Ubuntu下一般自带该库，如果不存在可以使用以下命令安装（需要注意的是，用apt-get安装的OpenSSL可能不是最新的1.1.1版本，旧版本很可能存在安全漏洞及不再维护的风险，如果需要使用最新版本的OpenSSL需要手动进行编译，可以参考该[文章](https://askubuntu.com/questions/1126893/how-to-install-openssl-1-1-1-and-libssl-package)）：

```shell
sudo apt-get install libssl-dev
```

本项目构建的CMakeLists要求CMake版本至少为3.10以上，低版本的Ubuntu用apt-get只能安装大版本号为2的CMake，此时需要源码编译CMake并安装进系统中，可以使用以下命令编译安装CMake 3.16.0：

```shell
sudo apt install build-essential libssl-dev
wget http://www.cmake.org/files/v3.16/cmake-3.16.0.tar.gz
tar xf cmake-3.16.0.tar.gz
cd cmake-3.16.0/
./configure
make -j4
sudo make install
```

最后执行以下命令构建项目：

```shell
./build.sh linux Release x64
```

第二个参数指定生成的是Debug或Release，第三个参数指定生成的二进制是32位或64位。

> 测试构建环境：Ubuntu 14.04.3 - gcc 4.8.4 - OpenSSL 1.0.1f

### mail_sender命令行参数说明

windows下使用`mail_sender.exe`，Linux下使用`./mail_sender`，以Windows为例：

```shell
mail_sender.exe ServerName=smtp.office365.com ServerPort=587 Security=tls User=用户 Password=密码 SenderName=发送者名称 SenderMail=发送者邮箱 "ReceiverMails=a@mail.com b@mail.com" Title=邮件标题 Body=邮件正文
```

简单的使用如上所示，这将使用outlook邮箱发送一封邮件给a@mail.com和b@mail.com。接下来详细介绍各参数的含义及使用说明：

| 参数名称          | 指定要求         | 使用说明                                     |
| ------------- | ------------ | ---------------------------------------- |
| ServerName    | 必须指定         | 邮箱服务器SMTP服务的地址名称                         |
| ServerPort    | 有默认值         | 邮箱服务器SMTP服务的端口，默认值为25，若邮箱服务器采用其他端口，需自行指定 |
| Security      | 有默认值         | 安全连接类型，默认为none，可选none、ssl、tls            |
| User          | 必须指定         | 用于邮箱登陆的账户名                               |
| Password      | 必须指定         | 用于邮箱登陆的账户密码                              |
| SenderName    | 必须指定         | 当前邮件的发件者名称                               |
| SenderMail    | 必须指定         | 当前邮件的发件者地址                               |
| ReceiverMails | 必须指定         | 当前邮件的收件者地址，可以指定多个，多个收件者间用空格隔开            |
| Title         | 必须指定         | 当前邮件的标题                                  |
| Body          | 必须指定         | 当前邮件的正文                                  |
| Files         | 可选项，按需指定     | 当前邮件的附加文件，可以指定多个，多个附加文件间用空格隔开，单个文件大小需小于25MB或邮箱服务器支持的最大大小 |
| CharSet       | 可选项，按需指定     | 当前邮件的编码字符集，默认中文编码字符集gb2312               |
| XMailer       | 可选项，按需指定     | 当前邮件的发送客户端名称，可以使用默认设置                    |
| XPriority     | 可选项，按需指定     | 当前邮件的等级，默认为normal，可选low、normal、high      |
| Output        | 有默认值，与邮件发送无关 | 默认为true，当为true时，邮件发送成功时会输出详细信息到控制台       |

## 历史

该项目的前身来自CodeProject上的项目：

https://www.codeproject.com/Articles/98355/SMTP-Client-with-SSL-TLS

https://www.codeproject.com/Articles/28806/SMTP-Client

## 协议

本项目继续遵循前身的协议：**The Code Project Open License (CPOL)**

协议内容参考`LICENSE.htm`文件或[CPOL官方发布链接](https://www.codeproject.com/info/cpol10.aspx)。
