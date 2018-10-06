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

@property (readonly) HLPArray<ORMLoadDelegate> *delegates;
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
@property (readonly) HLPArray<ORMSyncDelegate> *delegates;
@property (readonly) NSMutableArray<id> *scopes;
@property (readonly) ORMManagedObjectContext *parentContext;
@property (readonly) ORMManagedObjectContext *context;

- (instancetype)initWithScopes:(NSMutableArray<id> *)scopes parentContext:(ORMManagedObjectContext *)parentContext;
- (void)syncScope:(id)scope;

@end










@interface ORMPlistSync : ORMSync

@end










@protocol ORMDelegate <ORMLoadDelegate, ORMSyncDelegate>

@end



@interface ORM : HLPOperation <ORMDelegate>

@property ORMPersistentContainer *container;

@property (readonly) HLPArray<ORMDelegate> *delegates;

- (ORMLoad *)load;
- (ORMLoad *)load:(HLPVoidBlock)completion;

- (__kindof ORMSync *)sync:(Class)syncClass scopes:(NSMutableArray<id> *)scopes parentContext:(ORMManagedObjectContext *)parentContext;
- (__kindof ORMSync *)sync:(Class)syncClass scopes:(NSMutableArray<id> *)scopes parentContext:(ORMManagedObjectContext *)parentContext completion:(HLPVoidBlock)completion;

@end
