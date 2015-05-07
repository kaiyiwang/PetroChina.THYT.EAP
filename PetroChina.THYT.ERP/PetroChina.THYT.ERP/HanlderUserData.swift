//
//  HanlderUserData.swift
//  PetroChina.THYT.ERP
//
//  Created by zhaitingting on 14/11/21.
//  Copyright (c) 2014年 PetroChina. All rights reserved.
//

import UIKit

class HanlderUserData: NSObject ,NSXMLParserDelegate{

    
    var parserXml:NSXMLParser!
    var currentNodeName:String!
    var dataNiXDW:Array<UserUnit> = [] //拟选单位
    var currentDataNiXDW:UserUnit!
    override init()
    {
        super.init()
    }
    
    func connectToUrl() {
        parserXml = NSXMLParser(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("userAndUnit", ofType: "xml")!))
        parserXml.delegate = self
        parserXml.shouldProcessNamespaces = true
        parserXml.shouldReportNamespacePrefixes = true
        parserXml.shouldResolveExternalEntities = true
        parserXml.parse()
        
        if currentDataNiXDW == nil {
            currentDataNiXDW = UserUnit()
            dataNiXDW.append(currentDataNiXDW)
        }
//        for obj in dataNiXDW {
//            println(obj.unitname)
//        }
        setPersons_Global(dataNiXDW)
//        println("dataNiXDW[1].unitname:\(dataNiXDW[1].email)")
    }
    
    
    
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [NSObject : AnyObject]) {
            currentNodeName = elementName
        if currentNodeName == "item" {
            currentDataNiXDW = UserUnit()
            dataNiXDW.append(currentDataNiXDW)
        }
        
    }
    func parser(parser: NSXMLParser, foundCharacters string: String?) {
        
                var str = string!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
      
        switch currentNodeName {
        case "email":
            if currentDataNiXDW.email == "" {
                currentDataNiXDW.email = str
            }
        case "userid":
            if currentDataNiXDW.userid == "" {
                currentDataNiXDW.userid = str
            }
            
        case "unitid":
            if currentDataNiXDW.unitid == "" {
                currentDataNiXDW.unitid = str
            }
        case "unitname":
            if currentDataNiXDW.unitname == "" {
                currentDataNiXDW.unitname = str
            }
            
        default:
            if str == "" {
                
            }else{
                  print()
            }
        
        }
        
        
    }
    

    

}
