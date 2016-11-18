//
//  NSDictionary+Custom.m
//  CustomElements
//
//  Created by Thiago Holanda on 8/30/15.
//  Copyright (c) 2015 holanda.mobi. All rights reserved.
//

#import "NSDictionary+Custom.h"

#pragma mark - NSDictionary Category

@implementation NSDictionary (Custom)

- (NSNumber *) numberForKey:(NSString *) key {
    id object = [self objectForKey:key];
    if (object &&
        [object isKindOfClass:[NSNumber class]])
        return object;
    
    return nil;
}

@end


