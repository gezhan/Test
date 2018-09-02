//
//  NSMutableDictionary+SafeValue.h
//  duotin2.0
//
//  Created by Vienta on 5/6/14.
//  Copyright (c) 2014 Duotin Network Technology Co.,LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (SafeValue)

- (void)setSafeObject:(id)anObject forKey:(id<NSCopying>)aKey;

@end

@interface NSDictionary(forNSNull)
- (id)objectForKeySafely:(id)aKey;
@end


@interface NSNull(forNSDictionary)
- (id)objectForKeySafely:(id)aKey;
@end
