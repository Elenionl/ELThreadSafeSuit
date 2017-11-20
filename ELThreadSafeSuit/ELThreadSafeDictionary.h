//
//  ELThreadSafeDictionary.h
//  ELThreadSafeHelper
//
//  Created by Elenion on 2017/11/20.
//  Copyright © 2017年 Elenion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ELThreadSafeDictionary: NSObject

@end

@interface ELThreadSafeDictionary (ELThreadSafe)

- (BOOL)el_isThreadSafe;
- (instancetype)normalDictionary;
+ (instancetype)threadSafeDictionary;
+ (instancetype)threadSafeDictionaryWithCapacity:(NSUInteger)numItems;

@end

@interface NSDictionary (ELThreadSafe)

- (NSMutableDictionary *)threadSafeMutableCopy;

@end

