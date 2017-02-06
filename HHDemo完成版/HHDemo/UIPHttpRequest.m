//
//  UIPHttpRequest.m
//  UIPowerTestProj
//
//  Created by XQQ on 16/8/3.
//  Copyright © 2016年 UIP. All rights reserved.
//

#import "UIPHttpRequest.h"

@implementation UIPHttpRequest
+(void)startRequestFromUrl:(NSString *)url AndParameter:(NSDictionary *)parameter returnData:(void (^)(NSData *, NSError *))returnBlock {
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //请求数据成功，无报错，回传数据
        returnBlock(responseObject,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //请求数据失败，产生报错
        returnBlock(nil,error);
    }];
}


@end


