//
//  CommonFunc.swift
//  PetroChina.THYT.OA
//
//  Created by zhaitingting on 14/11/17.
//  Copyright (c) 2014年 PetroChina. All rights reserved.
//

import Foundation

var parserData_Global:Array<DaiBanData> = [] //存储代办信息

func setParserData_DaiBan(strArray:Array<DaiBanData>){
//        println("set")
    parserData_Global = strArray
}
func getParserData_DaiBan() -> Array<DaiBanData> {
//        println("get")
    return parserData_Global
}
//获取所有的代办数据
func getDaiBanData(){
    var sendData:NSString = (DaiBanFirst_Global as String) + (YouXiang_Global as String) + (DaiBanSecond_Global as String)
    println("-----------------------------------\(sendData)")
    var bb = allDataOfDaiBan()
    bb.connectToUrl(UrlString_Global, soapStr: sendData)
    
    //设置菊花是否显示
    if parserData_Global.count == 0 {
        JvHua.setHidden(false)
    }else{
        JvHua.setHidden(true)
        
    }
}

var opinionArray: Array<String> = []//存储常用意见的数组
var getOpinionFlag:Bool = false //是否获取到常用意见标识
/*
    获取用户的常用审批意见并格式化为数组类型
*/
func getChangYongYJ(){
    var yijian = ParseCommenOpinion()
    yijian.getData(UrlString_Global, soap: commenOpinionSoap)
    
    var y: Array<CommenOpinionData> = yijian.parserDatas
    
    opinionArray = G_opinionArray(y[0])
    
    for str in opinionArray {
        println("常用意见：\(str)")
    }
    if opinionArray.count > 0 {
        getOpinionFlag = true
    }
}
/*
    格式化常用审批意见
*/
func G_opinionArray(YJGroup: CommenOpinionData) -> Array<String> {
    var array: Array<String> = YJGroup.opinion.componentsSeparatedByString("$*$")
    return array
}

/*
    获取当前时间
*/

func getCurrentTime() -> Array<NSString> {
    var date = NSDate(timeIntervalSinceNow: 28800)
    var array: Array<String> = date.description.componentsSeparatedByString(" ")
    var time = array[1].substringWithRange(Range<String.Index>(start: advance(array[1].startIndex, 0), end: advance(array[1].startIndex, 5)))
    array[1] = time
    return array
}

