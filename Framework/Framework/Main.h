//
//  Main.h
//  ORM
//
//  Created by Dan Kalinin on 4/27/18.
//  Copyright © 2018 Dan Kalinin. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <Helpers/Helpers.h>
#import "PersistentContainer.h"

@class ORMLoad, ORM;










@protocol ORMLoadDelegate <OperationDelegate>

- (void)ORMLoadDidUpdateState:(ORMLoad *)load;
- (void)ORMLoadDidUpdateProgress:(ORMLoad *)load;

- (void)ORMLoadDidBegin:(ORMLoad *)load;
- (void)ORMLoadDidEnd:(ORMLoad *)load;

- (void)ORMLoad:(ORMLoad *)load didEndStore:(NSPersistentStoreDescription *)store;

@end



@interface ORMLoad : Operation <ORMLoadDelegate>

@property (readonly) PersistentContainer *container;

- (instancetype)initWithContainer:(PersistentContainer *)container;

@end










@interface ORM : OperationQueue

@property PersistentContainer *container;

- (ORMLoad *)loadWithContainer:(PersistentContainer *)container;

@end
