//
//  UrlAndSoap.swift
//  PetroChina.THYT.OA
//  定义所有的与url和soap有关的全局变量
//  Created by zhaitingting on 14/11/13.
//  Copyright (c) 2014年 PetroChina. All rights reserved.
//

import Foundation
//wangbaoqi  OK lzlxx
var YouXiang_Global:String = "wangzkkt01" //邮箱名字
var UserInfo: UserInfoData = UserInfoData()
//webservice地址jiangtao168 0 ldx168 wu  yfchw 个人 wenbinlin chushi yexhjx erjifawen zhzhd 领导请销假 wangyntlf 开发井 wangruith 勘探

//测试服务器
//let UrlString_Global:String = "http://10.218.8.95/tuha/services/WorkflowPhoneService"
//let UrlString_Global:String = "http://127.0.0.1:10024/tuha/services/WorkflowPhoneService"
//正式服务器
//内网
//let UrlString_Global:String = "http://10.218.8.21:8080/tuha/services/WorkflowPhoneService"
//外网
let UrlString_Global:String = "http://127.0.0.1:10034/tuha/services/WorkflowPhoneService"
//malijx
let soapHeadStr:String = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ser=\"http://service.phone.workflow.rizon.com/\"><soapenv:Header/><soapenv:Body>"
let soapTailStr:String = "</soapenv:Body></soapenv:Envelope>"
//所有代办信息的soap
let DaiBanFirst_Global:String = soapHeadStr + "<ser:getAllDbsyByUserId><!--Optional:--><mailname>"
let DaiBanSecond_Global:String = "</mailname></ser:getAllDbsyByUserId>" + soapTailStr
//代办详细信息的soap
let DaiBanDetailFirst_Global:String = soapHeadStr + "<ser:getFlowDetail><workflowid>"
let DaiBanDetailSecond_Global:String = "</workflowid><!--Optional:--><mailname>"
let DaiBanDetailThird_Global:String = "</mailname></ser:getFlowDetail>" + soapTailStr

//changeDbsyState
let changeDbsyStateFirst_Global:String = soapHeadStr + "<ser:changeDbsyState><id>"
let changeDbsyStateSecond_Global:String = "</id></ser:changeDbsyState>" + soapTailStr

//getMaintext
let MainTextFirst_Global:String = soapHeadStr + "<ser:getMaintext><workflowid>"
let MainTextSecond_Global:String = "</workflowid></ser:getMaintext>" + soapTailStr
//getAttach
let AttachFirst_Global:String = soapHeadStr + "<ser:getAttach><attachId>"
let AttachSecond_Global:String = "</attachId></ser:getAttach>" + soapTailStr

//doAction
let ActionMail_Global:String = soapHeadStr + "<ser:doAction><!--Optional:--><mailname>"
let ActionId_Global:String = "</mailname><!--Optional:--><actionid>"
let ActionName_Global:String = "</actionid><!--Optional:--><actionname>"
let ActionWorkId_Global:String = "</actionname><workflowid>"
let ActionFlowId_Global:String = "</workflowid><!--Optional:--><flowid>"
let ActionFlowName_Global:String = "</flowid><!--Optional:--><flowname>"
let ActionTacheId_Global:String = "</flowname><!--Optional:--><tacheid>"
let ActionTacheName_Global:String = "</tacheid><!--Optional:--><tachename>"
let ActionNextDocCateIdNoActor_Global:String = "</tachename><!--Optional:--><nextActorid/><!--Optional:--><docCategoryId>"
//yes
let ActionNextActorIdYes_Global:String = "</tachename><!--Optional:--><nextActorid>"
let ActionNextDocCateIdHasActor:String = "</nextActorid><!--Optional:--><docCategoryId>"

let ActionDocbt:String = "</docCategoryId><!--Optional:--><docbt>"
let ActionCmdAction:String = "</docbt><!--Optional:--><cmdaction>"
let ActionFinal_Global:String = "</cmdaction><!--Optional:--><nextRoleid/><!--Zero or more repetitions:-->"

let ActionLast_Global:String = "</ser:doAction>" + soapTailStr

//getHistoryInfo_gw
let GWFirst_Global:String = soapHeadStr + "<ser:getHistoryInfo_gw><mailname>"
let GWSecond_Global:String = "</mailname><count>"
let GWThird_global:String = "<count/></ser:getHistoryInfo_gw>" + soapTailStr
//getHistoryInfo_sp
let SPFirst_Global:String = soapHeadStr + "<ser:getHistoryInfo_sp><mailname>"
let SPSecond_Global:String = "</mailname><count>"
let SPThird_Global:String = "<count/></ser:getHistoryInfo_sp>" + soapTailStr

//常用意见


var commenOpinionSoap: NSString = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ser=\"http://service.phone.workflow.rizon.com/\"><soapenv:Header/><soapenv:Body><ser:getCommonOpinion><!--Optional:--><mailname>\(getYouXiang_GloBal())</mailname></ser:getCommonOpinion></soapenv:Body></soapenv:Envelope>"
func commenOpinion() -> NSString {
    return commenOpinionSoap
}


//邮箱名字的set get方法
func setYouXiang_Global(str:String) {
    NSLog("set youxiang")
    YouXiang_Global = str
}

func getYouXiang_GloBal() -> String {
    NSLog("get youxiang")
    return YouXiang_Global
}

func setUserInfo(info:UserInfoData){
    UserInfo = info
}

func getUserInfo() -> UserInfoData{
    return UserInfo
}



