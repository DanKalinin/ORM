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
        self.context = [ManagedObjectContext.alloc initWithConcurrencyType:NSMainQueueConcurrencyType];
        self.context.parentContext = self.newSyncContext;
    }
    return self;
}

- (instancetype)initWithName:(NSString *)name bundle:(NSBundle *)bundle {
    NSURL *url = [bundle URLForResource:name withExtension:ExtensionMOMD];
    NSManagedObjectModel *model = [NSManagedObjectModel.alloc initWithContentsOfURL:url];
    self = [self initWithName:name managedObjectModel:model];
    return self;
}

- (ManagedObjectContext *)newSyncContext {
    ManagedObjectContext *context = [ManagedObjectContext.alloc initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    context.persistentStoreCoordinator = self.persistentStoreCoordinator;
    return context;
}

@end
