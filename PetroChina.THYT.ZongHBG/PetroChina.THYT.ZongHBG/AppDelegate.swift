//
//  AppDelegate.swift
//  PetroChina.THYT.ZongHBG
//
//  Created by Liwenbin on 10/15/14.
//  Copyright (c) 2014 PetroChina. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,NSXMLParserDelegate,UIAlertViewDelegate {

    var window: UIWindow?
    var currentName: NSMutableString!
    
    
    
    //用户从应用大厅登录访问应用程序
    func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool
    {
        if url.isEqual(nil)
        {
//            UIApplication.sharedApplication().openURL(NSURL(string: "EnterpriseHall://")!)
            return false
        }
        else
        {
            LoginID = BSMCPBaseUtils.getParams("LoginID", fromeURLParams: url.absoluteString)
            getQuanXian()//获取权限
            return true
        }
        
    }

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool
    {
        getQuanXian()//获取权限
        return true
    }
   
    
    //权限验证方法
    func getQuanXian()
    {
        //综合办公系统代号10，验证需要传递的三个参数
        var name = LoginID
        var code = "10"
        var module = "业务动态"
        
        
        var soapStr:NSString = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ser=\"http://service.authentication.petrochina.com/\"><soapenv:Header/><soapenv:Body><ser:getLeavesByUserIdAndAppIdAndLeafId><!--Optional:--><arg0>\(name)</arg0><!--Optional:--><arg1>\(code)</arg1><!--Optional:--><arg2>\(module)</arg2></ser:getLeavesByUserIdAndAppIdAndLeafId></soapenv:Body></soapenv:Envelope>"
        
        var url = NSURL(string: quanxianrenzhengURL as String)
        var request = NSMutableURLRequest(URL: url!)
        request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.addValue(tuhaauthenticservice, forHTTPHeaderField: "SOAPAction")
        request.addValue("\(soapStr.length)", forHTTPHeaderField: "Content-Length")
        request.HTTPMethod = "POST"
        request.HTTPBody = soapStr.dataUsingEncoding(NSUTF8StringEncoding)
        request.timeoutInterval = 10.0//设置程序相应时间位10秒
        
        
        var data = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)
        var parser = NSXMLParser(data: data!)
        var str:NSString = NSString(data: data!, encoding: NSUTF8StringEncoding)!
        
        
        if name == ""//未插加密机或加密机信息读取失败
        {
            MessageBox.title = "加密机信息读取异常"
            MessageBox.show()
//            var alert = UIAlertView(title: "加密机信息读取异常", message: "如有疑问请与系统管理员联系!", delegate: self, cancelButtonTitle: "确定")//登录权限验证
//            alert.show()
            return
        }

        if data == nil//服务器验证地址访问异常
        {
            MessageBox.title = "服务器信息连接异常"
            MessageBox.show()
//            var alert = UIAlertView(title: "服务器信息连接异常", message: "如有疑问请与系统管理员联系!", delegate: self, cancelButtonTitle: "确定")//登录权限验证
//            alert.show()
            return
        }
        
        parser.delegate = self
        parser.parse()
        
        
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [NSObject : AnyObject])
    {
        currentName = NSMutableString()
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String?)
    {
        currentName.appendString(string!)
    }
    
    //从权限验证服务器返回验证结果
    func parserDidEndDocument(parser: NSXMLParser)
    {
        println("jsonStr = \(currentName)")//服务器返回结果（json字符串格式）
        var isQuanX:String = currentName as String!
   
        
        
        if (isQuanX.rangeOfString("\"returnCode\":561") != nil)//返回结果中包含561代码
        {
//            var alert = UIAlertView(title: "对不起您没有权限使用该系统", message: "如有疑问请与系统管理员联系!", delegate: self, cancelButtonTitle: "确定")//登录权限验证
//            alert.show()
            MessageBox.title = "对不起您没有权限使用该系统"
            MessageBox.show()
            return
        }
        else
        {
            quanxianrenzhengSTR = currentName as String!
        }
        
    }
    
    //应用程序启动即将加载完毕
    func application(application: UIApplication, willFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool
    {
        var launchData = launchOptions
        println("launchdata:\(launchData)")
        
        if launchData == nil//应用程序自启动
        {
            UIApplication.sharedApplication().openURL(NSURL(string: "EnterpriseHall://")!)//返回应用大厅
            return false
        }
        else
        {
            return true
        }
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int)
    {
        UIApplication.sharedApplication().openURL(NSURL(string: "EnterpriseHall://")!)//点击确定按钮返回应用大厅
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
//        getQuanXian()//获取权限
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

