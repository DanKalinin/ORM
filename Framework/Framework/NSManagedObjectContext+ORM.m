//
//  NSManagedObjectContext+ORM.m
//  ORM
//
//  Created by Dan Kalinin on 5/6/18.
//

#import "NSManagedObjectContext+ORM.h"



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
