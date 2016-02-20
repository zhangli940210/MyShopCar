//
//  ViewController.m
//  My购物车基本骨架
//
//  Created by apple on 16/2/20.
//  Copyright © 2016年 m14a.cn. All rights reserved.
//

#import "ViewController.h"
#import "LZWineCell.h"
#import "LZWine.h"

@interface ViewController () <UITableViewDataSource>

/** 购买按钮*/
@property (weak, nonatomic) IBOutlet UIButton *buyCount;

/** 酒模型数组*/
@property (nonatomic, strong) NSArray *wineArray;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
/** 总价格*/
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;
/** 购物车数组*/
@property (nonatomic, strong) NSMutableArray *shopCarArray;

@end

@implementation ViewController

#pragma mark - 懒加载数据
- (NSMutableArray *)shopCarArray
{
    if (_shopCarArray == nil) {
        _shopCarArray = [NSMutableArray array];
    }
    return _shopCarArray;
}

- (NSArray *)wineArray
{
    if (_wineArray == nil) {
        // 路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"wine.plist" ofType:nil];
        // 获取酒字典数组
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        // 定义一个可变数组
        NSMutableArray *arrM = [NSMutableArray array];
        // for循环将酒模型添加给可变数组
        for (NSDictionary *dict in array) {
            LZWine *wine = [LZWine wineWithDict:dict];
            [arrM addObject:wine];
        }
        _wineArray = arrM;
    }
    return _wineArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(plusButtonClick:) name:@"plusBtnClickName" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(minusButtonClick:) name:@"minusBtnClickName" object:nil];
}

// 添加
- (void)plusButtonClick:(NSNotification *)noti
{
    // 设置购买按钮可以点击
    self.buyCount.enabled = YES;
    // 数据类型转换
    LZWineCell *cell = noti.object;
    int totalPrice = self.totalPriceLabel.text.intValue + cell.wine.money.intValue;
    self.totalPriceLabel.text = [NSString stringWithFormat:@"%zd", totalPrice];
    
    // 先判断
    if ([self.shopCarArray containsObject:cell.wine])   return;
    // 添加模型数据
    [self.shopCarArray addObject:cell.wine];
}

// 减少
- (void)minusButtonClick:(NSNotification *)noti
{
    // 数据类型转换
    LZWineCell *cell = noti.object;
    int totalPrice = self.totalPriceLabel.text.intValue - cell.wine.money.intValue;
    self.totalPriceLabel.text = [NSString stringWithFormat:@"%zd", totalPrice];
    // 通过总价来设置购买按钮是否可点击
    self.buyCount.enabled = totalPrice > 0;
    // 移除模型数据
    if (cell.wine.count == 0) { // 判断模型数据里面的count是否为0，为0删除
        [self.shopCarArray removeObject:cell.wine];
    }
}


/**
 *  移除监听
 */
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 *  购买
 */
- (IBAction)buy {
    // 循环打印
    for (LZWine *wine in self.shopCarArray) { // 查找在购物车里面的模型数据，不需要全部的从头到尾查找一遍
        if (wine.count) {
            NSLog(@"[%@]买了%zd瓶", wine.name, wine.count);
        }
    }
}

/**
 *  清空购物车
 */
- (IBAction)clear {
    // 设置总价为0
    self.totalPriceLabel.text = @"0";
    // 设置购买按钮不可点击
    self.buyCount.enabled = NO;
    // 所有不为0的模型数据找到统统重新设为0
    for (LZWine *wine in self.shopCarArray) { // 查找在购物车里面的模型数据，不需要全部的从头到尾查找一遍
        if (wine.count) {
            wine.count = 0;
        }
    }
    // 刷新界面
    [self.tableView reloadData];
    // 清空数据
    [self.shopCarArray removeAllObjects];
}

#pragma mark - UITableViewDataSource方法

// 多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// 每组多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.wineArray.count;
}

// 每行显示的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 去缓存池里面找
    static NSString *ID = @"wine";
    LZWineCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 如果没有找到，会自动去storyboard里面找
    // 获取模型数据
    LZWine *wine = self.wineArray[indexPath.row];
    cell.wine = wine;
    
    // 返回
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
