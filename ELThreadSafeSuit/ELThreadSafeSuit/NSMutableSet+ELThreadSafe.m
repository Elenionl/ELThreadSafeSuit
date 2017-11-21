//
//  NSMutableSet+ELThreadSafe.m
//  ELThreadSafeSuit
//
//  Created by Elenion on 2017/11/21.
//  Copyright © 2017年 Elenion. All rights reserved.
//

#import "NSMutableSet+ELThreadSafe.h"
#import "ELThreadSafeObject.h"

@implementation NSMutableSet (ELThreadSafe)

- (instancetype)el_threadSafeObject {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSMutableSet setEl_threadSafeFilterActionForClass:^BOOL(SEL aSelector) {
            if (!aSelector) {
                return false;
            }
            NSString *selectorName = NSStringFromSelector(aSelector);
            if ([selectorName hasPrefix:@"add"]) {
                return true;
            }
            if ([selectorName hasPrefix:@"remove"]) {
                return true;
            }
            if ([selectorName hasPrefix:@"setSet"]) {
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
            if ([selectorName hasPrefix:@"filter"] && ![selectorName hasPrefix:@"filtered"]) {
                return true;
            }
            return false;
        }];
    });
    return [super el_threadSafeObject];
}

+ (instancetype)el_threadSafeSet {
    NSMutableSet *object= [[[NSMutableSet alloc] init] el_threadSafeObject];
    return object;
}

+ (instancetype)el_threadSafeSetWithCapacity:(NSUInteger)numItems {
    NSMutableSet *object = [[[NSMutableSet alloc] initWithCapacity:numItems] el_threadSafeObject];
    return object;
}

@end

@implementation NSSet (ELThreadSafe)

- (NSMutableArray *)el_threadSafeMutableCopy {
    return [self.mutableCopy el_threadSafeObject];
}

@end
