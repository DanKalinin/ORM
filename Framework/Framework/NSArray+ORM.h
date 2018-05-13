//
//  NSArray+ORM.h
//  ORM
//
//  Created by Dan Kalinin on 5/12/18.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>










@interface NSArray<ObjectType> (ORM)

- (NSArray<ObjectType> *)arrayByExecutingFetchRequest:(NSFetchRequest *)request;

@end










@interface NSMutableArray<ObjectType> (ORM)

- (void)executeFetchRequest:(NSFetchRequest *)request;

@end
