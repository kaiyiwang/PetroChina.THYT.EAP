//
//  RecData.swift
//  PortTest
//
//  Created by zhaitingting on 14-10-13.
//  Copyright (c) 2014年 zhaitingting. All rights reserved.
//

import UIKit

class ERP_GongYShGL_List_601: NSObject ,NSURLConnectionDataDelegate,NSXMLParserDelegate{
    
    var parserXml:NSXMLParser!
    var parserDatas:Array<List_601> = []
    var currentParserData:List_601!
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
            //测试数据
            //            var str = NSString(data: data, encoding: NSUTF8StringEncoding)
            //            println(str)
            var ps = ProcessData(proData:conData.connectionData(ur, soapStr: soapStr))
            if ps.returnTo == nil {
                var alert = UIAlertView(title: "提示", message: "请开启网络连接", delegate: self, cancelButtonTitle: "确定")
                alert.show()
                println("网络没有连接")
                return
            }
            parserXml = NSXMLParser(data: ps.returnTo)
            parserXml.delegate = self
            parserXml.shouldProcessNamespaces = true
            parserXml.shouldReportNamespacePrefixes = true
            parserXml.shouldResolveExternalEntities = true
            parserXml.parse()
        }
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [NSObject : AnyObject]) {
        currentNodeName = elementName
        
        if currentNodeName == "appDataDetail"
        {
            currentParserData = List_601()//初始化一组数据
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
            case "approveId":
                currentParserData.approveId = str
            case "personTaskId":
                currentParserData.personTaskId = str
            case "providerDetailId":
                currentParserData.providerDetailId = str
            case "admitId":
                currentParserData.admitId = str
            case "isHse":
                currentParserData.isHse = str
            case "businessId":
                currentParserData.businessId = str
            case "tempProviderId":
                currentParserData.tempProviderId = str
            case "providerName":
                currentParserData.providerName = str
            case "organizeNum":
                currentParserData.organizeNum = str
            case "providerTypeName":
                currentParserData.providerTypeName = str
            case "statusType":
                currentParserData.statusType = str
            case "providerKindName":
                currentParserData.providerKindName = str
            case "juridicalPerson":
                currentParserData.juridicalPerson = str
            case "createDate":
                currentParserData.createDate = str
            case "isReturn":
                currentParserData.isReturn = str
            case "errMsg":
                println("Class RecData211 errMsg:\(str)")
            case "errCode":
                println("Class RecData211 errCode:\(str)")
            default:
                println("default")
            }
        }
        
    }
}
