//
//  HHDemoCell.h
//  HHDemo
//
//  Created by XQQ on 16/8/11.
//  Copyright © 2016年 UIP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHDemoModel.h"
#import "UIImageView+WebCache.h"

typedef void (^selBtnDidPress)(BOOL isSel) ;
@interface HHDemoCell : UITableViewCell
/**
 *  最底部view
 */
@property(nonatomic, strong)  UIView  *  backView;
/**
 *  选择的button
 */
@property(nonatomic, strong)  UIButton  *  selectBtn;
/**
 *  显示详情的view
 */
@property(nonatomic, strong)  UIView  *  detailView;
/**
 * 头像
 */
@property(nonatomic, strong)  UIImageView  *  iconImageView;
/**
 *  名字lebel
 */
@property(nonatomic, strong)  UILabel  *  nameLabel;
/**
 * 选择按钮点击事件
 */
@property (nonatomic, copy)  selBtnDidPress    didSel;
- (void)loadDataWithModel:(HHDemoModel*)model;


@end
