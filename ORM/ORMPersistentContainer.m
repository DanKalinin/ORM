//
//  ORMPersistentContainer.m
//  ORM
//
//  Created by Dan Kalinin on 4/28/18.
//

#import "ORMPersistentContainer.h"
#import <Helpers/Helpers.h>



@interface ORMPersistentContainer ()

@property ORMManagedObjectContext *context;

@end



@implementation ORMPersistentContainer

- (instancetype)initWithName:(NSString *)name managedObjectModel:(NSManagedObjectModel *)model {
    self = [super initWithName:name managedObjectModel:model];
    if (self) {
        self.context = [self contextWithConcurrencyType:NSMainQueueConcurrencyType parentContext:nil];
    }
    return self;
}

- (instancetype)initWithName:(NSString *)name bundle:(NSBundle *)bundle {
    NSURL *url = [bundle URLForResource:name withExtension:ExtensionMOMD];
    NSManagedObjectModel *model = [NSManagedObjectModel.alloc initWithContentsOfURL:url];
    self = [self initWithName:name managedObjectModel:model];
    return self;
}

- (ORMManagedObjectContext *)contextWithConcurrencyType:(NSManagedObjectContextConcurrencyType)concurrencyType parentContext:(ORMManagedObjectContext *)parentContext {
    ORMManagedObjectContext *context = [ORMManagedObjectContext.alloc initWithConcurrencyType:concurrencyType];
    if (parentContext) {
        context.parentContext = parentContext;
    } else {
        context.persistentStoreCoordinator = self.persistentStoreCoordinator;
    }
    return context;
}

@end
