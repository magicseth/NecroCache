//
//  NecroCache.h
//  NecroCache
//
//  Created by Seth Raphael on 1/4/13.
//  Copyright (c) 2013 MagicSeth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NecroCache : NSCache

@end

@interface WeakWrapper : NSObject
@property (nonatomic, weak) id contents;
@end