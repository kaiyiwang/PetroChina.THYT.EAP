//
//  ERP_XuQJHShP_Detail_102.swift
//  PetroChina.THYT.ERP
//
//  Created by zhaitingting on 14/10/25.
//  Copyright (c) 2014年 PetroChina. All rights reserved.
//

import UIKit

class ERP_XuQJHShP_Detail_102: NSObject ,NSURLConnectionDataDelegate,NSXMLParserDelegate{
    
    var parserXml:NSXMLParser!
    var parserDatas:Array<Detail_102> = []
    var currentParserData:Detail_102!
    var dictDatas:Dictionary<String,String> = [:]
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
        println("需求Detail：\(str)")
        if  str == "nil"{
            var alert = UIAlertView(title: "提示", message: "网络错误", delegate: self, cancelButtonTitle: "确定")
            alert.show()
            println("网络错误")
            return
        }else {
            //测试数据
            
            var ps = ProcessData(proData:conData.connectionData(ur, soapStr: soapStr))
            
            parserXml = NSXMLParser(data: ps.returnTo)
            parserXml.delegate = self
            parserXml.shouldProcessNamespaces = true
            parserXml.shouldReportNamespacePrefixes = true
            parserXml.shouldResolveExternalEntities = true
            parserXml.parse()
            if currentParserData == nil {
                var alert = UIAlertView(title: "提示", message: "没有需要处理的业务", delegate: self, cancelButtonTitle: "确定")
                alert.show()
                currentParserData = Detail_102()
                parserDatas.append(currentParserData)
            }
        }
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [NSObject : AnyObject]) {
        currentNodeName = elementName
        
        if currentNodeName == "appDataDetail"
        {
            currentParserData = Detail_102()//初始化一组数据
            parserDatas.append(currentParserData)
        }
        //      print(elementName)
        
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String?) {
        var str = string!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        //                  println("\(currentNodeName):\(str)")
        //      println(string)
        if str != ""{
            switch currentNodeName {
            case "approveId":
                dictDatas["approveId"] = str
            case "personTaskId":
                dictDatas["personTaskId"] = str
            case "businessId":
                dictDatas["businessId"] = str
            case "moduleId":
                dictDatas["moduleId"] = str
            case "collectNum":
                currentParserData.collectNum = str
            case "plan2ndNum":
                currentParserData.plan2ndNum = str
            case "matGroupId":
                currentParserData.matGroupId = str
            case "matId":
                currentParserData.matId = str
            case "matName":
                currentParserData.matName = str
            case "matUnit":
                currentParserData.matUnit = str
            case "reqAmount":
                currentParserData.reqAmount = str
            case "matPrice":
                currentParserData.matPrice = str
            case "preAmount":
                currentParserData.preAmount = str
            case "technicReq":
                currentParserData.technicReq = str
            case "plan2ndMxId":
                currentParserData.plan2ndMxId = str
            default:
                println("default：\(currentNodeName):\(str)")
                
            }
        }
        
    }
    
    
}
