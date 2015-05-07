//
//  DataClass602Base.swift
//  PortTest
//  602基本信息 appBasicInformation
//  Created by zhaitingting on 14-10-21.
//  Copyright (c) 2014年 zhaitingting. All rights reserved.
//

import UIKit

class Detail_602_Base: NSObject {
    
    var approveId:String = ""//待办审批业务编号
    var personTaskId:String = ""//个人待办工作编号
    var businessId:String = ""//待办业务名称
    var admitId:String = ""//业务主键
    var providerDetailId:String = ""//准入序号
    var tempProviderId:String = ""//供应商序号
    var providerName:String = ""//供应商名称
    var organizeNum:String = ""//组织机构代码
    var businessCode:String = ""//营业执照注册号
    var providerAddr:String = ""//住所
    var registerMoney:String = ""//注册资金
    var juridicalPerson:String = ""//法定代表人姓名
    var juridicalIdCard:String = ""//法定代表人身份证号
    var bentrustPerson:String = ""//被授权人姓名
    var bentrustIdCard:String = ""//被授权人身份证号码
    var linkPerson:String = ""//联系人
    var linkCellphone:String = ""//联系手机号
    var createCate:String = ""//预约日期
    var email:String = "" //邮箱
    var providerKindName:String = ""//相对人性质
    var providerLevelName:String = ""//单位类别
    var acceptUnitName:String = ""//预审单位
    var marketScope:String = ""//经营范围
    var ishse:String = ""//需要安全环保处审核(1 是，0否 否则不选中)
    var approveComment:String = ""//上次审批意见
    var admitTypeId:String = ""//准入类型
    var appoverAdmitscope:String = ""//服务类批准准入范围
    var admitScope:String = ""//服务类准入范围
    var productIsPassed:String = ""//产品信息审批是否通过
    var wzRemark:String = ""//物资备注
   
}
