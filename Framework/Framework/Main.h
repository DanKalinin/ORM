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

@optional
- (void)ORMLoadDidUpdateState:(ORMLoad *)load;
- (void)ORMLoadDidUpdateProgress:(ORMLoad *)load;

- (void)ORMLoadDidBegin:(ORMLoad *)load;
- (void)ORMLoadDidEnd:(ORMLoad *)load;

- (void)ORMLoad:(ORMLoad *)load didEndStore:(NSPersistentStoreDescription *)store;

@end



@interface ORMLoad : Operation <ORMLoadDelegate>

@property (readonly) SurrogateArray<ORMLoadDelegate> *delegates;
@property (readonly) PersistentContainer *container;

- (instancetype)initWithContainer:(PersistentContainer *)container;

@end










@protocol ORMDelegate <OperationDelegate>

@end



@interface ORM : OperationQueue <ORMDelegate>

@property PersistentContainer *container;

+ (instancetype)orm;
- (ORMLoad *)load;

@end
