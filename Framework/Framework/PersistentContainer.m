//
//  PersistentContainer.m
//  ORM
//
//  Created by Dan Kalinin on 4/27/18.
//

#import "PersistentContainer.h"



@implementation PersistentContainer

- (instancetype)initWithName:(NSString *)name bundle:(NSBundle *)bundle {
    NSURL *url = [bundle URLForResource:name withExtension:@"momd"];
    NSManagedObjectModel *model = [NSManagedObjectModel.alloc initWithContentsOfURL:url];
    self = [super initWithName:name managedObjectModel:model];
    return self;
}

@end
