//
//  ORMMain.m
//  ORM
//
//  Created by Dan Kalinin on 4/28/18.
//

#import "ORMMain.h"










@interface ORMLoad ()

@property ORMPersistentContainer *container;

@end



@implementation ORMLoad

@dynamic delegates;

- (instancetype)initWithContainer:(ORMPersistentContainer *)container {
    self = super.init;
    if (self) {
        self.container = container;
        
        self.progress.totalUnitCount = container.persistentStoreDescriptions.count;
    }
    return self;
}

- (void)main {
    [self updateState:HLPOperationStateDidBegin];
    [self updateProgress:0];
    
    [self.container loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *store, NSError *error) {
        if (error) {
            [self.errors addObject:error];
        }
        
        uint64_t completedUnitCount = self.progress.completedUnitCount + 1;
        [self updateProgress:completedUnitCount];
        
        [self.delegates ORMLoad:self didEndStore:store];
    }];
    
    [self updateState:HLPOperationStateDidEnd];
}

#pragma mark - Helpers

- (void)updateState:(HLPOperationState)state {
    [super updateState:state];
    
    [self.delegates ORMLoadDidUpdateState:self];
    if (state == HLPOperationStateDidBegin) {
        [self.delegates ORMLoadDidBegin:self];
    } else if (state == HLPOperationStateDidEnd) {
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
@property ORMManagedObjectContext *parentContext;
@property ORMManagedObjectContext *context;

@end



@implementation ORMSync

@dynamic parent;
@dynamic delegates;

- (instancetype)initWithScopes:(NSMutableArray<id> *)scopes parentContext:(ORMManagedObjectContext *)parentContext {
    self = super.init;
    if (self) {
        self.scopes = scopes;
        self.parentContext = parentContext;
        
        self.progress.totalUnitCount = scopes.count;
    }
    return self;
}

- (void)main {
    self.context = [self.parent.container contextWithConcurrencyType:NSPrivateQueueConcurrencyType parentContext:self.parentContext];
    [self.context performBlockAndWait:^{
        [self updateState:HLPOperationStateDidBegin];
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
        
        [self updateState:HLPOperationStateDidEnd];
    }];
}

#pragma mark - Helpers

- (void)updateState:(HLPOperationState)state {
    [super updateState:state];
    
    [self.delegates ORMSyncDidUpdateState:self];
    if (state == HLPOperationStateDidBegin) {
        [self.delegates ORMSyncDidBegin:self];
    } else if (state == HLPOperationStateDidEnd) {
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










@interface ORMPlistSync ()

@end



@implementation ORMPlistSync

- (void)syncScope:(Class)scope {
    NSURL *url = [scope.bundle URLForResource:[scope entity].name withExtension:ExtensionPlist];
    NSMutableArray *array = [NSMutableArray arrayWithContentsOfURL:url];
    for (NSMutableDictionary *dictionary in array) {
        NSManagedObject<HLPDictionaryDecodable> *object = [scope.alloc initWithContext:self.context];
        [object fromDictionary:dictionary];
    }
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

- (ORMSync *)sync:(Class)syncClass scopes:(NSMutableArray<id> *)scopes parentContext:(ORMManagedObjectContext *)parentContext {
    ORMSync *sync = [syncClass.alloc initWithScopes:scopes parentContext:parentContext];
    [self addOperation:sync];
    return sync;
}

- (ORMSync *)sync:(Class)syncClass scopes:(NSMutableArray<id> *)scopes parentContext:(ORMManagedObjectContext *)parentContext completion:(VoidBlock)completion {
    ORMSync *sync = [self sync:syncClass scopes:scopes parentContext:parentContext];
    sync.completionBlock = completion;
    return sync;
}

@end
