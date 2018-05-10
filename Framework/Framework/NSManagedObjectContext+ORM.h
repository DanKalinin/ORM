//
//  NSManagedObjectContext+ORM.h
//  ORM
//
//  Created by Dan Kalinin on 5/6/18.
//

#import <CoreData/CoreData.h>



@interface NSManagedObjectContext (ORM)

- (__kindof NSManagedObject *)findOrCreate:(NSFetchRequest *)request error:(NSError **)error;

@end
