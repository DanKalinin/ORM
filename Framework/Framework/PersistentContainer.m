//
//  PersistentContainer.m
//  ORM
//
//  Created by Dan Kalinin on 4/28/18.
//

#import "PersistentContainer.h"
#import <Helpers/Helpers.h>



@interface PersistentContainer ()

@property ORMManagedObjectContext *context;

@end



@implementation PersistentContainer

- (instancetype)initWithName:(NSString *)name managedObjectModel:(NSManagedObjectModel *)model {
    self = [super initWithName:name managedObjectModel:model];
    if (self) {
        self.context = [ORMManagedObjectContext.alloc initWithConcurrencyType:NSMainQueueConcurrencyType];
        self.context.parentContext = [self contextWithConcurrencyType:NSPrivateQueueConcurrencyType];
    }
    return self;
}

- (instancetype)initWithName:(NSString *)name bundle:(NSBundle *)bundle {
    NSURL *url = [bundle URLForResource:name withExtension:ExtensionMOMD];
    NSManagedObjectModel *model = [NSManagedObjectModel.alloc initWithContentsOfURL:url];
    self = [self initWithName:name managedObjectModel:model];
    return self;
}

- (ORMManagedObjectContext *)contextWithConcurrencyType:(NSManagedObjectContextConcurrencyType)ct {
    ORMManagedObjectContext *context = [ORMManagedObjectContext.alloc initWithConcurrencyType:ct];
    context.persistentStoreCoordinator = self.persistentStoreCoordinator;
    return context;
}

@end
