//
//  UrlAndSoap.swift
//  PetroChina.THYT.ERP
//
//  Created by zhaitingting on 14/12/2.
//  Copyright (c) 2014年 PetroChina. All rights reserved.
//

import Foundation
//127.0.0.1 10024
//你用longjiang ，houkangzhu，dengge，这三个人的用户编码和单位编码测试 供应商
//内网测试
//let GlobalUrl = "http://10.218.8.100:8800/ws/"
//let GlobalHeTongURL = "http://10.218.1.198/services/"

var LoginID = ""

//内网测试 西安
//let GlobalUrl = "http://10.218.8.213:8080/thwlpt/ws/"
//let GlobalHeTongURL = "http://10.218.8.213:8630/pt/services/"
//发布
let GlobalUrl = "http://127.0.0.1:10034/ws/"
let GlobalHeTongURL = "http://127.0.0.1:10034/services/"
//计划
let WuZiURL_Global:NSString = GlobalUrl+"MOVE101?wsdl"
let WuZiDetailUrl_Global:NSString = GlobalUrl+"MOVE102?wsdl"
let WuZiSendUrl_Global:NSString = GlobalUrl+"MOVE103?wsdl"
//合同
let HeTXuanShangURL_Global:NSString = GlobalUrl+"MOVE201?wsdl"
let HeTXuanShangDetailUrl_Global:NSString = GlobalUrl+"MOVE202?wsdl"
let HeTXuanShangSendUrl_Global:NSString =  GlobalUrl+"MOVE203?wsdl"
let HeTShenBaoURL_Global:NSString =  GlobalUrl+"MOVE211?wsdl"
let HeTShenBaoDetailUrl_Global:NSString =  GlobalUrl+"MOVE212?wsdl"
let HeTShenBaoSendUrl_Global:NSString =  GlobalUrl+"MOVE213?wsdl"
//招标投标
let ZhaoBiaoUrl_Global:NSString = GlobalUrl+"MOVE301?wsdl"
let ZhaoBiaoDetailUrl_Global:NSString = GlobalUrl+"MOVE302?wsdl"
let ZhaoBiaoSendUrl_Global:NSString = GlobalUrl+"MOVE303?wsdl"
let TouBiaoUrl_Global:NSString = GlobalUrl+"MOVE311?wsdl"
let TouBiaoDetailUrl_Global:NSString =  GlobalUrl+"MOVE312?wsdl"
let TouBiaoSendUrl_Global:NSString = GlobalUrl+"MOVE313?wsdl"
//供应商
let GongYingUrl_Global:NSString = GlobalUrl+"MOVE601?wsdl"
let GongYingDetailUrl_Global:NSString = GlobalUrl+"MOVE602?wsdl"
let GongYingSendUrl_Global:NSString = GlobalUrl+"MOVE603?wsdl"
//权限获取
let QuanXianHuoQuUrl:String = GlobalUrl + "LoginAuthentication?wsdl"

let QuanXianFirst:NSString = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:sap=\"http://sap.move.com/\"><soapenv:Header/><soapenv:Body><sap:LoginCheckQuery><!--Optional:--><arg0>&lt;?xml version='1.0' encoding='utf-8'?&gt;&lt;xuanShang&gt;&lt;row&gt;&lt;appUserId&gt;"
let QuanXianSecond:NSString = "&lt;/appUserId&gt; &lt;appUnitId&gt;"
let QuanXianThird:NSString = "&lt;/appUnitId&gt;&lt;/row&gt; &lt;/xuanShang&gt;</arg0></sap:LoginCheckQuery></soapenv:Body></soapenv:Envelope>"


let WuZiFirst:NSString = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:sap=\"http://sap.move.com/\"><soapenv:Header/><soapenv:Body><sap:planAppListQuery><!--Optional:--><arg0>&lt;?xml version='1.0' encoding='utf-8'?&gt;&lt;xuanShang&gt;&lt;row&gt;&lt;appUserId&gt;"
let WuZiSecond:NSString = "&lt;/appUserId&gt; &lt;appUnitId&gt;"
let WuZiThird:NSString = "&lt;/appUnitId&gt;&lt;/row&gt; &lt;/xuanShang&gt;</arg0></sap:planAppListQuery></soapenv:Body></soapenv:Envelope>"


let HeTXuanShangFirst_Global:NSString = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"xmlns:sap=\"http://sap.move.com/\" ><soapenv:Header /><soapenv:Body><sap:xuanShangAppDataList><!--Optional:--><xuanShangAppQuery>&lt;?xml version='1.0' encoding='utf-8'?&gt;&lt;xuanShang&gt;&lt;row&gt;&lt;userId&gt;"
let HeTXuanShangSecond_Global:NSString = "&lt;/userId&gt; &lt;unitId&gt;"
let HeTXuanShangThird_Global:NSString = "&lt;/unitId&gt;&lt;/row&gt; &lt;/xuanShang&gt;</xuanShangAppQuery></sap:xuanShangAppDataList></soapenv:Body></soapenv:Envelope>"


let HeTShenBaoFirst_Global:NSString = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:sap=\"http://sap.move.com/\"><soapenv:Header/><soapenv:Body><sap:shenBaoAppDataList><!--Optional:--><shenBaoAppQuery>&lt;?xml version='1.0' encoding='utf-8'?&gt;&lt;xuanShang&gt;&lt;row&gt;&lt;userId&gt;"
let HeTShenBaoSecond_Global:NSString = "&lt;/userId&gt; &lt;unitId&gt;"
let HeTShenBaoThird_Global:NSString = "&lt;/unitId&gt;&lt;/row&gt; &lt;/xuanShang&gt;</shenBaoAppQuery></sap:shenBaoAppDataList></soapenv:Body></soapenv:Envelope>"


let ZhaoBiaoFirst_Global:NSString = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:sap=\"http://sap.move.com/\"><soapenv:Header/><soapenv:Body><sap:resultAppListQuery><!--Optional:--><arg0>&lt;?xml version='1.0' encoding='utf-8'?&gt;&lt;xuanShang&gt;&lt;row&gt;&lt;appUserId&gt;"
let ZhaoBiaoSecond_Global:NSString = "&lt;/appUserId&gt; &lt;appUnitId&gt;"
let ZhaoBiaoThird_Global:NSString = "&lt;/appUnitId&gt;&lt;/row&gt; &lt;/xuanShang&gt;</arg0></sap:resultAppListQuery></soapenv:Body></soapenv:Envelope>"


let TouBiaoFirst_Global:NSString = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:sap=\"http://sap.move.com/\"><soapenv:Header/><soapenv:Body><sap:TalkResultListQuery><!--Optional:--><arg0>&lt;?xml version='1.0' encoding='utf-8'?&gt;&lt;xuanShang&gt;&lt;row&gt;&lt;appUserId&gt;"
let TouBiaoSecond_Global:NSString = "&lt;/appUserId&gt; &lt;appUnitId&gt;"
let TouBiaoThird_Global:NSString = "&lt;/appUnitId&gt;&lt;/row&gt; &lt;/xuanShang&gt;</arg0></sap:TalkResultListQuery></soapenv:Body></soapenv:Envelope>"

let GongYingFirst_Global:NSString = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:sap=\"http://sap.move.com/\"><soapenv:Header/><soapenv:Body><sap:ResultAppListQuery><!--Optional:--><arg0>&lt;?xml version='1.0' encoding='utf-8'?&gt;&lt;xuanShang&gt;&lt;row&gt;&lt;userId&gt;"
let GongYingSecond_Global:NSString = "&lt;/userId&gt; &lt;unitId&gt;"
let GongYingThird_Global:NSString = "&lt;/unitId&gt;&lt;/row&gt; &lt;/xuanShang&gt;</arg0></sap:ResultAppListQuery></soapenv:Body></soapenv:Envelope>"


