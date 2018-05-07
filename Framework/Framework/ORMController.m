//
//  ORMTableViewController.m
//  ORM
//
//  Created by Dan Kalinin on 5/6/18.
//

#import "ORMController.h"










@interface ORMChange ()

@property ORMChangeKind kind;
@property NSFetchedResultsChangeType type;
@property NSUInteger index;
@property NSUInteger destinationIndex;
@property NSIndexPath *indexPath;
@property NSIndexPath *destinationIndexPath;

@end



@implementation ORMChange

- (instancetype)initWithType:(NSFetchedResultsChangeType)type index:(NSUInteger)index destinationIndex:(NSUInteger)destinationIndex {
    self = super.init;
    if (self) {
        self.kind = ORMChangeKindSection;
        self.type = type;
        self.index = index;
        self.destinationIndex = destinationIndex;
    }
    return self;
}

- (instancetype)initWithType:(NSFetchedResultsChangeType)type indexPath:(NSIndexPath *)indexPath destinationIndexPath:(NSIndexPath *)destinationIndexPath {
    self = super.init;
    if (self) {
        self.kind = ORMChangeKindObject;
        self.type = type;
        self.indexPath = indexPath;
        self.destinationIndexPath = destinationIndexPath;
    }
    return self;
}

@end










@interface ORMTableViewController ()

@property NSMutableArray<ORMChange *> *changes;

@end



@implementation ORMTableViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
    }
    return self;
}

#pragma mark - Table view

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.controller.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.controller.sections.count > 0) {
        return self.controller.sections[section].numberOfObjects;
    } else {
        return self.controller.fetchedObjects.count;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (self.controller.sections.count > 0) {
        return self.controller.sections[section].name;
    } else {
        return nil;
    }
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.controller.sectionIndexTitles;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    NSInteger section = [self.controller sectionForSectionIndexTitle:title atIndex:index];
    return section;
}

#pragma mark - Fetched results controller

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    self.changes = NSMutableArray.array;
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    ORMChange *change = [ORMChange.alloc initWithType:type index:sectionIndex destinationIndex:sectionIndex];
    [self.changes addObject:change];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    ORMChange *change = [ORMChange.alloc initWithType:type indexPath:indexPath destinationIndexPath:newIndexPath];
    [self.changes addObject:change];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    if (self.rowAnimation == UITableViewRowAnimationNone) {
        [self.tableView reloadData];
    } else {
        [self.tableView performBatchUpdates:^{
            for (ORMChange *change in self.changes) {
                if (change.kind == ORMChangeKindSection) {
                    if (change.type == NSFetchedResultsChangeInsert) {
                        NSIndexSet *sections = [NSIndexSet indexSetWithIndex:change.destinationIndex];
                        [self.tableView insertSections:sections withRowAnimation:self.rowAnimation];
                    } else if (change.type == NSFetchedResultsChangeDelete) {
                        NSIndexSet *sections = [NSIndexSet indexSetWithIndex:change.index];
                        [self.tableView deleteSections:sections withRowAnimation:self.rowAnimation];
                    } else if (change.type == NSFetchedResultsChangeMove) {
                        [self.tableView moveSection:change.index toSection:change.destinationIndex];
                    } else {
                        NSIndexSet *sections = [NSIndexSet indexSetWithIndex:change.index];
                        [self.tableView reloadSections:sections withRowAnimation:self.rowAnimation];
                    }
                } else {
                    if (change.type == NSFetchedResultsChangeInsert) {
                        [self.tableView insertRowsAtIndexPaths:@[change.destinationIndexPath] withRowAnimation:self.rowAnimation];
                    } else if (change.type == NSFetchedResultsChangeDelete) {
                        [self.tableView deleteRowsAtIndexPaths:@[change.indexPath] withRowAnimation:self.rowAnimation];
                    } else if (change.type == NSFetchedResultsChangeMove) {
                        [self.tableView moveRowAtIndexPath:change.indexPath toIndexPath:change.destinationIndexPath];
                    } else {
                        [self.tableView reloadRowsAtIndexPaths:@[change.indexPath] withRowAnimation:self.rowAnimation];
                    }
                }
            }
        } completion:nil];
    }
}

@end










@interface ORMCollectionViewController ()

@end



@implementation ORMCollectionViewController

@end




//@implementation FRCCVC {
//    BOOL _loaded;
//
//    NSMutableIndexSet *_insertedSections;
//    NSMutableIndexSet *_deletedSections;
//
//    NSMutableOrderedSet *_insertedItems;
//    NSMutableOrderedSet *_deletedItems;
//    NSMutableOrderedSet *_updatedItems;
//
//    NSMutableSet *_objects;
//
//    __weak id <NSFetchedResultsControllerDelegate> _delegate;
//}
//
//- (instancetype)initWithCoder:(NSCoder *)aDecoder {
//    self = [super initWithCoder:aDecoder];
//    if (self) {
//        _objects = [NSMutableSet set];
//
//        self.orderKeyPath = @"order";
//    }
//    return self;
//}
//
//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//
//    if (self.clearsSelectionOnViewWillAppear) {
//        [_objects removeAllObjects];
//    } else {
//        if (_loaded) return;
//        _loaded = YES;
//
//        UICollectionViewScrollPosition position = (self.objects.count == 1) ? (UICollectionViewScrollPositionCenteredVertically | UICollectionViewScrollPositionCenteredHorizontally) : UICollectionViewScrollPositionNone;
//        [self selectObjects:position];
//    }
//}
//
//#pragma mark - Accessors
//
//- (void)setObject:(NSManagedObject *)object {
//    if (!object) return;
//    _objects = [NSMutableSet setWithObject:object];
//}
//
//- (NSManagedObject *)object {
//    return _objects.anyObject;
//}
//
//- (void)setObjects:(NSSet<NSManagedObject *> *)objects {
//    if (!objects) return;
//    _objects = [NSMutableSet setWithSet:objects];
//}
//
//- (NSSet<NSManagedObject *> *)objects {
//    return _objects;
//}
//
//#pragma mark - Collection view
//
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//    NSUInteger sections = self.frc.sections.count;
//    return sections;
//}
//
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    id <NSFetchedResultsSectionInfo> sectionInfo = self.frc.sections[section];
//    NSUInteger items = sectionInfo.numberOfObjects;
//    return items;
//}
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSString *cellIdentifier = [self cellIdentifierForIndexPath:indexPath];
//    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
//    [self configureCell:cell atIndexPath:indexPath];
//    return cell;
//}
//
//- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSManagedObject *object = [self.frc objectAtIndexPath:indexPath];
//    [_objects addObject:object];
//    return YES;
//}
//
//- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSManagedObject *object = [self.frc objectAtIndexPath:indexPath];
//    [_objects removeObject:object];
//}
//
//- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
//    if ([destinationIndexPath isEqual:sourceIndexPath]) return;
//
//    id <NSFetchedResultsControllerDelegate> delegate = self.frc.delegate;
//    self.frc.delegate = nil;
//
//    NSInteger sourceIndex, destinationIndex;
//    NSMutableArray *objects;
//
//    if (self.orderInSection) {
//        sourceIndex = sourceIndexPath.item;
//        destinationIndex = destinationIndexPath.item;
//        id <NSFetchedResultsSectionInfo> sectionInfo = self.frc.sections[sourceIndexPath.section];
//        objects = sectionInfo.objects.mutableCopy;
//    } else {
//        sourceIndex = destinationIndex = 0;
//    }
//
//    NSManagedObject *object = objects[sourceIndex];
//    [objects removeObjectAtIndex:sourceIndex];
//    [objects insertObject:object atIndex:destinationIndex];
//
//    for (NSUInteger order = 0; order < objects.count; order++) {
//        object = objects[order];
//        [object setValue:@(order) forKeyPath:self.orderKeyPath];
//    }
//
//    [self.frc.managedObjectContext save:nil];
//
//    [self.frc performFetch:nil];
//    self.frc.delegate = delegate;
//}
//
//#pragma mark - Fetched results controller
//
//- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
//    _insertedSections = [NSMutableIndexSet indexSet];
//    _deletedSections = [NSMutableIndexSet indexSet];
//
//    _insertedItems = [NSMutableOrderedSet orderedSet];
//    _deletedItems = [NSMutableOrderedSet orderedSet];
//    _updatedItems = [NSMutableOrderedSet orderedSet];
//}
//
//- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
//    if (type == NSFetchedResultsChangeInsert) {
//        [_insertedSections addIndex:sectionIndex];
//    } else if (type == NSFetchedResultsChangeDelete) {
//        [_deletedSections addIndex:sectionIndex];
//    }
//}
//
//- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
//    if (type == NSFetchedResultsChangeInsert) {
//        [_insertedItems addObject:newIndexPath];
//    } else if (type == NSFetchedResultsChangeDelete) {
//        [_deletedItems addObject:indexPath];
//    } else if (type == NSFetchedResultsChangeMove) {
//        [_deletedItems addObject:indexPath];
//        [_insertedItems addObject:newIndexPath];
//    } else if (type == NSFetchedResultsChangeUpdate) {
//        [_updatedItems addObject:indexPath];
//    }
//}
//
//- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
//    [self.collectionView performBatchUpdates:^{
//        if (_insertedSections.count > 0) {
//            [self.collectionView insertSections:_insertedSections];
//        }
//        if (_deletedSections.count > 0) {
//            [self.collectionView deleteSections:_deletedSections];
//        }
//
//        if (_insertedItems.count > 0) {
//            [self.collectionView insertItemsAtIndexPaths:_insertedItems.array];
//        }
//        if (_deletedItems.count > 0) {
//            [self.collectionView deleteItemsAtIndexPaths:_deletedItems.array];
//        }
//        if (_updatedItems.count > 0) {
//            [self.collectionView reloadItemsAtIndexPaths:_updatedItems.array];
//        }
//    } completion:nil];
//
//    [self selectObjects:UICollectionViewScrollPositionNone];
//}
//
//#pragma mark - Helpers
//
//- (NSString *)cellIdentifierForIndexPath:(NSIndexPath *)indexPath {
//    return @"Cell";
//}
//
//- (void)configureCell:(UICollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
//}
//
//- (void)selectObjects:(UICollectionViewScrollPosition)position {
//    for (NSManagedObject *object in self.objects) {
//        NSIndexPath *indexPath = [self.frc indexPathForObject:object];
//        [self.collectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:position];
//    }
//}
//
//- (void)prepareForReloadData {
//    if (!self.frc.delegate) return;
//
//    _delegate = self.frc.delegate;
//    self.frc.delegate = nil;
//}
//
//- (void)reloadData {
//    [self.frc performFetch:nil];
//    [self.collectionView reloadData];
//    self.frc.delegate = _delegate;
//}
//
//@end
