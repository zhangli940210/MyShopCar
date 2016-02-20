//
//  LZWine.m
//  My购物车基本骨架
//
//  Created by apple on 16/2/20.
//  Copyright © 2016年 m14a.cn. All rights reserved.
//

#import "LZWine.h"

@implementation LZWine

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        // KVC
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)wineWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
