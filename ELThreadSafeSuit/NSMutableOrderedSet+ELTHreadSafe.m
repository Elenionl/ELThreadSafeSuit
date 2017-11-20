//
//  NSMutableOrderedSet+ELTHreadSafe.m
//  ELThreadSafeSuit
//
//  Created by Elenion on 2017/11/20.
//  Copyright © 2017年 Elenion. All rights reserved.
//

#import "NSMutableOrderedSet+ELTHreadSafe.h"
#import "ELThreadSafeObject.h"

@interface ELThreadSafeOrderSet: ELThreadSafeObject

@end

@implementation ELThreadSafeOrderSet

+ (void)load {
    [super load];
    [ELThreadSafeOrderSet setEl_threadSafeFilterActionForClass:^BOOL(SEL aSelector) {
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
}

- (BOOL)isNSOrderedSet__ {
    return true;
}

@end

@implementation NSMutableOrderedSet (ELThreadSafe)

- (instancetype)el_threadSafeObject {
    ELThreadSafeOrderSet *object = [[ELThreadSafeOrderSet alloc] initWithInnerObject:self];
    return (NSMutableOrderedSet *)object;
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

