//
//  Main.h
//  ORM
//
//  Created by Dan Kalinin on 4/28/18.
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

@property (readonly) SurrogateArray<ORMDelegate> *delegates;

+ (instancetype)orm;
- (ORMLoad *)load;

@end
