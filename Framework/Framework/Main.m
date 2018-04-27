//
//  Main.m
//  ORM
//
//  Created by Dan Kalinin on 4/27/18.
//  Copyright © 2018 Dan Kalinin. All rights reserved.
//

#import "Main.h"










@interface ORMLoad ()

@property PersistentContainer *container;

@end



@implementation ORMLoad

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
        uint64_t completedUnitCount = self.progress.completedUnitCount + 1;
        [self updateProgress:completedUnitCount];
        
        if (error) {
            [self.errors addObject:error];
        }
    }];
    
    [self updateState:OperationStateDidEnd];
}

@end










@interface ORM ()

@end



@implementation ORM

- (ORMLoad *)loadWithContainer:(PersistentContainer *)container {
    ORMLoad *load = [ORMLoad.alloc initWithContainer:container];
    [self addOperation:load];
    return load;
}

@end
