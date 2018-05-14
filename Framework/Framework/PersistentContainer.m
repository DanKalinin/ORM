//
//  PersistentContainer.m
//  ORM
//
//  Created by Dan Kalinin on 4/28/18.
//

#import "PersistentContainer.h"
#import <Helpers/Helpers.h>



@interface PersistentContainer ()

@end



@implementation PersistentContainer

@synthesize syncContext = _syncContext;
@synthesize uiContext = _uiContext;

- (instancetype)initWithName:(NSString *)name bundle:(NSBundle *)bundle {
    NSURL *url = [bundle URLForResource:name withExtension:ExtensionMOMD];
    NSManagedObjectModel *model = [NSManagedObjectModel.alloc initWithContentsOfURL:url];
    self = [self initWithName:name managedObjectModel:model];
    return self;
}

#pragma mark - Accessors

- (NSManagedObjectContext *)syncContext {
    if (_syncContext) {
    } else {
        _syncContext = self.newBackgroundContext;
    }
    return _syncContext;
}

- (NSManagedObjectContext *)uiContext {
    if (_uiContext) {
    } else {
        _uiContext = [NSManagedObjectContext.alloc initWithConcurrencyType:NSMainQueueConcurrencyType];
        _uiContext.parentContext = self.syncContext;
    }
    return _uiContext;
}

@end
