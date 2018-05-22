//
//  ORMManagedObjectContext.m
//  ORM
//
//  Created by Dan Kalinin on 5/15/18.
//

#import "ORMManagedObjectContext.h"
#import "MergePolicy.h"










@interface ORMManagedObjectContext ()

@end



@implementation ORMManagedObjectContext

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










@implementation NSManagedObjectContext (ORM)

- (NSManagedObject *)findOrCreate:(NSFetchRequest *)request error:(NSError **)error {
    NSArray *objects = [self executeFetchRequest:request error:error];
    if (objects) {
        if (objects.count > 0) {
            return objects.firstObject;
        } else {
            NSManagedObject *object = [NSManagedObject.alloc initWithEntity:request.entity insertIntoManagedObjectContext:self];
            return object;
        }
    } else {
        return nil;
    }
}

- (BOOL)commit:(NSError **)error {
    NSManagedObjectContext *context = self;
    while (context) {
        if ([context save:error]) {
            context = context.parentContext;
        } else {
            return NO;
        }
    }
    return YES;
}

@end
