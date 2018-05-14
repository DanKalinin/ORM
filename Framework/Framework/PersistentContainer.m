//
//  PersistentContainer.m
//  ORM
//
//  Created by Dan Kalinin on 4/28/18.
//

#import "PersistentContainer.h"
#import <Helpers/Helpers.h>



@interface PersistentContainer ()

@property NSManagedObjectContext *syncContext;
@property NSManagedObjectContext *uiContext;

@end



@implementation PersistentContainer

- (instancetype)initWithName:(NSString *)name managedObjectModel:(NSManagedObjectModel *)model {
    self = [super initWithName:name managedObjectModel:model];
    if (self) {
        self.syncContext = self.newBackgroundContext;
        self.syncContext.retainsRegisteredObjects = YES;
        self.syncContext.automaticallyMergesChangesFromParent = YES;
        self.syncContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy;
        
        self.uiContext = [NSManagedObjectContext.alloc initWithConcurrencyType:NSMainQueueConcurrencyType];
        self.uiContext.parentContext = self.syncContext;
        self.uiContext.retainsRegisteredObjects = YES;
        self.uiContext.automaticallyMergesChangesFromParent = YES;
        self.uiContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy;
    }
    return self;
}

- (instancetype)initWithName:(NSString *)name bundle:(NSBundle *)bundle {
    NSURL *url = [bundle URLForResource:name withExtension:ExtensionMOMD];
    NSManagedObjectModel *model = [NSManagedObjectModel.alloc initWithContentsOfURL:url];
    self = [self initWithName:name managedObjectModel:model];
    return self;
}

@end
