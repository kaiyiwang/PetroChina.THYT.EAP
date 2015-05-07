//
//  ZhengWenData.swift
//  PetroChina.THYT.OA
//
//  Created by zhaitingting on 14/11/19.
//  Copyright (c) 2014年 PetroChina. All rights reserved.
//

import UIKit

class ZhengWenData: NSObject,NSURLConnectionDataDelegate,NSXMLParserDelegate{
    var parserXml:NSXMLParser!
    var finalZhengWenData:NSMutableString = ""
    var currentNode:NSString! //存储当前节点信息
    var WDType:NSString = "" //存储文档的类型
    var dataLenth = 0
    override init() {
        super.init()
    }
    
    func connectToUrl(ur:NSString,soapStr:NSString,wenjianType:NSString) {
        var conData = ReturnHttpConnection() // 获取返回的数据类对象
        var dataLast = conData.connectionData(ur, soapStr: soapStr)
        var str = NSString(data: dataLast, encoding: NSUTF8StringEncoding)
//                                                    println(str)
        
        if  str == "nil"{
            var alert = UIAlertView(title: "提示", message: "请开启网络连接", delegate: self, cancelButtonTitle: "确定")
            alert.show()
            println("网络没有连接")
        }else {
            //测试数据
            parserXml = NSXMLParser(data:dataLast)
            parserXml.delegate = self
            parserXml.shouldProcessNamespaces = true
            parserXml.shouldReportNamespacePrefixes = true
            parserXml.shouldResolveExternalEntities = true
            parserXml.parse()
            //将数据写入文件
           
//            NSDictionary
            var data = NSData(base64EncodedString: finalZhengWenData as String, options: NSDataBase64DecodingOptions.allZeros)
            var str:NSString = NSString(data: data!, encoding: NSUTF16LittleEndianStringEncoding)!
//            var str = "没有正文数据"
//            var str = "bbbb"
//            println(str)
//            var ss = data?.bytes
            var sp = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true)//获取目录
            if sp.count > 0 {
                if wenjianType == "" {
                     WDType = "jiemi.doc"
                }else{
                    var wendangType:NSString = wenjianType.substringFromIndex(wenjianType.length - 3)
                    if wendangType.isEqualToString("xls"){
                        WDType = "jiemi.xls"
                    }else if wendangType.isEqualToString("doc") {
                        WDType = "jiemi.doc"
                    }else if wendangType.isEqualToString("ppt") {
                        WDType = "jiemi.ppt"
                    }else if wendangType.isEqualToString("pdf") {
                        WDType = "jiemi.pdf"
                    }

                    
                    
                }
                var url = NSURL(fileURLWithPath: "\(sp[0])/\(WDType)")
                println(url)
                println(str.length)
                dataLenth = str.length
//                if str.length == 0 {
//                    
//                    print("00000000000000")
//                }
                
                if let b = url?.path {
                var result = str.writeToFile(b, atomically: true, encoding:NSUTF16LittleEndianStringEncoding , error: nil)
                    if result == false {
                        println("写入文件失败")
                    }else{
                        println("写入文件成功")
                    }
                }
//                NSUTF8StringEncoding
                
            }
            println("write Over")

            

            
//             var zhengWen = NSString(bytes: data!.bytes, length: data!.length, encoding: NSUTF16LittleEndianStringEncoding)
            
            
            
            
//            NSArray UnsafePointer<AnyObject?>
            
            
//            var zhengWen = NSString(bytes: data!.bytes, length: data!.length, encoding: NSUTF16BigEndianStringEncoding)
        
//            var zhengWen = NSString(bytes: data!.bytes, length: data!.length, encoding: NSUTF16BigEndianStringEncoding)
            
            
            
//            var zhengWen = NSString(bytes: data!.bytes, length: data!.length, encoding: NSUTF16LittleEndianStringEncoding)
            
            
//            CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)
//            var string = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingASCII)
//            var zhengWen = NSString(bytes: data!.bytes, length: data!.length, encoding: NSUTF16LittleEndianStringEncoding)
//            var zhengWen = NSString(bytes: data!.bytes, length: data!.length, encoding: NSUTF16StringEncoding)
//            var zhengWen = NSString(bytes: data!.bytes, length: data!.length, encoding: NSUTF16StringEncoding)
//            var zhengWen = NSString(bytes: data!.bytes, length: data!.length, encoding: NSUTF32BigEndianStringEncoding)
//            var zhengWen = NSString(bytes: data!.bytes, length: data!.length, encoding: NSUTF32BigEndianStringEncoding)
          
           
//            println(zhengWen)
//
            if finalZhengWenData == "" {
//                var alert = UIAlertView(title: "提示", message: "没有正文信息", delegate: self, cancelButtonTitle: "确定")
//                alert.show()
                
            }
            
        }
        
    }
    //将数据分类
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [NSObject : AnyObject]) {
        currentNode = elementName
        
//        //        println("element:\(elementName)")
//        if currentNode == "return" {
//           
//        }
    }
    func parser(parser: NSXMLParser, foundCharacters string: String?){
        //        println("str:\(string)")
        var str = string!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        if currentNode == "return" {
             finalZhengWenData.appendString(str)
        }
       
    }
    


}