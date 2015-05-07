//
//  DataClass602FuJXX.swift
//  PortTest
//  602附件信息 annexDetail
//  Created by zhaitingting on 14-10-21.
//  Copyright (c) 2014年 zhaitingting. All rights reserved.
//

import UIKit

class Detail_602_FuJXX: NSObject {
    var adjunctPreviewPath:String = ""//附件缩略图路径
    var adjunctTitle:String = ""//附件标题
    var adjunctPath:String = ""//附件路径
    var adjunctId:String = ""//附件编号
    var approveComment:String = ""//审批意见
    var isPassed:String = ""//审批是否通过
    var fieldName:String = ""//扩展附件信息
    //business_code营业执照扫描件，organize_num组织机构代码扫描件，
    //    tax_no 税务登记证扫描件，
    //    juridical_id_card法定代表人身份证扫描件，
    //    bentrust_id_card 被授权人身份证扫描件 ，
//    account_bank开户证扫描件，
//    is_access 一级准入证扫描件，
//    skill_id_card技术负责人身份证扫描件，
//    link_person联系人扫描件，
//    temp_provider_id企业简介扫描件，
//    finance_id_card 财务负责人身份证扫描件，
//    shldr_id_card股东附件信息
    var qualifId:String = ""//资质类型编号
    var qualifName:String = ""//资质名称
    var qualifNumber:NSString = "" //资质编号
    var admitQualifId:String = ""//附件路径
    var isExtecsion:NSInteger = 0 // 0表示是基本附件信息，1表示信息是扩展信息，2表示信息是审核附件信息
}
