//
//  ERP_ZhaoBJGShP_Detail_302.swift
//  PetroChina.THYT.ERP
//
//  Created by zhaitingting on 14/10/25.
//  Copyright (c) 2014年 PetroChina. All rights reserved.
//

import UIKit

class ERP_ZhaoBJGShP_Detail_302: NSObject,NSURLConnectionDataDelegate ,NSXMLParserDelegate{
    
    
    var parserXml:NSXMLParser!
    var parserDataBase:Detail_302_Base! //基本信息
    var parserDataShenPZhT:Array<Detail_302_ShenPZhT> = [] // 审批状态
    var currentDataShenPZhT:Detail_302_ShenPZhT!
    var parserDataPingBJG:Array<Detail_302_PingBJG> = [] //评标结果
    var currentDataPingBJG:Detail_302_PingBJG!
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
            //                            println(str)
            var ps = ProcessData(proData:conData.connectionData(ur, soapStr: soapStr))
            //
            parserXml = NSXMLParser(data: ps.returnTo)
            parserXml.delegate = self
            parserXml.shouldProcessNamespaces = true
            parserXml.shouldReportNamespacePrefixes = true
            parserXml.shouldResolveExternalEntities = true
            parserXml.parse()
            if currentDataPingBJG == nil {
//                var alert = UIAlertView(title: "提示", message: "没有需要处理的业务", delegate: self, cancelButtonTitle: "确定")
//                alert.show()
                currentDataPingBJG = Detail_302_PingBJG()
                parserDataPingBJG.append(currentDataPingBJG)
            }
            if currentDataShenPZhT == nil {
//                var alert = UIAlertView(title: "提示", message: "没有需要处理的业务", delegate: self, cancelButtonTitle: "确定")
//                alert.show()
                currentDataShenPZhT = Detail_302_ShenPZhT()
                parserDataShenPZhT.append(currentDataShenPZhT)
            }
            if parserDataBase == nil {
//                var alert = UIAlertView(title: "提示", message: "没有需要处理的业务", delegate: self, cancelButtonTitle: "确定")
//                alert.show()
                parserDataBase = Detail_302_Base()
            }
            
            
            //            println("parserDataBase.businessId:\(parserDataBase.businessCode)")
        }
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [NSObject : AnyObject]) {
        currentNodeName = elementName
        //      println("start:\(elementName)")
        if currentNodeName == "appDataDetail"
        {
            parserDataBase = Detail_302_Base() //初始化基本信息数据
        }
        //评标结果
        if currentNodeName == "appTenderInformationDetails" {
            currentDataPingBJG = Detail_302_PingBJG()
            parserDataPingBJG.append(currentDataPingBJG)
        }
        // 审批状态
        if currentNodeName == "appStateDetails" {
            currentDataShenPZhT = Detail_302_ShenPZhT()
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
                parserDataBase.projectname = str
            case "matId":
                parserDataBase.matId = str
            case "sumMatMoney":
                parserDataBase.sumMatMoney = str
            case "currencyTypeName":
                parserDataBase.currencyTypeName = str
            case "invoiceTypeName":
                parserDataBase.invoiceTypeName = str
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
                parserDataBase.Pack = str
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
                //评标结果
            case "providerName":
                currentDataPingBJG.providerName = str
            case "sumQuoteMoney":
                currentDataPingBJG.sumQuoteMoney = str
            case "deliveryDateText":
                currentDataPingBJG.deliveryDateText = str
            case "jsScore":
                currentDataPingBJG.jsScore = str
            case "swScore":
                currentDataPingBJG.swScore = str
            case "sumScore":
                currentDataPingBJG.sumScore = str
            case "ranking":
                currentDataPingBJG.Ranking = str
            case "bidPhasePtNum":
                currentDataPingBJG.bidPhasePtNum = str
            case "resultMoney":
                currentDataPingBJG.resultMoney = str
            case "isConfirm":
                currentDataPingBJG.isConfirm = str
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
                currentDataShenPZhT.approveComment = str
            case "approveUnitName":
                currentDataShenPZhT.approveUnitName = str
            case "approveDegree":
                currentDataShenPZhT.approveDegree = str
                
                //平台缺少物资信息
                //与上面一样，怎样区别？
                //定义bool变量区别呀呀呀呀，哈哈哈
            default:
                println("default302:\(currentNodeName):\(str)")
            }
        }
        
    }
    
}
