//
//  BSMCPBaseUtils.h
//  BSMCPBaseUtils
//
//  Created by 金 文俊 on 13-9-10.
//  Copyright (c) 2013年 万岩通. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSMCPBaseUtils : NSObject

/**

 *	@brief	获取应用大厅传递的参数，paramName有Version,Domain,LoginID等，urlParams为[url absoluteString]

 *

 *	@return	paramName对应的value

 */

+(NSString *)getParams:(NSString *) paramName fromeURLParams:(NSString *) urlParams;


/**
 *	@brief	获取当前设备信息，包括DeviceSN,TotalCapacity,FreeCapacity,AppCapacity
 *
 *	@return	infoType对应value
 */
//+(NSString *)getDeviceInfo:(NSString *) infoType;


@end
