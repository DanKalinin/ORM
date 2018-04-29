//
//  Main.m
//  ORM
//
//  Created by Dan Kalinin on 4/28/18.
//

#import "Main.h"










@interface ORMLoad ()

@property PersistentContainer *container;

@end



@implementation ORMLoad

@dynamic delegates;

- (instancetype)initWithContainer:(PersistentContainer *)container {
    self = super.init;
    if (self) {
        self.container = container;
        
        self.progress.totalUnitCount = container.persistentStoreDescriptions.count;
    }
    return self;
}

- (void)main {
    [self updateState:OperationStateDidBegin];
    [self updateProgress:0];
    
    [self.container loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *store, NSError *error) {
        if (error) {
            [self.errors addObject:error];
        }
        
        uint64_t completedUnitCount = self.progress.completedUnitCount + 1;
        [self updateProgress:completedUnitCount];
        
        [self.delegates ORMLoad:self didEndStore:store];
    }];
    
    [self updateState:OperationStateDidEnd];
}

#pragma mark - Helpers

- (void)updateState:(OperationState)state {
    [super updateState:state];
    
    [self.delegates ORMLoadDidUpdateState:self];
    if (state == OperationStateDidBegin) {
        [self.delegates ORMLoadDidBegin:self];
    } else if (state == OperationStateDidEnd) {
        [self.delegates ORMLoadDidEnd:self];
    }
}

- (void)updateProgress:(uint64_t)completedUnitCount {
    [super updateProgress:completedUnitCount];
    
    [self.delegates ORMLoadDidUpdateProgress:self];
}

@end










@interface ORMSync ()

@property NSMutableArray<Class> *classes;

@end



@implementation ORMSync

@dynamic delegates;

- (instancetype)initWithClasses:(NSMutableArray<Class> *)classes {
    self = super.init;
    if (self) {
        self.classes = classes;
        
        self.progress.totalUnitCount = classes.count;
    }
    return self;
}

#pragma mark - Helpers

- (void)updateState:(OperationState)state {
    [super updateState:state];
    
    [self.delegates ORMSyncDidUpdateState:self];
    if (state == OperationStateDidBegin) {
        [self.delegates ORMSyncDidBegin:self];
    } else if (state == OperationStateDidEnd) {
        [self.delegates ORMSyncDidEnd:self];
    }
}

- (void)updateProgress:(uint64_t)completedUnitCount {
    [super updateProgress:completedUnitCount];
    
    [self.delegates ORMSyncDidUpdateProgress:self];
}

@end










@interface ORM ()

@end



@implementation ORM

@dynamic delegates;

+ (instancetype)orm {
    return nil;
}

- (instancetype)init {
    self = super.init;
    if (self) {
        self.syncClass = ORMSync.class;
    }
    return self;
}

- (ORMLoad *)load {
    ORMLoad *load = [ORMLoad.alloc initWithContainer:self.container];
    [self addOperation:load];
    return load;
}

- (ORMLoad *)load:(VoidBlock)completion {
    ORMLoad *load = [self load];
    load.completionBlock = completion;
    return load;
}

- (ORMSync *)syncClasses:(NSMutableArray<Class> *)classes {
    ORMSync *sync = [self.syncClass.alloc initWithClasses:classes];
    [self addOperation:sync];
    return sync;
}

- (ORMSync *)syncClasses:(NSMutableArray<Class> *)classes completion:(VoidBlock)completion {
    ORMSync *sync = [self syncClasses:classes];
    sync.completionBlock = completion;
    return sync;
}

@end
