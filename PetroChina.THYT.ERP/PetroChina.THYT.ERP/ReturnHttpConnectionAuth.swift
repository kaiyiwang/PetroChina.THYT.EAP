//
//  ReturnHttpConnectionAuth.swift
//  PetroChina.THYT.ERP
//
//  Created by zhaitingting on 14/10/23.
//  Copyright (c) 2014年 PetroChina. All rights reserved.
//

import UIKit

class ReturnHttpConnectionAuth: NSObject {
    override init() {
        super.init()
    }
    func connectionData(ur:NSString,soapStr:NSString) -> NSData {
        //实现超时，默认5s
        var timeInterval = 5.0
        var url = NSURL(string: ur as String)
        //根据url创建一个请求
        var request = NSMutableURLRequest(URL: url!)
        
        //添加请求的详细信息，与请求报文前半部分的各字段对应
        request.addValue("application/soap+xml;charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.addValue("\(soapStr.length)", forHTTPHeaderField: "Content-Lengh")
        var base1:NSString = "move101:123456"
        var bb1:NSData = base1.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
        var st1 = bb1.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
        request.addValue("Basic \(st1)", forHTTPHeaderField: "Authorization")
        
        //设置请求行方法为POST，与请求报文第一行对应
        request.HTTPMethod = "POST"
        //将SOAP消息加到请求中
        request.HTTPBody = soapStr.dataUsingEncoding(NSUTF8StringEncoding)
        //设置超时事件
        request.timeoutInterval = timeInterval
        
        //        var connection = NSURLConnection(request: request, delegate: self, startImmediately: true)
        var connection = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)
        //            var str = NSString(data: connection!, encoding: NSUTF8StringEncoding)
        //            println(str)
        //如果没有网路，则连接返回空
        if connection == nil {
            //            var alert = UIAlertView(title: "", message: "请开启网络连接", delegate: self, cancelButtonTitle: "确定")
            //            alert.show()
            connection = "nil".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        }
        return connection!
    }
    
}
