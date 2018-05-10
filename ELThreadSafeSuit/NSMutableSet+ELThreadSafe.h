//
//  NSMutableSet+ELThreadSafe.h
//  ELThreadSafeSuit
//
//  Created by Elenion on 2017/11/21.
//  Copyright © 2017年 Elenion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+ELThreadSafe.h"

@interface NSMutableSet (ELThreadSafe)

+ (instancetype)el_threadSafeSet;
+ (instancetype)el_threadSafeSetWithCapacity:(NSUInteger)numItems;

@end

@interface NSSet (ELThreadSafe)

- (NSMutableArray *)el_threadSafeMutableCopy;

@end
