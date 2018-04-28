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










@interface ORM ()

@end



@implementation ORM

+ (instancetype)orm {
    return nil;
}

@end
