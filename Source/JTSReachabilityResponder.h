//
//  JTSReachabilityResponder.h
//  JTSReachability
//
//  Created by Jared Sinclair on 12/9/13.
//  Copyright (c) 2013 Nice Boy LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JTSReachability.h"

typedef void(^JTSReachabilityHandler)(JTSNetworkStatus status);

@interface JTSReachabilityResponder : NSObject

/**
 Singleton instance if that's what suits you.
 */
+ (instancetype)sharedInstance;

/**
 Can also be instantiated this way.
 @param hostname Optional hostname to use for determining reachability status.
 
 If you don't specify a hostname, there are some edge cases where Reachability will
 assume there's a valid reachable connection (e.g. local WiFi network without a
 connection to the Internet proper).
 */
- (instancetype)initWithOptionalHostname:(NSString *)hostname;

/**
 Registers a handler for status changes. Must be called on the main thread.
 */
- (void)addHandler:(JTSReachabilityHandler)handler forKey:(NSString *)key;

/**
 Unregisters a handler for status changes. Must be called on the main thread.
 */
- (void)removeHandlerForKey:(NSString *)key;

/**
 Returns the most recent network status.
 */
- (JTSNetworkStatus)networkStatus;

/**
 Convenience method for determining whether there is a reachable connection.
 */
- (BOOL)isReachable;

@end
