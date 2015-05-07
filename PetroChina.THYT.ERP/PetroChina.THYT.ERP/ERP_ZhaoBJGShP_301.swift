//
//  ERP_ZhaoBJGShP_301.swift
//  PetroChina.THYT.ERP
//
//  Created by zhaitingting on 14/10/25.
//  Copyright (c) 2014年 PetroChina. All rights reserved.
//

import UIKit

class ERP_ZhaoBJGShP_301: NSObject ,NSURLConnectionDataDelegate,NSXMLParserDelegate{
    
    var parserXml:NSXMLParser!
    var parserDatas:Array<List_301> = []
    var currentParserData:List_301!
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
        println(str)
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
//                var alert = UIAlertView(title: "提示", message: "没有需要处理的业务", delegate: self, cancelButtonTitle: "确定")
//                alert.show()
                currentParserData = List_301()
            }
        }
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [NSObject : AnyObject]) {
        currentNodeName = elementName
        
        if currentNodeName == "appDataDetail"
        {
            currentParserData = List_301()//初始化一组数据
            parserDatas.append(currentParserData)
        }
        //      print(elementName)
        
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String?) {
        var str = string!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        //      println("\(currentNodeName):\(str)")
        //      println(string)
        if str != ""{
            switch currentNodeName {
            case "projectNum":
                currentParserData.projectNum = str
            case "projectName":
                currentParserData.projectName = str
            case "wcWorkNum":
                currentParserData.wcWorkNum = str
            case "stockMethodName":
                currentParserData.stockMethodName = str
            case "currencyTypeName":
                currentParserData.currencyTypeName = str
            case "createPerson":
                currentParserData.creatPerson = str
            case "openBidDate":
                currentParserData.openBidDate = str
            case "personTaskId":
                currentParserData.personTaskId = str
            case "approveId":
                currentParserData.approvedId = str
            case "sourceId":
                currentParserData.sourceId = str
            case "projectPtId":
                currentParserData.projectPtId = str
            default:
                println("default\(currentNodeName):\(str)")
            }
        }
        
    }
    
}
