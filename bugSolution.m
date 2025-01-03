The correct approach involves creating a strong reference to the object within the block to ensure it remains valid during the block's execution:

```objectivec
@property (strong, nonatomic) NSMutableArray *myArray;

- (void)someMethod {
    [self.myArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        // Correct: Create a strong reference within the block.
        __strong typeof(obj) strongObj = obj;
        [self doSomethingWithObject:strongObj];
    }];
}
```

By using `__strong typeof(obj) strongObj = obj;`, we create a new strong reference (`strongObj`) that exists for the duration of the block's execution.  This prevents the object from being prematurely deallocated.  This is particularly important for long-running blocks or blocks which could be called after `self.myArray` is modified.  Using `typeof(obj)` ensures type safety.