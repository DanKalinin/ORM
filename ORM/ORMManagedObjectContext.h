//
//  ORMManagedObjectContext.h
//  ORM
//
//  Created by Dan Kalinin on 5/15/18.
//

#import <CoreData/CoreData.h>

@class ORMManagedObjectContext;










@interface ORMManagedObjectContext : NSManagedObjectContext

@end










@interface NSManagedObjectContext (ORM)

- (__kindof NSManagedObject *)findOrCreate:(NSFetchRequest *)request error:(NSError **)error;

@end
