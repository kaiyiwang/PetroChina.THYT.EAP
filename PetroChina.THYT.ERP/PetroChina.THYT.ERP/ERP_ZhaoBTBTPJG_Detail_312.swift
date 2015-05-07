//
//  ERP_ZhaoBTBTPJG_Detail_312.swift
//  PetroChina.THYT.ERP
//
//  Created by zhaitingting on 14/10/25.
//  Copyright (c) 2014年 PetroChina. All rights reserved.
//

import UIKit

class ERP_ZhaoBTBTPJG_Detail_312: NSObject ,NSURLConnectionDataDelegate,NSXMLParserDelegate{
    
    var parserXml:NSXMLParser!
    var parserDataBase:Detail_312_Base! //基本信息
    var parserDataZhaoBXX:Array<Detail_312_ZhaoBXX> = [] // 招标信息
    var currentDataZhaoBXX:Detail_312_ZhaoBXX!
    var parserDataShenPZhT:Array<Detail_312_ShenPZhT> = [] //审批状态
    var currentDataShenPZhT:Detail_312_ShenPZhT!
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
            //                                            println(str)
            var ps = ProcessData(proData:conData.connectionData(ur, soapStr: soapStr))
            //
            parserXml = NSXMLParser(data: ps.returnTo)
            parserXml.delegate = self
            parserXml.shouldProcessNamespaces = true
            parserXml.shouldReportNamespacePrefixes = true
            parserXml.shouldResolveExternalEntities = true
            parserXml.parse()
            if currentDataZhaoBXX == nil {
//                var alert = UIAlertView(title: "提示", message: "没有需要处理的业务", delegate: self, cancelButtonTitle: "确定")
//                alert.show()
                currentDataZhaoBXX = Detail_312_ZhaoBXX()
                parserDataZhaoBXX.append(currentDataZhaoBXX)
            }
            if currentDataShenPZhT == nil {
//                var alert = UIAlertView(title: "提示", message: "没有需要处理的业务", delegate: self, cancelButtonTitle: "确定")
//                alert.show()
                currentDataShenPZhT = Detail_312_ShenPZhT()
                parserDataShenPZhT.append(currentDataShenPZhT)
            }
            if parserDataBase == nil {
                var alert = UIAlertView(title: "提示", message: "没有需要处理的业务", delegate: self, cancelButtonTitle: "确定")
                alert.show()
                parserDataBase = Detail_312_Base()
            }
            
            
            //            println("parserDataBase.businessId:\(parserDataBase.businessCode)")
        }
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [NSObject : AnyObject]) {
        currentNodeName = elementName
        //      println("start:\(elementName)")
        if currentNodeName == "appDataDetail"
        {
            parserDataBase = Detail_312_Base() //初始化基本信息数据
        }
        //招标信息
        if currentNodeName == "BargainingUnitDetails" {
            currentDataZhaoBXX = Detail_312_ZhaoBXX()
            parserDataZhaoBXX.append(currentDataZhaoBXX)
        }
        // 审批状态
        if currentNodeName == "appModuleDetails" {
            currentDataShenPZhT = Detail_312_ShenPZhT()
            parserDataShenPZhT.append(currentDataShenPZhT)
        }
        //              print(elementName)
        
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String?) {
        var str = string!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        //      println("\(currentNodeName):\(str)")
        //      println(string)
        if str != ""{
            switch currentNodeName {
                //基本信息
            case "resultId":
                parserDataBase.resultId = str
            case "projectId":
                parserDataBase.projectId = str
            case "personTaskId":
                parserDataBase.personTaskId = str
            case "approveId":
                parserDataBase.approveId = str
            case "projectNum":
                parserDataBase.projectNum = str
            case "projectName":
                parserDataBase.projectName = str
            case "matId":
                parserDataBase.matId = str
            case "sumMatMoney":
                parserDataBase.sumMatMoney = str
            case "currencyTypeName":
                parserDataBase.currencyTypeName = str
            case "invoiceTypeName":
                parserDataBase.invoiceTypeName = str
            case "exchangeRate":
                parserDataBase.exchangeRate = str
            case "taxRate":
                parserDataBase.taxRate = str
            case "reqUnitName":
                parserDataBase.reqUnitName = str
            case "openBidDate":
                parserDataBase.openBidDate = str
            case "bidHostPerson":
                parserDataBase.bidHostPerson = str
            case "mainReqUnitName":
                parserDataBase.mainReqUnitName = str
            case "isTz":
                parserDataBase.isTz = str
            case "isZc":
                parserDataBase.isZc = str
            case "isXy":
                parserDataBase.isXy = str
            case "isOne":
                parserDataBase.isOne = str
            case "stockMethodName":
                parserDataBase.stockMethodName = str
            case "firstMoney":
                parserDataBase.firstMoney = str
            case "resultMoney":
                parserDataBase.resultMoney = str
            case "bidJudgePerson":
                parserDataBase.bidJudgePerson = str
            case "openBidPlace":
                parserDataBase.openBidPlace = str
            case "bidProposal":
                parserDataBase.bidProposal = str
            case "deliveryDesc":
                parserDataBase.deliveryDesc = str
            case "technicReq":
                parserDataBase.technicReq = str
            case "deliveryPlace":
                parserDataBase.deliveryPlace = str
            case "transportWay":
                parserDataBase.transportWay = str
            case "pack":
                parserDataBase.pack = str
            case "matPay":
                parserDataBase.matPay = str
            case "otherContent":
                parserDataBase.otherContent = str
            case "changeCause":
                parserDataBase.changeCause = str
            case "remark":
                parserDataBase.remark = str
            case "adjunctTitle":
                parserDataBase.adjunctTitle = str
            case "adjunctPath":
                parserDataBase.adjunctPath = str
                //投标信息
            case "providerName":
                currentDataZhaoBXX.providerName = str
            case "resultMoney":
                currentDataZhaoBXX.resultMoney = str
            case "deliveryDate":
                currentDataZhaoBXX.deliveryDate = str
            case "linkPerson":
                currentDataZhaoBXX.linkPerson = str
            case "linkPhone":
                currentDataZhaoBXX.linkPhone = str
            case "myNum":
                currentDataZhaoBXX.myNum = str
            case "isConfirm":
                currentDataZhaoBXX.isConfirm = str
                //审批状态
            case "moduleName":
                currentDataShenPZhT.moduleName = str
            case "approvePerson":
                currentDataShenPZhT.approvePerson = str
            case "sendDate":
                currentDataShenPZhT.sendDate = str
            case "approveDate":
                currentDataShenPZhT.approveDate = str
            case "approveStateName":
                currentDataShenPZhT.approveStateName = str
            case "approveComment":
                currentDataShenPZhT.approve_comment = str
            case "approveUnitName":
                currentDataShenPZhT.approveUnitName = str
            case "approveDegree":
                currentDataShenPZhT.approveDegree = str
                
                //平台缺少物资信息
                //与上面一样，怎样区别？
                //定义bool变量区别呀呀呀呀，哈哈哈
            default:
                println("default:\(currentNodeName):\(str)")
            }
        }
        
    }
    
    
}
