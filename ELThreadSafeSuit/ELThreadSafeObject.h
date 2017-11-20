//
//  ELThreadSafeObject.h
//  ELThreadSafeSuit
//
//  Created by Elenion on 2017/11/20.
//  Copyright © 2017年 Elenion. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef BOOL(^ELThreadSafeFilterAction)(SEL aSelector);

@interface NSObject (ELThreadSafe)

- (BOOL)el_isThreadSafe;
- (instancetype)el_normalObject;
- (instancetype)el_threadSafeObject;

@property (class, nonatomic, copy) ELThreadSafeFilterAction el_threadSafeFilterActionForClass;
@property (nonatomic, copy) ELThreadSafeFilterAction el_threadSafeFilterActionForInstance;

@end
