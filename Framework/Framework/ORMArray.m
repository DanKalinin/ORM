//
//  ORMArray.m
//  ORM
//
//  Created by Dan Kalinin on 5/12/18.
//

#import "ORMArray.h"
#import <Helpers/Helpers.h>










@implementation NSArray (ORM)

- (NSArray *)arrayByExecutingFetchRequest:(NSFetchRequest *)request {
    NSMutableArray *array = self.mutableCopy;
    [array executeFetchRequest:request];
    return array;
}

@end










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
