//
//  RecData.swift
//  PortTest
//
//  Created by zhaitingting on 14-10-13.
//  Copyright (c) 2014年 zhaitingting. All rights reserved.
//

import UIKit

class ERP_HeTShB_Detail_212: NSObject ,NSURLConnectionDataDelegate,NSXMLParserDelegate{
    
    //    var dataOfReceive = NSMutableData()//存储返回的数据
    var parserXml:NSXMLParser!
    var returnValue:NSData!
    var dictDatas:Dictionary<String,String> = [:]
    //    var parserDatas:Array<DataClass211> = []
    //    var currentParserData:DataClass211!
    var currentNodeName:String!
    override init()
    {
        super.init()
    }
    //定义构造函数，传入参数为：url和soap字符串
    func connectToUrl(ur:NSString,soapStr:NSMutableString) {
        
        var conData = ReturnHttpConnection() // 获取返回的数据类对象
        var data = conData.connectionData(ur, soapStr: soapStr)
        var str = NSString(data: data, encoding: NSUTF8StringEncoding)
        if  str == "nil"{
            var alert = UIAlertView(title: "提示", message: "网络错误", delegate: self, cancelButtonTitle: "确定")
            alert.show()
            println("网络错误")
            return
        }else {
            
            var ps = ProcessData(proData: conData.connectionData(ur, soapStr: soapStr))
            
            parserXml = NSXMLParser(data: ps.returnTo)
            parserXml.delegate = self
            parserXml.shouldProcessNamespaces = true
            parserXml.shouldReportNamespacePrefixes = true
            parserXml.shouldResolveExternalEntities = true
            parserXml.parse()
        }
        //      for (key,value) in dictDatas {
        //         println("data：\(key),\(value)")
        //      }
        //      println(dictDatas)
        //    println("count:\(parserDatas.count)")
        //      var b = parserDatas[0]
        //    println("parserDatas[0]:\(b.inputDate)")
        ////        connection.start()
        //        println("start")
        
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [NSObject : AnyObject]) {
        currentNodeName = elementName
        
        //        if currentNodeName == "appDataDetail"
        //        {
        //            currentParserData = DataClass211()//初始化一组数据
        //            parserDatas.append(currentParserData)
        //        }
        //      print(elementName)
        
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String?) {
        var str = string!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        //      println("\(currentNodeName):\(str)")
        //      println(string)
        if str != ""{
            switch currentNodeName {
            case "ctrName":
                dictDatas["ctrName"] = str
            case "wzContractId":
                dictDatas["wzContractId"] = str
            case "ctrType":
                dictDatas["ctrType"] = str
            case "inviteBidTypeName":
                dictDatas["inviteBidTypeName"] = str
            case "inputPersonDept":
                dictDatas["inputPersonDept"] = str
            case "fundAllocation":
                dictDatas["fundAllocation"] = str
            case "fundDitchName":
                dictDatas["fundDitchName"] = str
            case "budgetSum":
                dictDatas["budgetSum"] = str
            case "budgetPriceTypeName":
                dictDatas["budgetPriceTypeName"] = str
            case "objects":
                dictDatas["objects"] = str
            case "objectsSum":
                dictDatas["objectsSum"] = str
            case "priceTypeName":
                dictDatas["priceTypeName"] = str
            case "isIncludeTax":
                dictDatas["isIncludeTax"] = str
            case "signUnitName":
                dictDatas["signUnitName"] = str
            case "signPerson":
                dictDatas["signPerson"] = str
            case "providerName":
                dictDatas["providerName"] = str
            case "providerId":
                dictDatas["providerId"] = str case "objects":
                    dictDatas["objects"] = str
            case "performType":
                dictDatas["performType"] = str
            case "performStartDate":
                dictDatas["performStartDate"] = str
            case "performEndDate":
                dictDatas["performEndDate"] = str
            case "performDescribe":
                dictDatas["performDescribe"] = str
            case "performPlace":
                dictDatas["performPlace"] = str
            case "performDescribe":
                dictDatas["performDescribe"] = str
            case "disputeMethod":
                dictDatas["disputeMethod"] = str
            case "frameProtocol":
                dictDatas["frameProtocol"] = str
            case "frameProtocolCtr":
                dictDatas["frameProtocolCtr"] = str
            case "frameProtocolMoney":
                dictDatas["frameProtocolMoney"] = str
            case "frameProtocolCtrName":
                dictDatas["frameProtocolCtrName"] = str
            case "isInterior":
                dictDatas["isInterior"] = str
            case "isForeign":
                dictDatas["isForeign"] = str
            case "isConnected":
                dictDatas["isConnected"] = str
            case "warranty":
                dictDatas["warranty"] = str
            case "subsistRatio":
                dictDatas["subsistRatio"] = str
            case "cashDepositRatio":
                dictDatas["cashDepositRatio"] = str
            case "deliveryDate":
                dictDatas["deliveryDate"] = str
            case "inputOpinion":
                dictDatas["inputOpinion"] = str
            case "basisList":
                dictDatas["basisList"] = str
            case "adjunctList":
                dictDatas["adjunctList"] = str
            case "appUserList":
                dictDatas["appUserList"] = str
            case "errMsg":
                println("Class RecData212 errMsg:\(str)")
            case "errCode":
                println("Class RecData212 errCode:\(str)")
            default:
                println("default")
            }
        }
        
    }
}
