//
//  AppDelegate.swift
//  PetroChina.THYT.OA
//
//  Created by Liwenbin on 10/15/14.
//  Copyright (c) 2014 PetroChina. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UIAlertViewDelegate {

    var window: UIWindow?

    func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
        if url.isEqual(nil){
            return false
        } else {
            var domain = BSMCPBaseUtils.getParams("Domain", fromeURLParams: url.absoluteString)
            var loginID = BSMCPBaseUtils.getParams("LoginID", fromeURLParams: url.absoluteString)
            var all = BSMCPBaseUtils.getParams("All", fromeURLParams: url.absoluteString)
        
            setYouXiang_Global("\(loginID)")
            var soap:NSString = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ser=\"http://service.phone.workflow.rizon.com/\"><soapenv:Header/><soapenv:Body><ser:getUserInfo><!--Optional:--><mailname>\(getYouXiang_GloBal())</mailname></ser:getUserInfo></soapenv:Body></soapenv:Envelope>"
            
            var array: Array<UserInfoData> = []
            //获取权限信息
            var p = Parser()
            //判断数据是否获取成功
            if p.getData(UrlString_Global, soap: soap) {
                array = p.parserDatas
                //设置用户信息
                setUserInfo(array[0])
                var userInfo = getUserInfo()
                var alertView:UIAlertView!
                //判断当前用户是否有登录权限
                if userInfo.flag != "1"
                {
                    alertView = UIAlertView(title: "对不起您没有权限使用该系统", message: "如有疑问请与系统管理员联系！", delegate: self, cancelButtonTitle: "确定")
                    alertView.show()
                }
                else
                {
                    alertView = UIAlertView(title: "服务器连接成功", message: "用户：\(userInfo.userName)\n登录成功！", delegate: self, cancelButtonTitle: "确定")
                    alertView.show()
                }
            }
            else
            {
                var alertView1 = UIAlertView(title: "服务器连接异常", message: "获取用户数据失败！", delegate: self, cancelButtonTitle: "确定")
                alertView1.show()
            }

            
        }
        println("hanleopenurl")
        
        
        return true
    }

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
//            获取所有代办信息
//            DaiBanFirst_Global.appendString(YouXiang_Global)
//            DaiBanFirst_Global.appendString(DaiBanSecond_Global)
//            var bb = allDataOfDaiBan()
//            bb.connectToUrl(UrlString_Global, soapStr: DaiBanFirst_Global)
        
        
        //判断用户当前ios系统
        var version = UIDevice.currentDevice().systemVersion
        var isIos8 = version.hasPrefix("8")
        println("isIos8:\(isIos8)")
        if isIos8 {
            var setting = UIUserNotificationSettings(forTypes: UIUserNotificationType.Badge, categories: nil)
            UIApplication.sharedApplication().registerUserNotificationSettings(setting)
        }
        
        //获取常用意见
        dispatch_async(dispatch_get_global_queue(0, 0), {
            // 处理耗时操作的代码块...
            //请求数据
            getChangYongYJ()
            //通知主线程刷新
            dispatch_async(dispatch_get_main_queue(), {
                if getOpinionFlag {
//                    var alert = UIAlertView(title: "常用意见", message: "\(opinionArray)", delegate: self, cancelButtonTitle: "确定")
//                    alert.show()
                    println("常用意见获取成功\(opinionArray)")
                } else{
                    println("")
                }
                
            })
        })
        
        // Override point for customization after application launch.
        return true
    }
    
    
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if getUserInfo().flag != "1"{
            UIApplication.sharedApplication().openURL(NSURL(string: "EnterpriseHall://")!)
        } else{
            println("do nothing")
        }
    }
    
    func application(application: UIApplication, willFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        //通过LaunchOptions判断该app是通过什么方式启动的，如果是自启动，则启动平台app
        var launchData = launchOptions
        println("launchdata:\(launchData)")
        if launchData == nil {
            UIApplication.sharedApplication().openURL(NSURL(string: "EnterpriseHall://")!)
        }
        
        return true
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
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

