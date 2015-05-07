//
//  GetDetailData_ FieldInfoList.swift
//  PetroChina.THYT.OA
//  显示界面详细信息
//  Created by zhaitingting on 14/11/14.
//  Copyright (c) 2014年 PetroChina. All rights reserved.
//

import UIKit

class GetDetailData_FieldInfoList: NSObject {
    var name:NSString = "" //字段汉字名称
    var value:String = "" //该字段的数据
    var field:NSString = "" //数据字段（数据库中的字段）
    var readonly:NSString = "" //是否为只读（如果为true，则该字段的数据只允许查看，不允许修改。如为false则可修改该数据）
    var flag:NSString = "" //是否必填（如果为true则该字段不允许为空，必须填写数据）
    var type:NSString = "" //字段类型（意见型字段专用，如果为“意见型”，则该数据格式应如下：）意见内容$*$签署人部门名称$*$签署人姓名$*$2011-07-18$*$20:05 ：autoSign$*$事业部物业管理部$*$刘伟$*$2011-07-18$*$20:05
 
}
