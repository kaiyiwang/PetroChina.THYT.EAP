//
//  commonFunc.swift
//  PetroChina.THYT.ERP
//
//  Created by zhaitingting on 14/11/21.
//  Copyright (c) 2014年 PetroChina. All rights reserved.
//

import Foundation

var persons_Global:Array<UserUnit> = [] //映射信息

func setPersons_Global(strArray:Array<UserUnit>){
    println("set")
    persons_Global = strArray
}

func getPersons_Global() -> Array<UserUnit> {
    println("get")
    return persons_Global
}

var YouXiang_Global:NSString = "" //用户登录的邮箱名字
//lhzwzc
func setYouXiang_Global(email:NSString) {
    NSLog("--------------set Youxiang")
    YouXiang_Global = email
}

func getYouXiang_Global() -> NSString {
    NSLog("--------------get Youxiang")
    return YouXiang_Global
}

var UserId_Global:NSString = "" //用户名
var UnitId_Global:NSString = "" //单位代码

func setUserId_Global(userId:NSString) {
    UserId_Global = userId
}
func getUserId_Global() -> NSString {
    return UserId_Global
}
func setUnitId_Global(unitId:NSString) {
    UnitId_Global = unitId
}
func getUnitId_Global() -> NSString {
    return UnitId_Global
}
//让每次不增加提醒显示的
var zhaobiaotoubiaoXianshi  = 0
var zhaobiaotanpanXianshi = 0
var hetongguanliXianshi = 0
var hetongtanpanXianshi = 0
var xuqiujihuaXianshi = 0
var gongyingshangXianshi = 0