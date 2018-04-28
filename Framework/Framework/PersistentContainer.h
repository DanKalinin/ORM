//
//  PersistentContainer.h
//  ORM
//
//  Created by Dan Kalinin on 4/28/18.
//

#import <CoreData/CoreData.h>



@interface PersistentContainer : NSPersistentContainer

- (instancetype)initWithName:(NSString *)name bundle:(NSBundle *)bundle;

@end
