//
//  RecData.swift
//  PortTest
//
//  Created by zhaitingting on 14-10-13.
//  Copyright (c) 2014年 zhaitingting. All rights reserved.
//

import UIKit

class ERP_GongYShGL_Detail_602: NSObject ,NSURLConnectionDataDelegate,NSXMLParserDelegate{
    
    //    var dataOfReceive = NSMutableData()//存储返回的数据
    var parserXml:NSXMLParser!
    //    var returnValue:NSData!
    //   var dictDatas:Dictionary<String,String> = [:]
    //    var parserDatas:Array<DataClass601> = []
    //    var currentParserData:DataClass601!
    var parserDataBase:Detail_602_Base! //基本信息
    var parserDataChaoSR:Array<Detail_602_ChaoSR> = [] // 抄送人
    var currentDataChaoSR:Detail_602_ChaoSR!
    var parserDataFuJXX:Array<Detail_602_FuJXX> = [] //附件信息
    var currentDataFuJXX:Detail_602_FuJXX!
    var parserDataWuCQShWZXX:Array<Detail_602_WuCQShWZXX> = [] // 物采缺少物资信息
    var currentDataWuCQShWZXX:Detail_602_WuCQShWZXX!
//    var parserDataFuJShH:Array<Detail_602_FuJShenH> = [] //附件审核
//    var currentDataFuJShH:Detail_602_FuJShenH!
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
                        println("------------------------602\(str)")
            var ps = ProcessData(proData:conData.connectionData(ur, soapStr: soapStr))
            
            parserXml = NSXMLParser(data: ps.returnTo)
            parserXml.delegate = self
            parserXml.shouldProcessNamespaces = true
            parserXml.shouldReportNamespacePrefixes = true
            parserXml.shouldResolveExternalEntities = true
            parserXml.parse()
            if currentDataChaoSR == nil {
//                var alert = UIAlertView(title: "提示", message: "没有需要处理的业务", delegate: self, cancelButtonTitle: "确定")
//                alert.show()
                currentDataChaoSR = Detail_602_ChaoSR()
                parserDataChaoSR.append(currentDataChaoSR)
            }
            if parserDataBase == nil {
                parserDataBase = Detail_602_Base()
            }
            if currentDataFuJXX == nil {
                currentDataFuJXX = Detail_602_FuJXX()
                parserDataFuJXX.append(currentDataFuJXX)
            }
            if currentDataWuCQShWZXX == nil {
                currentDataWuCQShWZXX = Detail_602_WuCQShWZXX()
                parserDataWuCQShWZXX.append(currentDataWuCQShWZXX)
            }
            //            println("parserDataBase.businessId:\(parserDataBase.businessCode)")
        }
    }
    //   func connection(connection: NSURLConnection, willSendRequest request: NSURLRequest, redirectResponse response: NSURLResponse?) -> NSURLRequest? {
    //      println("request:\(request)")
    //      return request
    //   }
    //   func connection(connection: NSURLConnection, didFailWithError error: NSError) {
    //      println("error:\(error)")
    //   }
    //   func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse) {
    //      println("response:\(response)")
    //   }
    //   func connection(connection: NSURLConnection, didReceiveData data: NSData) {
    //      var str = NSString(data: data, encoding: NSUTF8StringEncoding)
    //      println(str)
    //   }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [NSObject : AnyObject]) {
        currentNodeName = elementName
        //      println("start:\(elementName)")
        if currentNodeName == "appBasicInformation"
        {
            //            currentParserData = DataClass601()//初始化一组数据
            //            parserDatas.append(currentParserData)
            parserDataBase = Detail_602_Base() //初始化基本信息数据
        }
        if currentNodeName == "admitDetail" {
            currentDataChaoSR = Detail_602_ChaoSR()
            parserDataChaoSR.append(currentDataChaoSR)
        }
        if currentNodeName == "annexDetail" {
            currentDataFuJXX = Detail_602_FuJXX()
            parserDataFuJXX.append(currentDataFuJXX)
        }
        if currentNodeName == "expansionAnnexDetail" {
            currentDataFuJXX = Detail_602_FuJXX()
            currentDataFuJXX.isExtecsion = 1
            parserDataFuJXX.append(currentDataFuJXX)
        }
        if currentNodeName == "materialProductionDetail" {
            currentDataWuCQShWZXX = Detail_602_WuCQShWZXX()
            currentDataWuCQShWZXX.isWuZQShXX = true
            parserDataWuCQShWZXX.append(currentDataWuCQShWZXX)
        }
        if currentNodeName == "platformMaterialDetail" {
            currentDataWuCQShWZXX = Detail_602_WuCQShWZXX()
            currentDataWuCQShWZXX.isWuZQShXX = false
            parserDataWuCQShWZXX.append(currentDataWuCQShWZXX)
            
        }
        if currentNodeName == "ApprovalDetail" {
            currentDataFuJXX = Detail_602_FuJXX()
            currentDataFuJXX.isExtecsion = 2
            parserDataFuJXX.append(currentDataFuJXX)
//            currentDataFuJShH = Detail_602_FuJShenH()
//            parserDataFuJShH.append(currentDataFuJShH)
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
            case "approveId":
                parserDataBase.approveId = str
            case "personTaskId":
                parserDataBase.personTaskId = str
            case "businessId":
                parserDataBase.businessId = str
            case "admitId":
                parserDataBase.admitId = str
            case "providerDetailId":
                parserDataBase.providerDetailId = str
            case "tempProviderId":
                parserDataBase.tempProviderId = str
            case "providerName":
                parserDataBase.providerName = str
            case "organizeNum":
                parserDataBase.organizeNum = str
            case "businessCode":
                parserDataBase.businessCode = str
            case "providerAddr":
                parserDataBase.providerAddr = str
            case "registerMoney":
                parserDataBase.registerMoney = str
            case "juridicalPerson":
                parserDataBase.juridicalPerson = str
            case "juridicalIdCard":
                parserDataBase.juridicalIdCard = str
            case "bentrustPerson":
                parserDataBase.bentrustPerson = str
            case "bentrustIdCard":
                parserDataBase.bentrustIdCard = str
            case "linkPerson":
                parserDataBase.linkPerson = str
            case "linkCellphone":
                parserDataBase.linkCellphone = str
            case "createCate":
                parserDataBase.createCate = str
            case "email":
                parserDataBase.email = str
            case "providerKindName":
                parserDataBase.providerKindName = str
            case "providerLevelName":
                parserDataBase.providerLevelName = str
            case "acceptUnitName":
                parserDataBase.acceptUnitName = str
            case "marketScope":
                parserDataBase.marketScope = str
            case "ishse":
                parserDataBase.ishse = str
            case "approveComment":
                parserDataBase.approveComment = str
            case "admitTypeId":
                parserDataBase.admitTypeId = str
            case "appoverAdmitscope":
                parserDataBase.appoverAdmitscope = str
            case "admitScope":
                parserDataBase.admitScope = str
            case "productIsPassed":
                parserDataBase.productIsPassed = str
            case "wzRemark":
                parserDataBase.wzRemark = str
                //抄送人
            case "approveUserId":
                currentDataChaoSR.approveUserId = str
            case "approvePerson":
                currentDataChaoSR.approvePerson = str
            case "approveUnitId":
                currentDataChaoSR.approveUnitId = str
            case "approveUnitName":
                currentDataChaoSR.approveUnitName = str
            case "tablename":
                currentDataChaoSR.tablename = str
            case "moduleName":
                currentDataChaoSR.moduleName = str
                //附件信息
            case "adjunctPreviewPath":
                currentDataFuJXX.adjunctPreviewPath = str
            case "adjunctTitle":
                currentDataFuJXX.adjunctTitle = str
            case "adjunctPath":
                currentDataFuJXX.adjunctPath = str
            case "adjunctId":
                currentDataFuJXX.adjunctId = str
            case "approveComment":
                currentDataFuJXX.approveComment = str
            case "isPassed":
                currentDataFuJXX.isPassed = str
            case "fieldName":
                currentDataFuJXX.fieldName = str
            case "qualifId":
                currentDataFuJXX.qualifId = str
            case "qualifName":
                currentDataFuJXX.qualifName = str
            case "qualifNumber":
                currentDataFuJXX.qualifNumber = str
            case "admitQualifId":
                currentDataFuJXX.admitQualifId = str
                // 物采缺少物资信息
            case "matGroupId":
                currentDataWuCQShWZXX.matGroupId = str
            case "matGroupName":
                currentDataWuCQShWZXX.matGroupName = str
            case "matLevel":
                currentDataWuCQShWZXX.matLevel = str
                //平台缺少物资信息
                //与上面一样，怎样区别？
                //定义bool变量区别呀呀呀呀，哈哈哈
            default:
                println("default gongyingshang:\(currentNodeName):\(str)")
            }
        }
        
    }
}
