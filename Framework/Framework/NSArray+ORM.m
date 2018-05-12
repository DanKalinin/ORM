//
//  NSArray+ORM.m
//  ORM
//
//  Created by Dan Kalinin on 5/12/18.
//

#import "NSArray+ORM.h"










@implementation NSMutableArray (ORM)

- (void)executeFetchRequest:(NSFetchRequest *)request {
    if (request.predicate) {
        [self filterUsingPredicate:request.predicate];
    }
    
    if (request.sortDescriptors.count > 0) {
        [self sortUsingDescriptors:request.sortDescriptors];
    }
}

@end










@implementation NSArray (ORM)

- (NSArray *)arrayByExecutingFetchRequest:(NSFetchRequest *)request {
    NSMutableArray *array = self.mutableCopy;
    [array executeFetchRequest:request];
    return array;
}

@end
