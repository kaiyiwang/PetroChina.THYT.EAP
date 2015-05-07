//
//  GetDetailData_ ActionList.swift
//  PetroChina.THYT.OA
//  选择流转环节
//  Created by zhaitingting on 14/11/14.
//  Copyright (c) 2014年 PetroChina. All rights reserved.
//

import UIKit

class GetDetailData_ActionList: NSObject {
    var actionId:NSString = "" //操作ID
    var actionName:NSString = "" //操作名称
    var actor:NSString = "" //该做操可以选择的用户，格式为,name1,name2,;,id1,id2,（如果只有一个用户选择，则可以不需用户选择，提交流程时直接传递回即可）
}
