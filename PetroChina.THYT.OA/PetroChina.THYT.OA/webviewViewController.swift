//
//  webviewViewController.swift
//  PetroChina.THYT.OA
//
//  Created by zhaitingting on 14/11/24.
//  Copyright (c) 2014年 PetroChina. All rights reserved.
//

import UIKit

class webviewViewController: UIViewController {

    @IBOutlet weak var myWV: UIWebView!
    
    var WDType:NSString = "" //文档类型
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSLog("111:\(WDType)")
        //取出文档类型
        if WDType == "" {
             WDType = "jiemi.doc"
        }else {
            var wendangType:NSString = WDType.substringFromIndex(WDType.length - 3)
            if wendangType.isEqualToString("xls"){
                WDType = "jiemi.xls"
            }else if wendangType.isEqualToString("doc") {
                WDType = "jiemi.doc"
            }else if wendangType.isEqualToString("ppt") {
                WDType = "jiemi.ppt"
            }else if wendangType.isEqualToString("pdf") {
                WDType = "jiemi.pdf"
            }else {
                WDType = "jiemi.doc"
            }

        }
        //        NSLog("222:\(WDType)")
        var sp = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true)//获取目录
        var url = NSURL(fileURLWithPath: "\(sp[0])/\(WDType)")
        var request:NSURLRequest = NSURLRequest(URL:url!)
//        NSLog("path:\(sp[0])/\(WDType)")
        var path = "\(sp[0])/\(WDType)"
        var data: NSData! = NSData.dataWithContentsOfMappedFile("\(path)") as! NSData
        NSLog("data:\(data.length)")
        if data.length == 0 {
            var str = "没有正文数据"
//            var str11 = "document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '400%'";
//            myWV.stringByEvaluatingJavaScriptFromString(str11)
                       self.myWV.loadHTMLString(str, baseURL: nil)
//            self.myWV.loadData(str, MIMEType: "text/plain", textEncodingName: "NSUTF8StringEncoding", baseURL: nil)
        }else{
            
            self.myWV.loadData(data as NSData, MIMEType: "text/plain", textEncodingName: "NSUTF8StringEncoding", baseURL: url)
        }
        
//        self.myWV.loadRequest(request)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
