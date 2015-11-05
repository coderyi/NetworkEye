# NetworkEye
NetworkEye可以监控App内所有HTTP请求并显示请求相关的所有信息，方便App开发的网络调试。
######使用:
在AppDelegate.m里面加入下面代码就可以了
<pre>
#import "NEHTTPEye.h"
[NSURLProtocol registerClass:[NEHTTPEye class]];

</pre>

使用的时候可以通过摇一摇（Shake Gesture）手势调出监控数据界面NEHTTPEyeViewController
也可以用如下代码直接present出来。
<pre>
   NEHTTPEyeViewController *vc=[[NEHTTPEyeViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
</pre>

在NEHTTPEye.h里面有两个可以配置的参数,分别是默认数据库密码为networkeye，以及监控最多300条请求，请求的保存位置在缓存目录的networkeye.sqlite内。
<pre>
#define kSqlitePassword @"networkeye"
#define kSaveRequestMaxCount 300
</pre>

NetworkEye的监控数据界面如图：

<img  src="https://raw.githubusercontent.com/coderyi/NetworkEye/master/NetworkEye/Resources/networkeye1.png" width="320" height="570">

<img  src="https://raw.githubusercontent.com/coderyi/NetworkEye/master/NetworkEye/Resources/networkeye2.png" width="320" height="570">

<img  src="https://raw.githubusercontent.com/coderyi/NetworkEye/master/NetworkEye/Resources/networkeye3.png" width="320" height="570">
