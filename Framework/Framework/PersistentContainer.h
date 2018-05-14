//
//  PersistentContainer.h
//  ORM
//
//  Created by Dan Kalinin on 4/28/18.
//

#import <CoreData/CoreData.h>



@interface PersistentContainer : NSPersistentContainer

@property (readonly, nonatomic) NSManagedObjectContext *syncContext;
@property (readonly, nonatomic) NSManagedObjectContext *uiContext;

- (instancetype)initWithName:(NSString *)name bundle:(NSBundle *)bundle;

@end
