//
//  ViewController.m
//  HHDemo
//
//  Created by XQQ on 16/8/11.
//  Copyright © 2016年 UIP. All rights reserved.
//

#import "ViewController.h"
#import "UIPHttpRequest.h"
#import "HHDemoModel.h"
#import "HHDemoCell.h"

#define iphoneWidth  [UIScreen mainScreen].bounds.size.width
#define iphoneHeight [UIScreen mainScreen].bounds.size.height
@interface ViewController()<UITableViewDataSource,UITableViewDelegate>
/**
 *  tabelView
 */
@property (nonatomic, strong) UITableView * myTabelView;
/**
 *  数据源
 */
@property (nonatomic, strong)  NSMutableArray  *  dataArr;
/**
 * 右上角编辑按钮
 */
@property(nonatomic, strong)  UIButton  *  rightEditBtn;
/**
 *  底部的view
 */
@property(nonatomic, strong)  UIView  *  bottomView;
/**
 * 全选按钮
 */
@property(nonatomic, strong)  UIButton * allSelBtn;
/**
 * 删除按钮
 */
@property(nonatomic, strong)  UIButton * deleteBtn;
/**
 *  记录全选按钮状态
 */
@property(nonatomic, assign)  BOOL   allSelBtnIsSel;
/**
 *  记录要删除的选项
 */
@property(nonatomic, strong)  NSMutableArray  *  tmpArr;
/**
 *  记录编辑按钮选择状态
 */
@property(nonatomic, assign)  BOOL   isEditSel;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _allSelBtnIsSel = NO;
    _isEditSel = NO;
    self.navigationItem.rightBarButtonItem = ({
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:self.rightEditBtn];
        rightItem;
    });
    /**
     *  请求数据
     */
    [self requestData];
    [self.view addSubview:self.myTabelView];
    [self.view addSubview:self.bottomView];

}
#pragma mark - requestData
- (void)requestData
{
    
    
//    int const serviceID = 123934;
//    NSString * const AK = @"6hMQgTmH5sydx3UabpmqT7U4BtQM1hj0";
//    NSString * const MCODE  = @"UIP.XQQYingyanDemo";
//    double const EPSILON = 0.0001;
    
    NSString * requestStr = @"http://www.uipower.com/test/mobileTest.json";
    NSString * yingyan = @"http://api.map.baidu.com/trace/v2/entity/add";
    //http://api.map.baidu.com/trace/v2/track/addcolumn
//    @{@"ak":@"6hMQgTmH5sydx3UabpmqT7U4BtQM1hj0",@"service_id":@(123934),@"column_key":@"test123",@"mcode":@"UIP.XQQYingyanDemo",@"column_type":@(1)}
    
    
    
//    @{@"ak":@"6hMQgTmH5sydx3UabpmqT7U4BtQM1hj0",@"service_id":@(123934),@"entity_name":@"test123",@"MCODE":@"UIP.XQQYingyanDemo"}
    //http://api.map.baidu.com/trace/v2/entity/add
    
    
    
    
    //上传轨迹点
    //http://api.map.baidu.com/trace/v2/track/addpoint
    
//    NSString * guijidian = @"http://api.map.baidu.com/trace/v2/track/addpoint";
    
    
    
    AFHTTPRequestOperationManager * testManager = [AFHTTPRequestOperationManager manager];
    [testManager POST:yingyan parameters:@{@"ak":@"6hMQgTmH5sydx3UabpmqT7U4BtQM1hj0",@"service_id":@(123934),@"entity_name":@"test123",@"mcode":@"UIP.XQQYingyanDemo"} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        
        NSLog(@"成功");
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
        
        
    }];
    
    
    
    
    
    
    
    [UIPHttpRequest startRequestFromUrl:requestStr AndParameter:@{} returnData:^(NSData *resultData, NSError *error) {
        if (!error) {
            NSArray * resultArr = [NSJSONSerialization JSONObjectWithData:resultData options:NSUTF8StringEncoding error:nil];
            /**
             *  model赋值
             */
            //这个方法 后台返回多少取多少
            
//            for (NSDictionary * item in resultArr) {
//                HHDemoModel * model = [[HHDemoModel alloc]init];
//                [model setValuesForKeysWithDictionary:item];
//                [self.dataArr addObject:model];
//            }
            
            //如果想取一定个数 用这个 上面注释掉
            for (int i = 0; i < 20; i ++) {
                HHDemoModel * model = [[HHDemoModel alloc]init];
                model.isSel = NO;
                [model setValuesForKeysWithDictionary:resultArr[i]];
                [self.dataArr addObject:model];
            }
            
            [self.myTabelView reloadData];
        }else
        {
            NSLog(@"%@",error.description);
        }
    }];
}

#pragma mark - actievety
- (void)rightBarButtonItemPress
{
    if (_isEditSel) {
        [_rightEditBtn setTitle:@"编辑" forState:UIControlStateNormal];
        //隐藏
        for (HHDemoModel*item in self.dataArr) {
            item.isShow = NO;
            item.isSel = NO;
        }
        //隐藏下方的bottomView
        _bottomView.hidden = YES;
        
        _isEditSel = NO;
    }else
    {
        [_rightEditBtn setTitle:@"退出编辑" forState:UIControlStateNormal];
        //右上角编辑按钮被点击  显示选择按钮 cell的详情view的X坐标往右移动60
        for (HHDemoModel*item in self.dataArr) {
            item.isShow = YES;
            item.isSel = NO;
        }
        //是否全选状态
        if (_allSelBtnIsSel) {
            [_allSelBtn setTitle:@"全选" forState:UIControlStateNormal];
            _allSelBtnIsSel = NO;
        }
        //显示下方的bottomView
        _bottomView.hidden = NO;
        _isEditSel = YES;
    }
    
    [self.myTabelView reloadData];
}
- (void)botomBtnPress:(UIButton*)button
{
    switch (button.tag) {
        case 10086:
        {
            //全选
            if (_allSelBtnIsSel) {
                
                for (HHDemoModel * model in self.dataArr) {
                    if (model.isSel) {
                        model.isSel = NO;
                    }
                }
                [self.myTabelView reloadData];
                [_allSelBtn setTitle:@"全选" forState:UIControlStateNormal];
                _allSelBtnIsSel = NO;
            }else{
                for (HHDemoModel * model in self.dataArr) {
                    //如果没被选中 设置为选中状态
                    if (!model.isSel) {
                        model.isSel = YES;
                    }
                }
                [self.myTabelView reloadData];
                [_allSelBtn setTitle:@"取消全选" forState:UIControlStateNormal];
                _allSelBtnIsSel = YES;
            }
        }
            break;
           case 886:
        {
            //删除
            for (int i = 0; i < self.dataArr.count; i ++) {
                HHDemoModel * model = self.dataArr[i];
                //如果有被选中的model 把model放到一个数组中
                if (model.isSel) {
                    [self.tmpArr addObject:model];
                }
            }
            if (_tmpArr.count <= 0 || _tmpArr == nil) {
                //未选择任何选项
                UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"未选中任何选项" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * action = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:action];
                [self presentViewController:alert animated:YES completion:nil];
            }else
            {
                //从数据源中删掉 被选中的model
                [self.dataArr removeObjectsInArray:self.tmpArr];
                [self.tmpArr removeAllObjects];
            }
            [self.myTabelView reloadData];
        }
            break;
        default:
            break;
    }
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * idStr = @"HH";
    HHDemoCell * cell = [tableView dequeueReusableCellWithIdentifier:idStr];
    if (!cell) {
        cell = [[HHDemoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idStr];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    HHDemoModel * model = self.dataArr[indexPath.row];
    //如果cell中的选择按钮被点击了  改变model中 记录是否选中的按钮
    cell.didSel = ^(BOOL isSel)
    {
        model.isSel = isSel;
    };
    //给cell赋值
    [cell loadDataWithModel:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     HHDemoModel * model = self.dataArr[indexPath.row];
    NSLog(@"是否被选中:%ld",(long)model.isSel);
    return 100.0;
}

#pragma mark - setter&getter

- (UIButton *)rightEditBtn
{
    if (!_rightEditBtn) {
        _rightEditBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightEditBtn.frame = CGRectMake(0,3, 80,30);
        [_rightEditBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [_rightEditBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_rightEditBtn addTarget:self action:@selector(rightBarButtonItemPress) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightEditBtn;
}

- (UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, iphoneHeight - 40, iphoneWidth, 40)];
        _bottomView.backgroundColor = [UIColor colorWithRed:108/255.0 green:150 /255.0 blue:219/255.0 alpha:0.9];
        //全选按钮
        _allSelBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 5, 80, 30)];
        [_allSelBtn setTitle:@"全选" forState:UIControlStateNormal];
        [_allSelBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_allSelBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        _allSelBtn.tag = 10086;
        [_allSelBtn addTarget:self action:@selector(botomBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:_allSelBtn];
        //删除按钮
        _deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(iphoneWidth - 60 - 10, 5, 60, 30)];
        [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_deleteBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        _deleteBtn.tag = 886;
        [_deleteBtn addTarget:self action:@selector(botomBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:_deleteBtn];
        _bottomView.hidden = YES;
    }
    return _bottomView;
}

- (UITableView *)myTabelView
{
    if (!_myTabelView) {
        _myTabelView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, iphoneWidth,iphoneHeight) style:UITableViewStylePlain];
        _myTabelView.delegate = self;
        _myTabelView.dataSource = self;
        _myTabelView.clipsToBounds = YES;
    }
    return _myTabelView;
}

- (NSMutableArray *)tmpArr
{
    if (!_tmpArr) {
        _tmpArr = [[NSMutableArray alloc]init];
    }
    return _tmpArr;
}
- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc]init];
    }
    return _dataArr;
}



@end
