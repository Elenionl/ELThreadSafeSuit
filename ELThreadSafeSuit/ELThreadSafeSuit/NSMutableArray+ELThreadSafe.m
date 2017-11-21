//
//  ELThreadSafeArray.m
//  UnitTest
//
//  Created by Elenion on 2017/10/16.
//  Copyright © 2017年 Elenion. All rights reserved.
//

#import "NSMutableArray+ELThreadSafe.h"
#import "ELThreadSafeObject.h"

@implementation NSMutableArray (ELThreadSafe)

- (instancetype)el_threadSafeObject {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSMutableArray setEl_threadSafeFilterActionForClass:^BOOL(SEL aSelector) {
            if (!aSelector) {
                return false;
            }
            NSString *selectorName = NSStringFromSelector(aSelector);
            if ([selectorName containsString:@"Observer"]) {
                return false;
            }
            if ([selectorName hasPrefix:@"add"]) {
                return true;
            }
            if ([selectorName hasPrefix:@"insert"]) {
                return true;
            }
            if ([selectorName hasPrefix:@"remove"]) {
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

+ (instancetype)el_threadSafeArray {
    NSMutableArray *object = [[[NSMutableArray alloc] init] el_threadSafeObject];
    return object;
}

+ (instancetype)el_threadSafeArrayWithCapacity:(NSUInteger)numItems {
    NSMutableArray *object = [[NSMutableArray arrayWithCapacity:numItems] el_threadSafeObject];
    return object;
}

@end

@implementation NSArray (ELThreadSafe)

- (NSMutableArray *)el_threadSafeMutableCopy {
    return [self.mutableCopy el_threadSafeObject];
}

@end
