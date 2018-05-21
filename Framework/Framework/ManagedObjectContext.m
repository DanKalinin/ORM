//
//  ManagedObjectContext.m
//  ORM
//
//  Created by Dan Kalinin on 5/15/18.
//

#import "ManagedObjectContext.h"
#import "MergePolicy.h"



@interface ManagedObjectContext ()

@end



@implementation ManagedObjectContext

- (instancetype)initWithConcurrencyType:(NSManagedObjectContextConcurrencyType)ct {
    self = [super initWithConcurrencyType:ct];
    if (self) {
        self.retainsRegisteredObjects = YES;
        self.automaticallyMergesChangesFromParent = YES;
        self.mergePolicy = [MergePolicy.alloc initWithMergeType:NSMergeByPropertyObjectTrumpMergePolicyType];
    }
    return self;
}

@end
