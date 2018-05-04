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

@property NSMutableArray<id> *scopes;
@property NSManagedObjectContext *context;

@end



@implementation ORMSync

@dynamic parent;
@dynamic delegates;

- (instancetype)initWithScopes:(NSMutableArray<id> *)scopes {
    self = super.init;
    if (self) {
        self.scopes = scopes;
        
        self.progress.totalUnitCount = scopes.count;
    }
    return self;
}

- (void)main {
    self.context = [self.parent.container newBackgroundContext];
    [self.context performBlockAndWait:^{
        [self updateState:OperationStateDidBegin];
        [self updateProgress:0];
        
        while (!self.cancelled) {
            if (self.scopes.count == 0) break;
            id scope = self.scopes.firstObject;
            [self syncScope:scope];
            if (self.errors.count == 0) {
                [self.scopes removeObjectAtIndex:0];
                
                uint64_t completedUnitCount = self.progress.completedUnitCount + 1;
                [self updateProgress:completedUnitCount];
                
                [self.delegates ORMSync:self didEndScope:scope];
            } else {
                break;
            }
        }
        
        if (self.cancelled) {
        } else {
            if (self.errors.count == 0) {
                NSError *error = nil;
                if ([self.context save:&error]) {
                } else {
                    [self.errors addObject:error];
                }
            }
        }
        
        [self updateState:OperationStateDidEnd];
    }];
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

- (void)syncScope:(id)scope {
    NSLog(@"Scope - %@", scope);
}

@end










@interface ORM ()

@end



@implementation ORM

@dynamic delegates;

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

- (ORMSync *)sync:(Class)syncClass scopes:(NSMutableArray<id> *)scopes {
    ORMSync *sync = [syncClass.alloc initWithScopes:scopes];
    [self addOperation:sync];
    return sync;
}

- (ORMSync *)sync:(Class)syncClass scopes:(NSMutableArray<id> *)scopes completion:(VoidBlock)completion {
    ORMSync *sync = [self sync:syncClass scopes:scopes];
    sync.completionBlock = completion;
    return sync;
}

@end
