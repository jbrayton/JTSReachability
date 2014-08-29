JTSReachability
===============

*An adaptation of Apple's Reachability with some block-based conveniences.*

## Usage

Usage is straightforward. 

### Singleton

Access the singleton instance of `JTSReachabilityResponder` via:

```objc
+ (instancetype)sharedInstance;
```

### Or Non-Singleton, if You're Not Into the Whole Singleton Thing

Instantiate an instance of `JTSReachabilityResponder` via:

```objc
- (instancytype)initWithOptionalHostname:(NSString *)hostname;
```

If you don't specify a hostname, there are some edge cases where Apple's networking frameworks will assume there's a valid connection even when there isn't (e.g. when connected to a local WiFi network without a connection to the Internet proper).
 
### Registering Status Change Handlers

An object in your application registers a block to be executed whenever the network status changes between one of the three known states (none, Wi-fi, or cellular) as follows:

```objc
- (void)someSetupMethod {

    JTSReachabilityResponder *responder = [JTSReachabilityResponder sharedInstance];
    
    [responder addHandler:^(JTSNetworkStatus status) {
        // Respond to the value of "status"
    } forKey:@"MyReachabilityKey"];
} 
```

Your object is responsible for cleaning up after itself, typically in `dealloc`, as follows:

```objc
- (void)dealloc {

    JTSReachabilityResponder *responder = [JTSReachabilityResponder sharedInstance];
    
    [responder removeHandlerForKey:@"MyReachabilityKey"];
}
```

All blocks are called on the main thread, and must be added or removed on the main thread.
