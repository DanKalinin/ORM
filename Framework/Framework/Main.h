//
//  Main.h
//  ORM
//
//  Created by Dan Kalinin on 4/28/18.
//

#import <CoreData/CoreData.h>
#import <Helpers/Helpers.h>
#import "PersistentContainer.h"

@class ORMLoad, ORMSync, ORM;










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










@protocol ORMSyncDelegate <OperationDelegate>

@optional
- (void)ORMSyncDidUpdateState:(ORMSync *)sync;
- (void)ORMSyncDidUpdateProgress:(ORMSync *)sync;

- (void)ORMSyncDidBegin:(ORMSync *)sync;
- (void)ORMSyncDidEnd:(ORMSync *)sync;

- (void)ORMSync:(ORMSync *)sync didEndClass:(Class)class;

@end



@interface ORMSync : Operation <ORMSyncDelegate>

@property (readonly) SurrogateArray<ORMSyncDelegate> *delegates;
@property (readonly) NSMutableArray<Class> *classes;

- (instancetype)initWithClasses:(NSMutableArray<Class> *)classes;

@end










@protocol ORMDelegate <OperationDelegate>

@end



@interface ORM : OperationQueue <ORMDelegate>

@property Class syncClass;
@property PersistentContainer *container;

@property (readonly) SurrogateArray<ORMDelegate> *delegates;

+ (instancetype)orm;

- (ORMLoad *)load;
- (ORMLoad *)load:(VoidBlock)completion;

- (__kindof ORMSync *)syncClasses:(NSMutableArray<Class> *)classes;
- (__kindof ORMSync *)syncClasses:(NSMutableArray<Class> *)classes completion:(VoidBlock)completion;

@end
