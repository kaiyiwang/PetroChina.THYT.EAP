//
//  RecData.swift
//  PortTest
//  211接口的数据
//  Created by zhaitingting on 14-10-13.
//  Copyright (c) 2014年 zhaitingting. All rights reserved.
//

import UIKit

class ERP_HeTShB_211: NSObject ,NSURLConnectionDataDelegate,NSXMLParserDelegate{
    
    var parserXml:NSXMLParser!   
    var parserDatas:Array<List_211> = []
    var currentParserData:List_211!
    var currentNodeName:String!
    
    override init()
    {
        super.init()
    }
    
    //定义构造函数，传入参数为：url和soap字符串
    func connectToUrl(ur:NSString,soapStr:NSString) {
        
        var conData = ReturnHttpConnectionAuth() // 获取返回的数据类对象
        var data = conData.connectionData(ur, soapStr: soapStr)
        var str = NSString(data: data, encoding: NSUTF8StringEncoding)
        if  str == "nil"{
            var alert = UIAlertView(title: "提示", message: "网络错误", delegate: self, cancelButtonTitle: "确定")
            alert.show()
            println("网络错误")
            return
        }else {
            
            var ps = ProcessData(proData:conData.connectionData(ur, soapStr: soapStr))
            
            parserXml = NSXMLParser(data: ps.returnTo)
            parserXml.delegate = self
            parserXml.shouldProcessNamespaces = true
            parserXml.shouldReportNamespacePrefixes = true
            parserXml.shouldResolveExternalEntities = true
            parserXml.parse()
        }
        if currentParserData == nil {
            var alert = UIAlertView(title: "提示", message: "没有需要处理的业务", delegate: self, cancelButtonTitle: "确定")
            alert.show()
            currentParserData = List_211()
        }
        //        var b = parserDatas[0]
        //        println("parserDatas[0]:\(b.inputDate)")
        //       connection.start()
        //        println("start")
        
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [NSObject : AnyObject]) {
        currentNodeName = elementName
        
        if currentNodeName == "appDataDetail"
        {
            currentParserData = List_211()//初始化一组数据
            parserDatas.append(currentParserData)
        }
        
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String?) {
        var str = string!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        if str != ""{
            switch currentNodeName {
            case "approveId":
                currentParserData.approveId = str
            case "personTaskId":
                currentParserData.personTaskId = str
            case "personTaskName":
                currentParserData.personTaskName = str
            case "moduleName":
                currentParserData.moduleName = str
            case "taskName":
                currentParserData.taskName = str
            case "inputDate":
                currentParserData.inputDate = str
            case "unitName":
                currentParserData.unitName = str
            case "trueName":
                currentParserData.trueName = str
            case "toTrueName":
                currentParserData.toTrueName = str
            case "consignTrueName":
                currentParserData.consignTrueName = str
//            case "errMsg":
//                currentParserData.errMsg = str
//                println("Class RecData211 errMsg:\(str)")
//            case "errCode":
//                currentParserData.errCode = str
//                println("Class RecData211 errCode:\(str)")
            default:
                println("default")
            }
        }
        
    }
    
    
}
