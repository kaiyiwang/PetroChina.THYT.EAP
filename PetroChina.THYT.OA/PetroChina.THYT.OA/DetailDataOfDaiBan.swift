//
//  DetailDataOfDaiBan.swift
//  PetroChina.THYT.OA
//
//  Created by zhaitingting on 14/11/14.
//  Copyright (c) 2014年 PetroChina. All rights reserved.
//

import UIKit

class DetailDataOfDaiBan: NSObject,NSURLConnectionDataDelegate,NSXMLParserDelegate {
    
    var parserXml:NSXMLParser!
    var parserDataBase:GetDetailData_Base! //存储当前环节基本信息
    var parserDataActionList:Array<GetDetailData_ActionList> = [] //存储的流转环节
    var currentAction:GetDetailData_ActionList! //当前的流转环节
    var parserDataFieldInfoList:Array<GetDetailData_FieldInfoList> = [] //存储的页面信息
    var currentFieldInfo:GetDetailData_FieldInfoList! //当前解析的信息
    var parserData_OpinionList:Array<GetDetailData_OpinionList> = [] //公文流转的历史意见集合
    var currentOpinionList:GetDetailData_OpinionList!
//    var parserData:Array<DaiBanData> = [] //存储代办信息
//    var currentParserData:DaiBanData! //存储一组代办信息
    var currentNode:NSString! //存储当前节点信息
    override init() {
        super.init()
    }
    func connectToUrl(ur:NSString,soapStr:NSString) {
        var conData = ReturnHttpConnection() // 获取返回的数据类对象
        var dataLast = conData.connectionData(ur, soapStr: soapStr)
        var str = NSString(data: dataLast, encoding: NSUTF8StringEncoding)
        NSLog("------------详细代办数据\(str)")
        if  str == "nil"{
//            var alert = UIAlertView(title: "提示", message: "请开启网络连接", delegate: self, cancelButtonTitle: "确定")
//            alert.show()
            println("网络没有连接")
        }else {
            //测试数据
            parserXml = NSXMLParser(data:dataLast)
            parserXml.delegate = self
            parserXml.shouldProcessNamespaces = true
            parserXml.shouldReportNamespacePrefixes = true
            parserXml.shouldResolveExternalEntities = true
            parserXml.parse()
//            setParserData_DaiBan(parserData)//获取到数据后保存到本地的全局变量中
            //println("setParserData_DaiBan")
            if currentAction == nil {
                currentAction = GetDetailData_ActionList()
                parserDataActionList.append(currentAction)
            }
            if currentFieldInfo == nil {
                currentFieldInfo = GetDetailData_FieldInfoList()
                parserDataFieldInfoList.append(currentFieldInfo)
            }
            if currentOpinionList == nil {
                currentOpinionList = GetDetailData_OpinionList()
                parserData_OpinionList.append(currentOpinionList)
            }

            if parserDataBase == nil {
                
                parserDataBase = GetDetailData_Base()
//                var alert = UIAlertView(title: "提示", message: "数据获取错误", delegate: self, cancelButtonTitle: "确定")
//                            alert.show()
                
            }
                       
//            println("parsercount allDataOfDaiBan:\(parserData.count)")
        }
        
    }
    
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [NSObject : AnyObject]) {
        currentNode = elementName
        //        println("element:\(elementName)")
        if currentNode == "return" {
            parserDataBase = GetDetailData_Base()
        }
        if currentNode == "actionList"
        {
            currentAction = GetDetailData_ActionList()
            parserDataActionList.append(currentAction)
        }
        if currentNode == "fieldInfoList"
        {
            currentFieldInfo = GetDetailData_FieldInfoList()
            parserDataFieldInfoList.append(currentFieldInfo)
        }
        if currentNode == "opinionList" {
            currentOpinionList = GetDetailData_OpinionList()
            parserData_OpinionList.append(currentOpinionList)
        }
            
    }
    func parser(parser: NSXMLParser, foundCharacters string: String?) {
//                println("str:\(string)")
        var str = string!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        if str != ""{
            //存储当前环节基本信息
            switch currentNode {
            case "workflowid":
                parserDataBase.workflowid = str
            case "flowid":
                parserDataBase.flowid = str
            case "flowname":
                parserDataBase.flowname = str
            case "stepid":
                parserDataBase.stepid = str
            case "stepname":
                if parserDataBase.stepname == "" {
                     parserDataBase.stepname = str
                }
            case "doccategory":
                parserDataBase.doccategory = str
            case "bt":
                parserDataBase.bt = str
            case "title":
                parserDataBase.title = str
                //存储的流转环节
            case "actionId":
                currentAction.actionId = str
            case "actionName":
                currentAction.actionName = str
            case "actor":
                currentAction.actor = str
                //存储的页面信息
            case "name":
                currentFieldInfo.name = str
            case "value":
                currentFieldInfo.value = str
            case "field":
                currentFieldInfo.field = str
            case "readonly":
                currentFieldInfo.readonly = str
            case "flag":
                currentFieldInfo.flag = str
            case "type":
                currentFieldInfo.type = str
                //公文流转的历史意见集合
            case "userid":
                currentOpinionList.userid = str
            case "rtime":
                currentOpinionList.rtime = str
            case "opinion":
                currentOpinionList.opinion = str
            default:
                println("DetailDataOfDaiBan:\(currentNode):\(str)")
            }
        }
    }

}
