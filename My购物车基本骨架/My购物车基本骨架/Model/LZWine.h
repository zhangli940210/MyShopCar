//
//  LZWine.h
//  My购物车基本骨架
//
//  Created by apple on 16/2/20.
//  Copyright © 2016年 m14a.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZWine : NSObject

/** 图片*/
@property (nonatomic, strong) NSString *image;
/** 价格*/
@property (nonatomic, strong) NSString *money;
/** 名称*/
@property (nonatomic, strong) NSString *name;
/** 数量*/
@property (nonatomic, assign) NSInteger count;

// 快速构造方法
- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)wineWithDict:(NSDictionary *)dict;

@end
