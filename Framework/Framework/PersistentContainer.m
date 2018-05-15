//
//  PersistentContainer.m
//  ORM
//
//  Created by Dan Kalinin on 4/28/18.
//

#import "PersistentContainer.h"
#import <Helpers/Helpers.h>



@interface PersistentContainer ()

@property ManagedObjectContext *context;

@end



@implementation PersistentContainer

- (instancetype)initWithName:(NSString *)name managedObjectModel:(NSManagedObjectModel *)model {
    self = [super initWithName:name managedObjectModel:model];
    if (self) {
        self.context = self.newContext;
    }
    return self;
}

- (instancetype)initWithName:(NSString *)name bundle:(NSBundle *)bundle {
    NSURL *url = [bundle URLForResource:name withExtension:ExtensionMOMD];
    NSManagedObjectModel *model = [NSManagedObjectModel.alloc initWithContentsOfURL:url];
    self = [self initWithName:name managedObjectModel:model];
    return self;
}

- (ManagedObjectContext *)newBackgroundContext {
    ManagedObjectContext *context = [ManagedObjectContext.alloc initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    context.persistentStoreCoordinator = self.persistentStoreCoordinator;
    return context;
}

- (ManagedObjectContext *)newContext {
    ManagedObjectContext *context = [ManagedObjectContext.alloc initWithConcurrencyType:NSMainQueueConcurrencyType];
    context.parentContext = self.newBackgroundContext;
    return context;
}

@end
