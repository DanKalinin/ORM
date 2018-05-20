//
//  PersistentContainer.h
//  ORM
//
//  Created by Dan Kalinin on 4/28/18.
//

#import <CoreData/CoreData.h>
#import "ManagedObjectContext.h"

@class PersistentContainer;



@interface PersistentContainer : NSPersistentContainer

@property (readonly) ManagedObjectContext *context;

- (instancetype)initWithName:(NSString *)name bundle:(NSBundle *)bundle;
- (ManagedObjectContext *)contextWithConcurrencyType:(NSManagedObjectContextConcurrencyType)ct;

@end
