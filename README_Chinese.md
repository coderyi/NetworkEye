# NetworkEye
[![Pod Version](http://img.shields.io/cocoapods/v/NetworkEye.svg?style=flat)](http://cocoadocs.org/docsets/NetworkEye/)
[![Pod Platform](http://img.shields.io/cocoapods/p/NetworkEye.svg?style=flat)](http://cocoadocs.org/docsets/NetworkEye/)
[![Pod License](http://img.shields.io/cocoapods/l/NetworkEye.svg?style=flat)](https://opensource.org/licenses/MIT)

[README English](https://github.com/coderyi/NetworkEye/blob/master/README.md)

NetworkEye是一个网络调试库，可以监控App内HTTP请求并显示请求相关的详细信息，方便App开发的网络调试。

可以检测到包括网页，NSURLConnection,NSURLSession，AFNetworking,第三方库，第三方SDK等的HTTP请求，非常方便实用。并且可以统计App内流量

NetworkEye,a iOS network debug library,It can monitor all HTTP requests within the App and displays all information related to the request.
#### Podfile

```ruby
platform :ios, '7.0'
pod 'NetworkEye', '~> 0.9.9'
```


######使用:
注意请在DEBUG模式下使用NetworkEye
在AppDelegate.m里面加入下面代码就可以了
<pre>
#import "NEHTTPEye.h"
#if defined(DEBUG)||defined(_DEBUG)
    [NEHTTPEye setEnabled:NO];
#endif
</pre>

使用的时候可以通过双指轻拍或者摇一摇（Shake Gesture）手势调出监控数据界面NEHTTPEyeViewController
也可以用如下代码直接present出来。
<pre>
#if defined(DEBUG)||defined(_DEBUG)
    NEHTTPEyeViewController *vc=[[NEHTTPEyeViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
#endif
</pre>

在NEHTTPEye.h里面有两个可以配置的参数即默认数据库密码是networkeye和默认监控最多300条请求，请求的保存位置在缓存目录的networkeye.sqlite内。
<pre>
#define kSQLitePassword @"networkeye"

#define kSaveRequestMaxCount 300
</pre>

NetworkEye依赖仓库FMDB和SQLCipher。
FMDB用于存储监控数据，SQLCipher用于加密数据库。

监控数据界面支持的搜索条件为URL，statusCode，HTTPMethod，MIMEType。

NetworkEye的监控数据界面如图：

<img  src="https://raw.githubusercontent.com/coderyi/NetworkEye/master/NetworkEye/Resources/networkeye1_2.png" width="320" height="570">

<img  src="https://raw.githubusercontent.com/coderyi/NetworkEye/master/NetworkEye/Resources/networkeye2.png" width="320" height="570">

<img  src="https://raw.githubusercontent.com/coderyi/NetworkEye/master/NetworkEye/Resources/networkeye3.png" width="320" height="570">
