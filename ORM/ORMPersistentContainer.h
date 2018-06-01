//
//  ORMPersistentContainer.h
//  ORM
//
//  Created by Dan Kalinin on 4/28/18.
//

#import <CoreData/CoreData.h>
#import "ORMManagedObjectContext.h"

@class ORMPersistentContainer;



@interface ORMPersistentContainer : NSPersistentContainer

@property (readonly) ORMManagedObjectContext *context;

- (instancetype)initWithName:(NSString *)name bundle:(NSBundle *)bundle;
- (ORMManagedObjectContext *)contextWithConcurrencyType:(NSManagedObjectContextConcurrencyType)concurrencyType parentContext:(ORMManagedObjectContext *)parentContext;

@end
