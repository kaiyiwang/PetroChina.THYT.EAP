import Foundation
import UIKit


//var soap:NSString = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ser=\"http://service.phone.workflow.rizon.com/\"><soapenv:Header/><soapenv:Body><ser:getUserInfo><!--Optional:--><mailname>guojianshe</mailname></ser:getUserInfo></soapenv:Body></soapenv:Envelope>"
//
//
//var soap1:NSString = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ser=\"http://service.phone.workflow.rizon.com/\"><soapenv:Header/><soapenv:Body><ser:getCommonOpinion><!--Optional:--><mailname>guojianshe</mailname></ser:getCommonOpinion></soapenv:Body></soapenv:Envelope>"
//
//
//var urlstr = "http://10.218.8.95/tuha/services/WorkflowPhoneService"
//
//var URL = NSURL(string:urlstr)!
//var request = NSMutableURLRequest(URL: URL)
//
////添加请求的详细信息，与请求报文前半部分的各字段对应
//request.addValue("application/soap+xml;charset=utf-8", forHTTPHeaderField: "Content-Type")
//request.addValue("\(soap1.length)", forHTTPHeaderField: "Content-Lengh")
////设置请求行方法为POST，与请求报文第一行对应
//request.HTTPMethod = "POST"
////将SOAP消息加到请求中
//request.HTTPBody = soap1.dataUsingEncoding(NSUTF8StringEncoding)
////设置超时事件
//request.timeoutInterval = 5
//
//var data:NSData = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)!
//
//var str:NSString = NSString(data: data, encoding: NSUTF8StringEncoding)!
//


var time = NSDate(timeIntervalSinceNow: 28800)
println(time.description)

var str2 = time.description
var a = str2.componentsSeparatedByString(" ")
a

var t = a[1].substringWithRange(Range<String.Index>(start: advance(a[1].startIndex, 0), end: advance(a[1].startIndex, 5)))


//contentTime = contentTime.substringWithRange(Range<String.Index>(start: advance(contentTime.startIndex, 0), end: advance(contentTime.startIndex, 26)))




//判断用户当前ios系统
var version = UIDevice.currentDevice().systemVersion
var isIos8 = version.hasPrefix("8")
println("isIos8:\(isIos8)")
if isIos8 {
    var setting = UIUserNotificationSettings(forTypes: UIUserNotificationType.Badge, categories: nil)
    UIApplication.sharedApplication().registerUserNotificationSettings(setting)
}







