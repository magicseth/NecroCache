//
//  NecroCache.m
//  NecroCache
//
//  Created by Seth Raphael on 1/4/13.
//  Copyright (c) 2013 MagicSeth. All rights reserved.
//

#import "NecroCache.h"


@interface NecroCache ()
@property NSMutableDictionary *weakCache;
@end

@implementation NecroCache

- (id)init
{
    self = [super init];
    if (self) {
        self.weakCache = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)setObject:(id)obj forKey:(id)key cost:(NSUInteger)g; {
    [super setObject:obj forKey:key cost:g];
    WeakWrapper *ww = [[WeakWrapper alloc] init];
    [ww setContents:obj];
    [self.weakCache setObject:ww forKey:key];
}

- (void)removeObjectForKey:(id)key {
    [super removeObjectForKey:key];
    [self.weakCache removeObjectForKey:key];
}

- (void)removeAllObjects {
    [super removeAllObjects];
    [self.weakCache removeAllObjects];
}


- (id)objectForKey:(id)key {
    id obj = [super objectForKey:key];
    if (!obj) {
        obj = [[self.weakCache objectForKey:key] contents];
    }
    return obj;
}

@end


@implementation WeakWrapper

@end

