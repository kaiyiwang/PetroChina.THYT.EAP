//
//  URL_Global.swift
//  PetroChina.THYT.ZongHBG
//
//  Created by ZhaiTT on 15/1/13.
//  Updated by Migoo_LiWB 15/04/22
//  Copyright (c) 2015年 PetroChina. All rights reserved.
//

import Foundation

import UIKit


//let ServerIP = "http://10.218.8.35:8080/DayReport1/"//油网IP
//let tuhaauthenticservice = "http://10.218.8.109:8080/tuhaauthenticservice/IAuthenticImplPort"//权限验证服务器

let ServerIP = "http://127.0.0.1:10034/DayReport1/"//外网IP
let tuhaauthenticservice = "http://127.0.0.1:10034/tuhaauthenticservice/IAuthenticImplPort"//权限验证服务器

let MessageBox = UIAlertView(title: "加密机信息读取异常", message: "如有疑问请与系统管理员联系!", delegate: nil, cancelButtonTitle: "确定")//登录权限验证


var LoginID = ""

//生产动态（异常）
var shengchanQuanxian = "getDynamicProduction.action?type=1"
var shengchanFirst = ServerIP + shengchanQuanxian
var shengchanSencond = ServerIP + "getDynamicProduction.action?type=2"
//勘探动态（异常）
var kantandongtaiQuanxian = "ktdtsy.jsp"
var kantandongtaiFirst = ServerIP + "cyc_rb/ktdt/" + kantandongtaiQuanxian
var kantandongtaiSecond = ServerIP + "cyc_rb/ktdt/ktdt.jsp"
//开发动态（正常）
var kaifadongtaiQuanxian = "kfdtsy.jsp"
var kaifadongtaiFirst = ServerIP + "cyc_rb/kfdt/" + kaifadongtaiQuanxian
var kaifasongtaiSecond = ServerIP + "cyc_rb/kfdt/kfdt.jsp"
//库存动态（异常）
var kucundongtaiQuanxian = "kcdtsy.jsp"
var kucundongtaiFirst = ServerIP + "cyc_rb/openFlashChart/dynamic/" + kucundongtaiQuanxian
var kucundongtaiSecond = ServerIP + "cyc_rb/openFlashChart/dynamic/kcdt.jsp"
//销售动态(正常)
var xiaoshoudongQuanxian = "xsdtsy.jsp"
var xiaoshoudongtaiFirst = ServerIP + "cyc_rb/xsdt/" + xiaoshoudongQuanxian
var xiaoshoudongtaiSecond = ServerIP + "cyc_rb/xsdt/xsdt.jsp"
//权限认证
var quanxianrenzhengURL = tuhaauthenticservice
var quanxianrenzhengSTR:String = String()
var ErrorPage = "HTTP://www.mac1024.com/ErrorPage/index.html"

//应用程序内模块验证权限函数
func has(s:String)->Bool
{
    if (quanxianrenzhengSTR.rangeOfString(s) == nil)
    {
        return false
    }
    else
    {
        return true
    }
}


