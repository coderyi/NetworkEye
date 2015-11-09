# NetworkEye
[![Pod Version](http://img.shields.io/cocoapods/v/NetworkEye.svg?style=flat)](http://cocoadocs.org/docsets/NetworkEye/)
[![Pod Platform](http://img.shields.io/cocoapods/p/NetworkEye.svg?style=flat)](http://cocoadocs.org/docsets/NetworkEye/)
[![Pod License](http://img.shields.io/cocoapods/l/NetworkEye.svg?style=flat)](https://opensource.org/licenses/MIT)



NetworkEye,a iOS network debug library,It can monitor HTTP requests within the App and displays information related to the request.

It can be detected HTTP request include web pages, NSURLConnection, NSURLSession, AFNetworking, third-party libraries, third-party SDK ,and so on. very convenient and practical. 

#### Podfile

```ruby
platform :ios, '7.0'
pod "NetworkEye"
```


######Instruction
Note Use Network Eye in DEBUG mode

add the code in AppDelegate.m   
<pre>
#import "NEHTTPEye.h"
#if defined(DEBUG)||defined(_DEBUG)
    [NSURLProtocol registerClass:[NEHTTPEye class]];
#endif
</pre>

you can use a double tap or shake device to call out the monitoring data interface

NEHTTPEyeViewController

You can also use the following code directly present out
<pre>
#if defined(DEBUG)||defined(_DEBUG)
    NEHTTPEyeViewController *vc=[[NEHTTPEyeViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
#endif
</pre>
In NEHTTPEye.h there are two parameters you can configure is the default password of database is "networkeye" ,and by default set,you can save 300 requests.


the database name is networkeye.sqlite,and stored in the cache directory.

<pre>
#define kSQLitePassword @"networkeye"

#define kSaveRequestMaxCount 300
</pre>

NetworkEye rely FMDB and SQLCipher。
FMDB store data，SQLCipher used to encrypt the database。

Monitoring data interface supports the search conditions is URL，statusCode，HTTPMethod，MIMEType。

the monitor data interface of NetworkEye：

<img  src="https://raw.githubusercontent.com/coderyi/NetworkEye/master/NetworkEye/Resources/networkeye1_2.png" width="320" height="570">

<img  src="https://raw.githubusercontent.com/coderyi/NetworkEye/master/NetworkEye/Resources/networkeye2.png" width="320" height="570">

<img  src="https://raw.githubusercontent.com/coderyi/NetworkEye/master/NetworkEye/Resources/networkeye3.png" width="320" height="570">
