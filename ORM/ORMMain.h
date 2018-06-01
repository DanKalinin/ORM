//
//  ORMMain.h
//  ORM
//
//  Created by Dan Kalinin on 4/28/18.
//

#import <CoreData/CoreData.h>
#import <Helpers/Helpers.h>
#import "ORMPersistentContainer.h"

@class ORMLoad, ORMSync, ORMPlistSync, ORM;

typedef NSString * ORMScope NS_STRING_ENUM;










@protocol ORMLoadDelegate <HLPOperationDelegate>

@optional
- (void)ORMLoadDidUpdateState:(ORMLoad *)load;
- (void)ORMLoadDidUpdateProgress:(ORMLoad *)load;

- (void)ORMLoadDidBegin:(ORMLoad *)load;
- (void)ORMLoadDidEnd:(ORMLoad *)load;

- (void)ORMLoad:(ORMLoad *)load didEndStore:(NSPersistentStoreDescription *)store;

@end



@interface ORMLoad : HLPOperation <ORMLoadDelegate>

@property (readonly) SurrogateArray<ORMLoadDelegate> *delegates;
@property (readonly) ORMPersistentContainer *container;

- (instancetype)initWithContainer:(ORMPersistentContainer *)container;

@end










@protocol ORMSyncDelegate <HLPOperationDelegate>

@optional
- (void)ORMSyncDidUpdateState:(ORMSync *)sync;
- (void)ORMSyncDidUpdateProgress:(ORMSync *)sync;

- (void)ORMSyncDidBegin:(ORMSync *)sync;
- (void)ORMSyncDidEnd:(ORMSync *)sync;

- (void)ORMSync:(ORMSync *)sync didEndScope:(id)scope;

@end



@interface ORMSync : HLPOperation <ORMSyncDelegate>

@property (readonly) ORM *parent;
@property (readonly) SurrogateArray<ORMSyncDelegate> *delegates;
@property (readonly) NSMutableArray<id> *scopes;
@property (readonly) ORMManagedObjectContext *parentContext;
@property (readonly) ORMManagedObjectContext *context;

- (instancetype)initWithScopes:(NSMutableArray<id> *)scopes parentContext:(ORMManagedObjectContext *)parentContext;
- (void)syncScope:(id)scope;

@end










@interface ORMPlistSync : ORMSync

@end










@protocol ORMDelegate <HLPOperationDelegate>

@end



@interface ORM : HLPOperationQueue <ORMDelegate>

@property ORMPersistentContainer *container;

@property (readonly) SurrogateArray<ORMDelegate> *delegates;

- (ORMLoad *)load;
- (ORMLoad *)load:(VoidBlock)completion;

- (__kindof ORMSync *)sync:(Class)syncClass scopes:(NSMutableArray<id> *)scopes parentContext:(ORMManagedObjectContext *)parentContext;
- (__kindof ORMSync *)sync:(Class)syncClass scopes:(NSMutableArray<id> *)scopes parentContext:(ORMManagedObjectContext *)parentContext completion:(VoidBlock)completion;

@end
