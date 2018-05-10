//
//  ELThreadSafeArray.h
//  UnitTest
//
//  Created by Elenion on 2017/10/16.
//  Copyright © 2017年 Elenion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+ELThreadSafe.h"

@interface NSMutableArray (ELThreadSafe)

+ (instancetype)el_threadSafeArray;
+ (instancetype)el_threadSafeArrayWithCapacity:(NSUInteger)numItems;

@end

@interface NSArray (ELThreadSafe)

- (NSMutableArray *)el_threadSafeMutableCopy;

@end
