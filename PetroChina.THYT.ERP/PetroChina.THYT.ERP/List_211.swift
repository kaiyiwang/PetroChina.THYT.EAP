//
//  DataClass211.swift
//  PortTest
//
//  Created by zhaitingting on 14-10-17.
//  Copyright (c) 2014年 zhaitingting. All rights reserved.
//

import UIKit
//接口211数据类
class List_211: NSObject {
   
    var approveId:NSString = ""//待办审批业务编号
    var personTaskId:NSString = ""//个人待办工作编号
    var personTaskName:NSString = ""//待办业务名称
    var moduleName:NSString = ""//模块
    var taskName:NSString = ""//任务
    var inputDate:NSString = ""//分配时间
    var unitName:NSString = ""//承办单位/部门
    var trueName:NSString = ""//承办人
    var toTrueName:NSString = ""//交接给
    var consignTrueName:NSString = ""//委托给
    var errMsg:NSString = ""
    var errCode:NSString = ""
}
