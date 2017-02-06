//
//  HHDemoCell.m
//  HHDemo
//
//  Created by XQQ on 16/8/11.
//  Copyright © 2016年 UIP. All rights reserved.
//

#import "HHDemoCell.h"

@implementation HHDemoCell
{
    BOOL _isClicked;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        //self.backgroundColor = [UIColor yellowColor];
        
        _isClicked = NO;
        //最下方的view
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 100)];
        //_backView.backgroundColor = [UIColor orangeColor];
        _backView.userInteractionEnabled =YES;
        //选择的按钮
        _selectBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 30, 40, 40)];
        _selectBtn.backgroundColor = [UIColor redColor];
        [_selectBtn addTarget:self action:@selector(selBtnPress) forControlEvents:UIControlEventTouchUpInside];
        //显示信息的view  盖住选择的按钮
        _detailView = [[UIView alloc]initWithFrame:_backView.frame];
        
        //右侧的imageView
        _iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10,80, 80)];
        //名字的label
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_iconImageView.frame)+5, 10, _detailView.frame.size.width - 10 - 80 - 5-5, 30)];
        
        [_detailView addSubview:_iconImageView];
        [_detailView addSubview:_nameLabel];
        [_backView addSubview:_selectBtn];
        [_backView addSubview:_detailView];
        [self.contentView addSubview:_backView];
    }
    return self;
}
//选择按钮被点击
- (void)selBtnPress
{
    if (_isClicked) {
        //设置选择按钮的背景颜色 可用图片替换
        _selectBtn.backgroundColor = [UIColor redColor];
        //记录cell按钮的点击状态
        _isClicked = NO;
        //用block把按钮的点击情况传递出去
        _didSel(NO);
    }else
    {
        _selectBtn.backgroundColor = [UIColor greenColor];
        _isClicked = YES;
        _didSel(YES);
    }
}


- (void)loadDataWithModel:(HHDemoModel*)model
{
    //给model赋值
    _nameLabel.text = model.name;
    
    //判断cell 是否被点击了
    if (model.isSel) {
        //被点击了 设置背景颜色为绿色
        _selectBtn.backgroundColor = [UIColor greenColor];
        //设置按钮的点击状态为YES
        _isClicked = YES;
    }
    else
    {
        _selectBtn.backgroundColor = [UIColor redColor];
        _isClicked = NO;
    }
    
    //判断进入编辑页面的按钮是否被点击
    if (model.isShow) {
        //移动选择按钮上方的详情view的X坐标,让选择按钮显示出来
        _detailView.frame = CGRectMake(60, 0, self.frame.size.width, self.frame.size.height);
    }
    else
    {
         _detailView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        //不显示选择按钮
    }
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:model.pic]];
}

@end
