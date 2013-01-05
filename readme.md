# NecroCache: an LRU that brings things back from the dead

This is simple NSCache wrapper that provides the ability to reach past the ends of the LRU and "resurrect" objects that would have been a cache miss.


With NSCache, when an object falls out of the LRU, the cache forgets about it.  This is unfortunate behavior because the object may still exist in memory being held by someone else, perhaps for a long time.  A cache miss for an object stiill in memory could cause expensive operations to be repeated like image resizing etc. NecroCache changes that.


It does this by maintaining a weak reference to all objects inserted.  If NSCache misses, it checks the weak reference.  If it is not nil, it means the object has not been dealloc'ed yet, so we return it!  Hooray, extra cache hits!

It uses the same interface as NSCache.

It relies on the convenient [SFExecuteOnDealloc category](https://github.com/krzysztofzablocki/NSObject-SFExecuteOnDealloc) (included for convenience).

## Demo
There is a small sample in the AppDelegate:

    NSCache * c = [[NecroCache alloc] init];
    [c setCountLimit:3];
    for (int i = 0; i< 10; i ++) {
        [c setObject:[NSString stringWithFormat:@"object %d", i] forKey:[NSString stringWithFormat:@"%d", i]];
    }


With a regular NSCache, only the 3 most recent objects would still be in the cache.  But because the autoreleasepool still has the objects in memory, NecroCache can successfully return them.

Once the autoreleasepool is finished, NecroCache loses them, and they will be a cache miss, so no leaked memory. (There is a slight memory overhead in keys and associated objects, but not much).

