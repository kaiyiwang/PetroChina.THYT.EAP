//
//  ParserData.swift
//  PortTest
//
//  Created by zhaitingting on 14-10-14.
//  Copyright (c) 2014年 zhaitingting. All rights reserved.
//

import UIKit
 //存储接收到201接口数据
class List_201: NSObject {
        //数据属性
    
    var approveId:String = ""//待办审批业务编号
    var personTaskId:String = ""//个人待办工作编号
    var personTaskName:String = ""//待办业务名称
    var moduleName:String = ""//模块
    var taskName:String = ""//任务
    var inputDate:String = ""//分配时间
    var unitName:String = ""//承办单位／部门
    var trueName:String = ""//承办人
    var toTrueName:String = ""//交接给
    var consignTrueName:String = ""//委托给
    var errMsg:NSString = ""
    var errCode:NSString = ""
}
