//
//  NSMutableOrderedSet+ELTHreadSafe.h
//  ELThreadSafeSuit
//
//  Created by Elenion on 2017/11/20.
//  Copyright © 2017年 Elenion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+ELThreadSafe.h"

@interface NSMutableOrderedSet (ELThreadSafe)

+ (instancetype)el_threadSafeOrderedSet;
+ (instancetype)el_threadSafeOrderedSetWithCapacity:(NSUInteger)numItems;

@end

@interface NSOrderedSet (ELThreadSafe)

- (NSMutableOrderedSet *)el_threadSafeMutableCopy;

@end
