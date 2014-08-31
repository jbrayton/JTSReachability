//
//  JTSReachabilityResponder.m
//  JTSReachability
//
//  Created by Jared Sinclair on 12/9/13.
//  Copyright (c) 2013 Nice Boy LLC. All rights reserved.
//

#import "JTSReachabilityResponder.h"

#import "JTSReachability.h"

@interface JTSReachabilityResponder ()

@property (strong, nonatomic) JTSReachability *reachabilityInstance;
@property (strong, nonatomic) NSMutableDictionary *handlers;

@end

@implementation JTSReachabilityResponder

#pragma mark - Public

+ (instancetype)sharedInstance {
    static dispatch_once_t once;
    static JTSReachabilityResponder * sharedInstance;
    dispatch_once(&once, ^ {
        sharedInstance = [[self alloc] initWithOptionalHostname:nil];
    });
    return sharedInstance;
}

- (instancetype)initWithOptionalHostname:(NSString *)hostname {
    JTSReachability *reachability = nil;
    if (hostname) {
        reachability = [JTSReachability reachabilityWithHostName:hostname];
    } else {
        reachability = [JTSReachability reachabilityForInternetConnection];
    }
    return [self initWithReachability:reachability];
}

- (BOOL)isReachable {
    return (self.networkStatus !=  NotReachable);
}

- (void)addHandler:(JTSReachabilityHandler)handler forKey:(NSString *)key {
    [_handlers setObject:handler forKey:key];
}

- (void)removeHandlerForKey:(NSString *)key {
    [_handlers removeObjectForKey:key];
}

- (JTSNetworkStatus)networkStatus {
    return _reachabilityInstance.currentReachabilityStatus;
}

#pragma mark - NSObject

- (void)dealloc {
    [self removeListening:_reachabilityInstance];
    [_reachabilityInstance stopNotifier];
}

#pragma mark - Private

- (instancetype)initWithReachability:(JTSReachability *)reachability {
    self = [super init];
    if (self) {
        _reachabilityInstance = reachability;
        [self addListening:_reachabilityInstance];
        [_reachabilityInstance startNotifier];
        _handlers = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)addListening:(JTSReachability *)reachability {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:JTSReachabilityChangedNotification object:reachability];
}

- (void)removeListening:(JTSReachability *)reachability {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:JTSReachabilityChangedNotification object:reachability];
}

- (void)reachabilityChanged:(NSNotification *)notification {
    JTSNetworkStatus status = [_reachabilityInstance currentReachabilityStatus];
    for (JTSReachabilityHandler handler in _handlers.allValues) {
        handler(status);
    }
}

@end










