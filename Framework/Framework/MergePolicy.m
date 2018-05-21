//
//  MergePolicy.m
//  ORM
//
//  Created by Dan Kalinin on 5/21/18.
//

#import "MergePolicy.h"



@implementation MergePolicy

- (BOOL)resolveConflicts:(NSArray *)list error:(NSError **)error {
    BOOL result = [super resolveConflicts:list error:error];
    return result;
}

- (BOOL)resolveConstraintConflicts:(NSArray<NSConstraintConflict *> *)list error:(NSError **)error {
    BOOL result = [super resolveConstraintConflicts:list error:error];
    return result;
}

- (BOOL)resolveOptimisticLockingVersionConflicts:(NSArray<NSMergeConflict *> *)list error:(NSError **)error {
    BOOL result = [super resolveOptimisticLockingVersionConflicts:list error:error];
    return result;
}

@end
