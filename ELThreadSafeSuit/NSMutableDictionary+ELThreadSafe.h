//
//  ELThreadSafeDictionary.h
//  ELThreadSafeHelper
//
//  Created by Elenion on 2017/11/20.
//  Copyright © 2017年 Elenion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+ELThreadSafe.h"

@interface NSMutableDictionary (ELThreadSafe)

+ (instancetype)el_threadSafeDictionary;
+ (instancetype)el_threadSafeDictionaryWithCapacity:(NSUInteger)numItems;

@end

@interface NSDictionary (ELThreadSafe)

- (NSMutableDictionary *)el_threadSafeMutableCopy;

@end

