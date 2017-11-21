//
//  NSMutableOrderedSet+ELTHreadSafe.m
//  ELThreadSafeSuit
//
//  Created by Elenion on 2017/11/20.
//  Copyright © 2017年 Elenion. All rights reserved.
//

#import "NSMutableOrderedSet+ELThreadSafe.h"
#import "ELThreadSafeObject.h"

@implementation NSMutableOrderedSet (ELThreadSafe)

- (instancetype)el_threadSafeObject {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSMutableOrderedSet setEl_threadSafeFilterActionForClass:^BOOL(SEL aSelector) {
            if (!aSelector) {
                return false;
            }
            NSString *selectorName = NSStringFromSelector(aSelector);
            if ([selectorName hasPrefix:@"add"]) {
                return true;
            }
            if ([selectorName hasPrefix:@"insert"]) {
                return true;
            }
            if ([selectorName hasPrefix:@"remove"]) {
                return true;
            }
            if ([selectorName hasPrefix:@"move"]) {
                return true;
            }
            if ([selectorName hasPrefix:@"set"]) {
                return true;
            }
            if ([selectorName hasPrefix:@"replace"]) {
                return true;
            }
            if ([selectorName hasPrefix:@"exchange"]) {
                return true;
            }
            if ([selectorName hasPrefix:@"intersect"]) {
                return true;
            }
            if ([selectorName hasPrefix:@"minus"]) {
                return true;
            }
            if ([selectorName hasPrefix:@"union"]) {
                return true;
            }
            if ([selectorName hasPrefix:@"sort"] && ![selectorName hasPrefix:@"sorted"]) {
                return true;
            }
            if ([selectorName hasPrefix:@"filter"] && ![selectorName hasPrefix:@"filtered"]) {
                return true;
            }
            return false;
        }];
    });
    return [super el_threadSafeObject];
}

+ (instancetype)el_threadSafeOrderedSet {
    NSMutableOrderedSet *object = [[[NSMutableOrderedSet alloc] init] el_threadSafeObject];
    return object;
}

+ (instancetype)el_threadSafeOrderedSetWithCapacity:(NSUInteger)numItems {
    NSMutableOrderedSet *object = [[[NSMutableOrderedSet alloc] initWithCapacity:numItems] el_threadSafeObject];
    return object;
}

@end

@implementation NSOrderedSet (ELThreadSafe)

- (NSMutableOrderedSet *)el_threadSafeMutableCopy {
    return [self.mutableCopy el_threadSafeMutableCopy];
}

@end

