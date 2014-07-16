JTSReachability
===============

*An adaptation of Apple's Reachability with some block-based conveniences.*

## Usage

Usage is straightforward. Access the singleton instance of `JTSReachabilityResponder` via:

```objc
- (instancetype)sharedInstance;
```

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
