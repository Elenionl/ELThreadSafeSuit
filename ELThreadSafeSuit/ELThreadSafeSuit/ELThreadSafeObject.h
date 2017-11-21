//
//  ELThreadSafeObject.h
//  ELThreadSafeSuit
//
//  Created by Elenion on 2017/11/20.
//  Copyright © 2017年 Elenion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ELThreadSafeObject<OT: NSObject *>: NSObject

@property (nonatomic, strong) OT innerObject;

- (instancetype)initWithInnerObject:(OT)innerObject;

@end


