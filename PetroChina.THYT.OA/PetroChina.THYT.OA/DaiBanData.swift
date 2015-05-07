//
//  DaiBanData.swift
//  PetroChina.THYT.OA
//  存储所有的代办信息
//  Created by zhaitingting on 14/11/13.
//  Copyright (c) 2014年 PetroChina. All rights reserved.
//

import UIKit

class DaiBanData: NSObject {
    var id:NSString = "" //待办事宜数据唯一标识
    var title:NSString = "" //待办事宜标题
    var gtime:NSString = "" //待办事宜接收时间
    var sendername:NSString = "" //待办事宜发送者
    var docid:NSString = "" //工作流ID
    var dbsyhead:NSString = "" //待办事宜分类
    var state:NSString = "" //待办状态  00：未查看   01：已查看
}
