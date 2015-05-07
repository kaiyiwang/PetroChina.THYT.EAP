//
//  Parser201.swift
//  PortTest
//
//  Created by zhaitingting on 14-10-13.
//  Copyright (c) 2014年 zhaitingting. All rights reserved.
//

import UIKit

//处理数据中的&gt，&lt等保留字符

class ProcessData: NSObject,NSXMLParserDelegate{
    
    var parser:NSXMLParser!
    var returnTo:NSData!
    var returnValue:NSMutableString = ""
    init(proData:NSData) {
        super.init()
        var finalData = NSString(data: proData, encoding: NSUTF8StringEncoding)
//        println("in ProcessData-----------------------finalData:\(finalData)")
        parser = NSXMLParser(data: proData)
        parser.delegate = self
        parser.shouldProcessNamespaces = true
        parser.shouldReportNamespacePrefixes = true
        parser.shouldResolveExternalEntities = true
        parser.parse()
        println("Class ProcessData end")
    }
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [NSObject : AnyObject]) {
        //       println(elementName)
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String?) {
        
        
        var str = string!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        if str != ""{
            returnValue.appendString(string!)
        }
    }
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        //        println(elementName)
    }
    func parserDidEndDocument(parser: NSXMLParser) {
//        println("in ProcessData Class ------------------returnValue:\(returnValue)")
        //获取到return回来的数据后，解析数据
        NSLog("返回的数据：\(returnValue)")
        if returnValue.isEqualToString("")||returnValue.length < 39 {
            returnTo = "".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        }else {
            var str:NSString = returnValue.substringFromIndex(38)
            returnTo = str.dataUsingEncoding(NSUTF8StringEncoding)

        }
//        parser.delegate = nil
        //        println("Parser201:end")
    }
    
    func parserDidStartDocument(parser: NSXMLParser) {
        //        println("Parser201:start")
    }
    
}
