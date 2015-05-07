//
//  allDataOfDaiBan.swift
//  PetroChina.THYT.OA
//
//  Created by zhaitingting on 14/11/13.
//  Copyright (c) 2014年 PetroChina. All rights reserved.
//

import UIKit

class allDataOfDaiBan: NSObject,NSURLConnectionDataDelegate,NSXMLParserDelegate{
    
//    var dele:DataDelegate!
    var qingqiu = ReturnHttpConnection()
    var parserXml:NSXMLParser!
    var parserData:Array<DaiBanData> = [] //存储代办信息
    var currentParserData:DaiBanData! //存储一组代办信息
    var currentNode:NSString! //存储当前节点信息
    var dataLast:NSData!
    override init() {
        super.init()
//        self.dele = self
//        qingqiu.dele = self
    }
//    func backData(data: NSData) {
//        println("backData")
//        dataLast = data
//        var str = NSString(data: dataLast, encoding: NSUTF8StringEncoding)
//        //                                            println(str)
//        //       sleep(1)
//        if  str == "nil"{
//            var alert = UIAlertView(title: "提示", message: "请开启网络连接", delegate: self, cancelButtonTitle: "确定")
//            alert.show()
//            println("网络没有连接")
//        }else {
//            //测试数据
//            parserXml = NSXMLParser(data:dataLast)
//            parserXml.delegate = self
//            parserXml.shouldProcessNamespaces = true
//            parserXml.shouldReportNamespacePrefixes = true
//            parserXml.shouldResolveExternalEntities = true
//            parserXml.parse()
//            
//            
//            //wang
//            if parserData.count == 0 {
//                currentParserData = DaiBanData()
//            }
//            
//            //println("setParserData_DaiBan")
//            //将数据获取到之后，将数据分类
//            
//            println("parsercount allDataOfDaiBan:\(parserData.count)")
//            if currentParserData == nil || currentParserData.id == "" {
//                
//                currentParserData = DaiBanData()
//                //                parserData.append(currentParserData)
//                //                var alert = UIAlertView(title: "提示", message: "没有您需要处理的业务", delegate: self, cancelButtonTitle: "确定")
//                //                alert.show()
//                
//            }
//            setParserData_DaiBan(parserData)//获取到数据后保存到本地的全局变量中
//        }
//        
//
//    }
    func connectToUrl(ur:NSString,soapStr:NSString) {
        var conData = ReturnHttpConnection() // 获取返回的数据类对象
        var dataLast = conData.connectionData(ur, soapStr: soapStr)
        var str = NSString(data: dataLast, encoding: NSUTF8StringEncoding)
                                            println(str)
//       sleep(1)
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
            

            //wang
            if parserData.count == 0 {
                 currentParserData = DaiBanData()
            }
            
            //println("setParserData_DaiBan")
            //将数据获取到之后，将数据分类
            
            println("parsercount allDataOfDaiBan:\(parserData.count)")
            if currentParserData == nil || currentParserData.id == "" {
            
                currentParserData = DaiBanData()
//                parserData.append(currentParserData)
//                var alert = UIAlertView(title: "提示", message: "没有您需要处理的业务", delegate: self, cancelButtonTitle: "确定")
//                alert.show()

            }
            //将parserData数据过滤 筛选显示的代办业务
            
            //获取到数据后保存到本地的全局变量中
            setParserData_DaiBan(pickerShowData(parserData))
        }
        
    }
    
    func pickerShowData(data:Array<DaiBanData>) -> Array<DaiBanData>{
        var finalData:Array<DaiBanData> = []
        for obj in data {
            if obj.dbsyhead.isEqualToString(GeRenShW_Global) || obj.dbsyhead.isEqualToString(ErJiDanWeiFaWen_Global) || obj.dbsyhead.isEqualToString(ErJiDanWeiShW_Global) || obj.dbsyhead.isEqualToString(ChuShiShW_Global) || obj.dbsyhead.isEqualToString(ShiYeBuShW_Global) || obj.dbsyhead.isEqualToString(LingDaoQingXiaoJiaGL_Global) || obj.dbsyhead.isEqualToString(KanTanDiZhiShenPi_Global) || obj.dbsyhead.isEqualToString(ZuanJingDiZhiSP_Global) || obj.dbsyhead.isEqualToString(ZuanJingDiZhiSPQi_Global) || obj.dbsyhead.isEqualToString(YuanGongQingXiaoJiaGL_Global) || obj.dbsyhead.isEqualToString(KaiFaJingGongChengShP_Global) || obj.dbsyhead.isEqualToString(BiaoWaiZiJinCaiWuFKShP_Global) || obj.dbsyhead.isEqualToString(CaiWuFuKuanShP_Global) || obj.dbsyhead.isEqualToString(TanJingZuanJingGongChengShP_Global){
                finalData.append(obj)
            }
        }
        return finalData
    }
    //将数据分类
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [NSObject : AnyObject]) {
        currentNode = elementName
//        println("element:\(elementName)")
        if currentNode == "return" {
            currentParserData = DaiBanData()
            parserData.append(currentParserData)
        }
    }
    func parser(parser: NSXMLParser, foundCharacters string: String?) {
//        println("str:\(string)")
        var str = string!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        if str != ""{
            switch currentNode {
            case "id":
                currentParserData.id = str
            case "title":
                currentParserData.title = str
            case "gtime":
                currentParserData.gtime = str
            case "sendername":
                currentParserData.sendername = str
            case "docid":
                currentParserData.docid = str
            case "dbsyhead":
                currentParserData.dbsyhead = str
            case "state":
                currentParserData.state = str
            default:
                println("allDataOdDaiBan:\(str)")
            }
        }
    }
    
}