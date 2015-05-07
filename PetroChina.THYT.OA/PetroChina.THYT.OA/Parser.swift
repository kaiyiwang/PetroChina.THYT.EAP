//
//  ZIXUN.swift
//  MigooAPP
//
//  Created by rongjun on 14/12/30.
//  Copyright (c) Migoo. All rights reserved.
//


import UIKit
import Foundation

class  Parser: NSObject,NSXMLParserDelegate {
    
    var currentElement: UserInfoData = UserInfoData()
    var currentNodeName: String = "" //当前节点名称
    var parserDatas: Array <UserInfoData> = []
    
    func getData(url:String, soap:NSString)->Bool {
        var urlStr = NSURL(string: url)!
        var request = NSMutableURLRequest(URL: urlStr)
        //添加请求的详细信息，与请求报文前半部分的各字段对应
        request.addValue("application/soap+xml;charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.addValue("\(soap.length)", forHTTPHeaderField: "Content-Lengh")
        //设置请求行方法为POST，与请求报文第一行对应
        request.HTTPMethod = "POST"
        //将SOAP消息加到请求中
        request.HTTPBody = soap.dataUsingEncoding(NSUTF8StringEncoding)
        //设置超时事件
        request.timeoutInterval = 5
        var data = NSData()
        if NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil) != nil {
            data = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)!
        } else {
            return false
        }
        NSLog("发送请求")
//        var data = NSData(contentsOfURL: urlStr!)
        if data.length > 0
        {
            println("请求成功")
            var parser = NSXMLParser(data:data)
            parser.delegate = self
            if (parser.parse() != false)
            {
                println("解析成功")
                return true
            }
            else
            {
                println("解析失败")
                return false
            }
        }
        else
        {
            println("请求失败")
            return false
        }
    }
    
    func parserDidEndDocument(parser: NSXMLParser) {
        for var i = 0; i < parserDatas.count; i++ {
            println(parserDatas[i].userName);
        }
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [NSObject : AnyObject]) {
        currentNodeName = elementName
        if elementName == "return" {
            parserDatas.append(currentElement)
            
        }
//        if currentNodeName == "enclosure" {
//            currentElement.enclosure = attributeDict["url"] as! String
//            println(attributeDict["url"] as! String)
//        }
        
    }
    //<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"><soap:Body><ns2:getUserInfoResponse xmlns:ns2="http://service.phone.workflow.rizon.com/"><return><flag>1</flag><userName>郭建设</userName><groupName>油田公司领导</groupName></return></ns2:getUserInfoResponse></soap:Body></soap:Envelope>
    
    //解析xml，去除中间的空格
    func parser(parser: NSXMLParser, foundCharacters string: String?) {
        var str = string!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        if str != ""
        {
            switch currentNodeName
            {
            case "flag" :
                currentElement.flag += str
                println(currentElement.flag)
            case "userName":
                currentElement.userName += str
            case "groupName" :
                currentElement.groupName += str
            default: print("")
            }
    }
        
        // println(str)
    }
    
    
    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        println("\(parseError.code.description)")
    }
}