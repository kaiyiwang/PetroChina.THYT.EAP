//
//  QuanXian.swift
//  PetroChina.THYT.OA
//
//  Created by rongjun on 15/4/23.
//  Copyright (c) 2015年 PetroChina. All rights reserved.
//

import UIKit
import Foundation

class QuanXian: NSObject {
    //获取用户权限、姓名、部门名称
    var soap:NSString = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ser=\"http://service.phone.workflow.rizon.com/\"><soapenv:Header/><soapenv:Body><ser:getUserInfo><!--Optional:--><mailname>\(getYouXiang_GloBal())</mailname></ser:getUserInfo></soapenv:Body></soapenv:Envelope>"
    //<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"><soap:Body><ns2:getUserInfoResponse xmlns:ns2="http://service.phone.workflow.rizon.com/"><return><flag>1</flag><userName>郭建设</userName><groupName>油田公司领导</groupName></return></ns2:getUserInfoResponse></soap:Body></soap:Envelope>
    
    var urlstr = "http://10.218.8.95/tuha/services/WorkflowPhoneService"
    var urlstr2 = "http://10.218.8.21:8080/tuha/services/WorkflowPhoneService"
    
    var array: Array<UserInfoData> = []
    func getUserInfoData(){
        //获取权限信息
        var p = Parser()
        p.getData(urlstr, soap: soap)
        self.array = p.parserDatas
        //设置用户信息
        setUserInfo(self.array[0])
        println(getUserInfo().groupName)
        println(getUserInfo().userName)
        println(getUserInfo().flag)
    }
    
}
