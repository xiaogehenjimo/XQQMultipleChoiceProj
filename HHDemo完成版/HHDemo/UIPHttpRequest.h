//
//  UIPHttpRequest.h
//  UIPowerTestProj
//
//  Created by XQQ on 16/8/3.
//  Copyright © 2016年 UIP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface UIPHttpRequest : NSObject
+ (void)startRequestFromUrl:(NSString*)url AndParameter:(NSDictionary*)parameter returnData:(void (^)(NSData * resultData,NSError * error))returnBlock;
@end
