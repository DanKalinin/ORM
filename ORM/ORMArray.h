//
//  ORMArray.h
//  ORM
//
//  Created by Dan Kalinin on 5/12/18.
//

#import <CoreData/CoreData.h>
#import <Helpers/Helpers.h>










@interface NSArray<ObjectType> (ORM)

- (NSArray<ObjectType> *)arrayByExecutingFetchRequest:(NSFetchRequest *)request;

@end










@interface NSMutableArray<ObjectType> (ORM)

- (void)executeFetchRequest:(NSFetchRequest *)request;

@end
