//
//  HHDemoModel.h
//  HHDemo
//
//  Created by XQQ on 16/8/11.
//  Copyright © 2016年 UIP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHDemoModel : NSObject
/**
 *  跳转到详情的链接
 */
@property (nonatomic, copy)  NSString  *  content;
/**
 *  内容
 */
@property (nonatomic, copy)  NSString  *  name;
/**
 *  图片链接
 */
@property (nonatomic, copy)  NSString  *  pic;
/**
 *  是否显示选择的按钮
 */
@property(nonatomic, assign)  BOOL   isShow;
/**
 *  选择按钮是否已经选中
 */
@property(nonatomic, assign)  BOOL   isSel;


@end
