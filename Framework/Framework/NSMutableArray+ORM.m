//
//  NSArray+ORM.m
//  ORM
//
//  Created by Dan Kalinin on 5/12/18.
//

#import "NSMutableArray+ORM.h"
#import <Helpers/Helpers.h>



@implementation NSMutableArray (ORM)

- (instancetype)executeFetchRequest:(NSFetchRequest *)request {
    if (request.entity) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@", KeyEntity, request.entity];
        [self filterUsingPredicate:predicate];
    }
    
    if (request.predicate) {
        [self filterUsingPredicate:request.predicate];
    }
    
    if (request.sortDescriptors.count > 0) {
        [self sortUsingDescriptors:request.sortDescriptors];
    }
    
    return self;
}

@end
