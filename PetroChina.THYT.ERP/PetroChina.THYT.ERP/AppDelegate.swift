//
//  AppDelegate.swift
//  PetroChina.thyt.ERP
//
//  Created by Liwenbin on 14/10/10.
//  Copyright (c) 2014年 tuha. All rights reserved.
//

import UIKit
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,NSXMLParserDelegate,UIAlertViewDelegate {
    
    var window: UIWindow?
    var currentName: NSMutableString!
    var state_str:NSString!
    
    func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
        if url.isEqual(nil)
        {
            return false
        }else{
            println("hanleopenurl")
            var domain = BSMCPBaseUtils.getParams("Domain", fromeURLParams: url.absoluteString)
            LoginID = BSMCPBaseUtils.getParams("LoginID", fromeURLParams: url.absoluteString)
            var all = BSMCPBaseUtils.getParams("All", fromeURLParams: url.absoluteString)
            var email_g:NSString = LoginID
            //获取映射信息
            var bb = HanlderUserData()
            bb.connectToUrl()
            //获取映射信息之后 要根据平台获取到的邮箱 找到相应的userid和unitid 然后设置userid和unitid
            for obj in bb.dataNiXDW
            {
                if obj.email.isEqualToString(email_g as String){
                    //设置全局可调用的userid 和 unitid
                    setUserId_Global(obj.userid)
                    setUnitId_Global(obj.unitid)
                    
                }
            }
            
            getQuanXian()
            
            //将domain和LoginID写入domain文件
            var sp = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true)//获取目录
            if sp.count > 0 {
                var url = NSURL(fileURLWithPath: "\(sp[0])/domain.txt")
                var data = NSMutableString()
                data.appendString("\(domain),") //继续添加字符
                data.appendString("\(LoginID),") //继续添加字符
                data.appendString("\(all),")
                if let b = url?.path {
                    data.writeToFile(b, atomically: true, encoding: NSUTF8StringEncoding, error: nil)
                }
                
            }
            return true
        }
        
    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        //        application.openURL(NSURL(fileURLWithPath: String))
        // Override point for customization after application launch.
        //访问沙盒,将用户名密码存储在config.txt中，每次调用读取
        var sp = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true)//获取目录
        if sp.count > 0
        {
            var url = NSURL(fileURLWithPath: "\(sp[0])/config.txt")
            //                            println(url)
            var data = NSMutableString()
            data.appendString("sjld@petrochina.com.cn") //继续添加字符
            //                println(data)
            if let b = url?.path
            {
                data.writeToFile(b, atomically: true, encoding: NSUTF8StringEncoding, error: nil)
            }
            
        }
        println("_________________________...didFinishLaunchingWithOptions")
        
        //        var email_g:NSString = "liming168"
        //        //获取映射信息
        //        var bb = HanlderUserData()
        //        bb.connectToUrl()
        //        //获取映射信息之后 要根据平台获取到的邮箱 找到相应的userid和unitid 然后设置userid和unitid
        //        for obj in bb.dataNiXDW {
        //            if obj.email.isEqualToString(email_g as String){
        //                //设置全局可调用的userid 和 unitid
        //                setUserId_Global(obj.userid)
        //                setUnitId_Global(obj.unitid)
        //            }
        //        }
        //
        //        getQuanXian()
        
        return true
        
    }
    func application(application: UIApplication, willFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        println("_________________________...willFinishLaunchingWithOptions")
        //通过LaunchOptions判断该app是通过什么方式启动的，如果是自启动，则启动中石油平台app
        var launchData = launchOptions
        println("launchdata:\(launchData)")
        if launchData == nil
        {
            UIApplication.sharedApplication().openURL(NSURL(string: "EnterpriseHall://")!)
            //             UIApplication.sharedApplication().openURL(NSURL(string: "PetroChina.THYT.ZongHBG://")!)
            return false
        }
        else
        {
            return true
        }
        
        
    }
    
    //登录权限验证
    func getQuanXian() {
        if LoginID == ""
        {
            var alert = UIAlertView(title: "提示", message: "请插入加密机!", delegate: self, cancelButtonTitle: "确定")
            alert.show()
            return
        }
        else if UserId_Global == "" || UnitId_Global == ""
        {
            var alert = UIAlertView(title: "对不起您没有权限使用该系统", message: "如有疑问请与系统管理员联系!", delegate: self, cancelButtonTitle: "确定")
            alert.show()
            return
        }
        else
        {
            var url = NSURL(string: QuanXianHuoQuUrl)
            
//            setUserId_Global("1000000074")
//            setUnitId_Global("001001006")
            
            var soapStr:NSString = (QuanXianFirst as String) + (UserId_Global as String) + (QuanXianSecond as String) + (UnitId_Global as String) + (QuanXianThird as String)
            println(soapStr)
            var request = NSMutableURLRequest(URL: url!)
            request.addValue("application/soap+xml;charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.addValue("\(soapStr.length)", forHTTPHeaderField: "Content-Length")
            var base1:NSString = "move101:123456"
            var bb1:NSData = base1.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
            var st1 = bb1.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
            request.addValue("Basic \(st1)", forHTTPHeaderField: "Authorization")
            
            request.HTTPMethod = "POST"
            request.HTTPBody = soapStr.dataUsingEncoding(NSUTF8StringEncoding)
            request.timeoutInterval = 5.0
            
            var data = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)
            if data == nil{
                var alert = UIAlertView(title: "服务器连接异常", message: "如有疑问请与系统管理员联系!", delegate: self, cancelButtonTitle: "确定")
                alert.show()
                return
            }
            var ps = ProcessData(proData:data!)
            var parser = NSXMLParser(data: ps.returnTo)
            parser.delegate = self
            parser.parse()
            
            var str:NSString = NSString(data: data!, encoding: NSUTF8StringEncoding)!
            println(str)
        }
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [NSObject : AnyObject]) {
        
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String?) {
        currentName = NSMutableString()
        currentName.appendString(string!)
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "state"{
            state_str = NSString(string: currentName)
        }
    }
    
    func parserDidEndDocument(parser: NSXMLParser)
    {
//        var alert = UIAlertView(title: "state", message: "权限代码\(state_str)", delegate: self, cancelButtonTitle: "确定")
//        alert.show()
        if state_str == "0"
        {
            var alert = UIAlertView(title: "对不起您没有权限使用该程序", message: "如有疑问请与系统管理员联系!", delegate: self, cancelButtonTitle: "确定")
            alert.show()
            return
        }
        else if state_str == "1"
        {
            
        }
        else if state_str == "2"
        {
            var alert = UIAlertView(title: "该用户已被禁用", message: "如有疑问请与系统管理员联系!", delegate: self, cancelButtonTitle: "确定")
            alert.show()
            return
        }
        else if state_str == "3"
        {
            var alert = UIAlertView(title: "服务器连接异常", message: "如有疑问请与系统管理员联系!", delegate: self, cancelButtonTitle: "确定")
            alert.show()
            return
        }
        
    }
    
    //    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int)
    //    {
    //        UIApplication.sharedApplication().openURL(NSURL(string: "EnterpriseHall://")!)
    //        println("跳出程序")
    //    }
    
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        println("_________________________...didReceiveLocalNotification")
        println("notification")
    }
    func applicationWillResignActive(application: UIApplication) {
        println("_________________________...applicationWillResignActive")
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        println("_________________________...applicationDidEnterBackground")
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        println("_________________________...applicationWillEnterForeground")
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        println("_________________________...applicationDidBecomeActive")
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        println("_________________________...applicationWillTerminate")
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

