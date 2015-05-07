//
//  RecData.swift
//  PortTest
//
//  Created by zhaitingting on 14-10-13.
//  Copyright (c) 2014年 zhaitingting. All rights reserved.
//

import UIKit

//接收202接口的数据
class ERP_HeTXSh_202: NSObject ,NSURLConnectionDataDelegate,NSXMLParserDelegate{
    
    var parserXml:NSXMLParser!
    var returnValue:NSData!
    var currentNodeName:String!
    var currentParserData:Detail_202!
    var dataNiXDW:Array<Detail_202_NiXDW> = [] //拟选单位
    var currentDataNiXDW:Detail_202_NiXDW!
    var dataWenJXX:Array<Detail_202_WenJXX> = []//文件信息
    var currentDataWenJXX:Detail_202_WenJXX!
    var dataChaoSYHXX:Array<Detail_202_ChaoSYHXX> = []//抄送用户信息
    var currentDataChaoSYHXX:Detail_202_ChaoSYHXX!
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
//                        var str = NSString(data: data, encoding: NSUTF8StringEncoding)
//                        println(str)
            var ps = ProcessData(proData:conData.connectionData(ur, soapStr: soapStr))
            parserXml = NSXMLParser(data: ps.returnTo)
            parserXml.delegate = self
            parserXml.shouldProcessNamespaces = true
            parserXml.shouldReportNamespacePrefixes = true
            parserXml.shouldResolveExternalEntities = true
            parserXml.parse()
            
            //    println("end:\(currentParserData.ctrTypeName)")
            ////        connection.start()
            //        println("start")
            //如果返回的数据是空的话，则显示合同申报借口内部异常
            if currentParserData == nil {
                println("nil")
//                var alert = UIAlertView(title: "提示", message: "合同申报借口内部异常", delegate: self, cancelButtonTitle: "确定")
//                alert.show()
                currentParserData = Detail_202()
                currentParserData.ctrName = "合同申报接口内部异常"
                currentParserData.ctrTypeName = ""
                currentParserData.reportNo = ""
                currentParserData.inputPersonDept = ""
                currentParserData.fundAllocation = ""
                currentParserData.fundDitchName = ""
                currentParserData.inviteBidTypeName = ""
                currentParserData.budgetSum = ""
                currentParserData.priceTypeName = ""
                currentParserData.inviteBidKind = ""
                currentParserData.divideBid = ""
            }
            if currentDataNiXDW == nil {
                currentDataNiXDW = Detail_202_NiXDW()
                dataNiXDW.append(currentDataNiXDW)
            }
            if currentDataWenJXX == nil {
                currentDataWenJXX = Detail_202_WenJXX()
                dataWenJXX.append(currentDataWenJXX)

            }
            if currentDataChaoSYHXX == nil {
                currentDataChaoSYHXX = Detail_202_ChaoSYHXX()
                dataChaoSYHXX.append(currentDataChaoSYHXX)
            }
        }
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [NSObject : AnyObject]) {
        currentNodeName = elementName
        if currentNodeName == "appDataDetail"
        {
            currentParserData = Detail_202()//初始化一组数据
        }
        if currentNodeName == "providerDetail" {
            currentDataNiXDW = Detail_202_NiXDW()
            dataNiXDW.append(currentDataNiXDW)
        }
        if currentNodeName == "adjunctList" {
            currentDataWenJXX = Detail_202_WenJXX()
            dataWenJXX.append(currentDataWenJXX)
        }
        if currentNodeName == "appUserList" {
            currentDataChaoSYHXX = Detail_202_ChaoSYHXX()
            dataChaoSYHXX.append(currentDataChaoSYHXX)
        }
        
    }
    func parser(parser: NSXMLParser, foundCharacters string: String?) {
        
        //        var str = string.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        //        if str != ""{
        var str = string
        switch currentNodeName {
        case "ctrName":
            currentParserData.ctrName = str!
        case "ctrTypeName":
            currentParserData.ctrTypeName = str!
        case "reportNo":
            currentParserData.reportNo = str!
        case "inputPersonDept":
            currentParserData.inputPersonDept = str!
        case "fundAllocation":
            currentParserData.fundAllocation = str!
        case "fundDitchName":
            currentParserData.fundDitchName = str!
        case "inviteBidTypeName":
            currentParserData.inviteBidTypeName = str!
        case "budgetSum":
            currentParserData.budgetSum = str!
        case "priceTypeName":
            currentParserData.priceTypeName = str!
        case "inviteBidKind":
            currentParserData.inviteBidKind = str!
        case "divideBid":
            currentParserData.divideBid = str!
        case "inviteBidDesc":
            currentParserData.inviteBidDesc = str!
        case "userContact":
            currentParserData.userContact = str!
        case "userContactTel":
            currentParserData.userContactTel = str!
        case "performSpace":
            currentParserData.performSpace = str!
        case "performStandard":
            currentParserData.performStandard = str!
        case "qualityReq":
            currentParserData.qualityReq = str!
        case "valuationBasis":
            currentParserData.valuationBasis = str!
        case "suppQualReq":
            currentParserData.qualityReq = str!
        case "timeLimitDesc":
            currentParserData.timeLimitDesc = str!
        case "projectDesc":
            currentParserData.projectDesc = str!
        case "remark":
            currentParserData.remark = str!
        case "providerId":
            currentDataNiXDW.providerId = str!
        case "provider":
            currentDataNiXDW.Provider = str!
        case "adjunctId":
            currentDataWenJXX.adjunctId = str!
        case "adjunctTitle":
            currentDataWenJXX.adjunctTitle = str!
        case "adjunctPath":
            currentDataWenJXX.adjunctPath = str!
        case "approveUserId":
            currentDataChaoSYHXX.approveUserId = str!
        case "approvePerson":
            currentDataChaoSYHXX.approvePerson = str!
        case "approveUnit":
            currentDataChaoSYHXX.approveUnit = str!
            //            case "errMsg":
            //                currentParserData.errMsg = str
            //                println("Class RecData errMsg:\(str)")
            //            case "errCode":
            //                currentParserData.errCode = str
            //                println("Class RecData errCode:\(str)")
        default:
            println("default RecData202 \(currentNodeName):\(str)")
        }
        //        }
        
    }
    
    
}
