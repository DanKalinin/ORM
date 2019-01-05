//
//  ORMTableViewController.h
//  ORM
//
//  Created by Dan Kalinin on 5/6/18.
//

#import <CoreData/CoreData.h>
#import <UIKitExt/UIKitExt.h>

//@class ORMChange, ORMTableViewController;
//
//typedef NS_ENUM(NSUInteger, ORMChangeKind) {
//    ORMChangeKindSection,
//    ORMChangeKindObject
//};
//
//
//
//
//
//
//
//
//
//
//@interface ORMChange : NSObject
//
//@property (readonly) ORMChangeKind kind;
//@property (readonly) NSFetchedResultsChangeType type;
//@property (readonly) NSUInteger index;
//@property (readonly) NSUInteger destinationIndex;
//@property (readonly) NSIndexPath *indexPath;
//@property (readonly) NSIndexPath *destinationIndexPath;
//
//- (instancetype)initWithType:(NSFetchedResultsChangeType)type index:(NSUInteger)index destinationIndex:(NSUInteger)destinationIndex;
//- (instancetype)initWithType:(NSFetchedResultsChangeType)type indexPath:(NSIndexPath *)indexPath destinationIndexPath:(NSIndexPath *)destinationIndexPath;
//
//@end
//
//
//
//
//
//
//
//
//
//
//@interface ORMTableViewController : CTLTableViewController <NSFetchedResultsControllerDelegate>
//
//@property NSFetchedResultsController *controller;
//@property BOOL userDrivenChange;
//
//@property IBInspectable UITableViewRowAnimation rowAnimation;
//
//@property (readonly) NSMutableArray<ORMChange *> *changes;
//
//@end
//
//
//
//
//
//
//
//
//
//
//@interface ORMCollectionViewController : CTLCollectionViewController <NSFetchedResultsControllerDelegate>
//
//@property NSFetchedResultsController *controller;
//@property BOOL userDrivenChange;
//
//@property IBInspectable BOOL itemAnimation;
//
//@property (readonly) NSMutableArray<ORMChange *> *changes;
//
//@end
