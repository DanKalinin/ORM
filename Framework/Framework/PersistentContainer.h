//
//  PersistentContainer.h
//  ORM
//
//  Created by Dan Kalinin on 4/28/18.
//

#import <CoreData/CoreData.h>
#import "ORMManagedObjectContext.h"

@class PersistentContainer;



@interface PersistentContainer : NSPersistentContainer

@property (readonly) ORMManagedObjectContext *context;

- (instancetype)initWithName:(NSString *)name bundle:(NSBundle *)bundle;
- (ORMManagedObjectContext *)contextWithConcurrencyType:(NSManagedObjectContextConcurrencyType)ct;

@end
