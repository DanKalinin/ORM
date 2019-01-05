//
//  ORMTableViewController.m
//  ORM
//
//  Created by Dan Kalinin on 5/6/18.
//

#import "ORMController.h"










//@interface ORMChange ()
//
//@property ORMChangeKind kind;
//@property NSFetchedResultsChangeType type;
//@property NSUInteger index;
//@property NSUInteger destinationIndex;
//@property NSIndexPath *indexPath;
//@property NSIndexPath *destinationIndexPath;
//
//@end
//
//
//
//@implementation ORMChange
//
//- (instancetype)initWithType:(NSFetchedResultsChangeType)type index:(NSUInteger)index destinationIndex:(NSUInteger)destinationIndex {
//    self = super.init;
//    if (self) {
//        self.kind = ORMChangeKindSection;
//        self.type = type;
//        self.index = index;
//        self.destinationIndex = destinationIndex;
//    }
//    return self;
//}
//
//- (instancetype)initWithType:(NSFetchedResultsChangeType)type indexPath:(NSIndexPath *)indexPath destinationIndexPath:(NSIndexPath *)destinationIndexPath {
//    self = super.init;
//    if (self) {
//        self.kind = ORMChangeKindObject;
//        self.type = type;
//        self.indexPath = indexPath;
//        self.destinationIndexPath = destinationIndexPath;
//    }
//    return self;
//}
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
//@interface ORMTableViewController ()
//
//@property NSMutableArray<ORMChange *> *changes;
//
//@end
//
//
//
//@implementation ORMTableViewController
//
//- (instancetype)initWithCoder:(NSCoder *)aDecoder {
//    self = [super initWithCoder:aDecoder];
//    if (self) {
//        self.rowAnimation = UITableViewRowAnimationNone;
//    }
//    return self;
//}
//
//#pragma mark - Table view
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return self.controller.sections.count;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    if (self.controller.sections.count > 0) {
//        return self.controller.sections[section].numberOfObjects;
//    } else {
//        return self.controller.fetchedObjects.count;
//    }
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSManagedObject *object = [self.controller objectAtIndexPath:indexPath];
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
//    cell.textLabel.text = object.objectID.URIRepresentation.absoluteString;
//    return cell;
//}
//
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    if (self.controller.sections.count > 0) {
//        return self.controller.sections[section].name;
//    } else {
//        return nil;
//    }
//}
//
//- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
//    return self.controller.sectionIndexTitles;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
//    NSInteger section = [self.controller sectionForSectionIndexTitle:title atIndex:index];
//    return section;
//}
//
//#pragma mark - Fetched results controller
//
//- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
//    self.changes = NSMutableArray.array;
//}
//
//- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
//    ORMChange *change = [ORMChange.alloc initWithType:type index:sectionIndex destinationIndex:sectionIndex];
//    [self.changes addObject:change];
//}
//
//- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
//    ORMChange *change = [ORMChange.alloc initWithType:type indexPath:indexPath destinationIndexPath:newIndexPath];
//    [self.changes addObject:change];
//}
//
//- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
//    if (self.userDrivenChange) {
//    } else {
//        if (self.rowAnimation == UITableViewRowAnimationNone) {
//            [self.tableView reloadData];
//        } else {
//            [self.tableView performBatchUpdates:^{
//                for (ORMChange *change in self.changes) {
//                    if (change.kind == ORMChangeKindSection) {
//                        if (change.type == NSFetchedResultsChangeInsert) {
//                            NSIndexSet *sections = [NSIndexSet indexSetWithIndex:change.destinationIndex];
//                            [self.tableView insertSections:sections withRowAnimation:self.rowAnimation];
//                        } else if (change.type == NSFetchedResultsChangeDelete) {
//                            NSIndexSet *sections = [NSIndexSet indexSetWithIndex:change.index];
//                            [self.tableView deleteSections:sections withRowAnimation:self.rowAnimation];
//                        } else if (change.type == NSFetchedResultsChangeMove) {
//                            [self.tableView moveSection:change.index toSection:change.destinationIndex];
//                        } else {
//                            NSIndexSet *sections = [NSIndexSet indexSetWithIndex:change.index];
//                            [self.tableView reloadSections:sections withRowAnimation:self.rowAnimation];
//                        }
//                    } else {
//                        if (change.type == NSFetchedResultsChangeInsert) {
//                            [self.tableView insertRowsAtIndexPaths:@[change.destinationIndexPath] withRowAnimation:self.rowAnimation];
//                        } else if (change.type == NSFetchedResultsChangeDelete) {
//                            [self.tableView deleteRowsAtIndexPaths:@[change.indexPath] withRowAnimation:self.rowAnimation];
//                        } else if (change.type == NSFetchedResultsChangeMove) {
//                            [self.tableView moveRowAtIndexPath:change.indexPath toIndexPath:change.destinationIndexPath];
//                        } else {
//                            [self.tableView reloadRowsAtIndexPaths:@[change.indexPath] withRowAnimation:self.rowAnimation];
//                        }
//                    }
//                }
//            } completion:nil];
//        }
//    }
//}
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
//@interface ORMCollectionViewController ()
//
//@property NSMutableArray<ORMChange *> *changes;
//
//@end
//
//
//
//@implementation ORMCollectionViewController
//
//- (instancetype)initWithCoder:(NSCoder *)aDecoder {
//    self = [super initWithCoder:aDecoder];
//    if (self) {
//    }
//    return self;
//}
//
//#pragma mark - Collection view
//
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//    return self.controller.sections.count;
//}
//
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    if (self.controller.sections.count > 0) {
//        return self.controller.sections[section].numberOfObjects;
//    } else {
//        return self.controller.fetchedObjects.count;
//    }
//}
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSManagedObject *object = [self.controller objectAtIndexPath:indexPath];
//    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
//    cell.label1.text = object.objectID.URIRepresentation.absoluteString;
//    return cell;
//}
//
//#pragma mark - Fetched results controller
//
//- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
//    self.changes = NSMutableArray.array;
//}
//
//- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
//    ORMChange *change = [ORMChange.alloc initWithType:type index:sectionIndex destinationIndex:sectionIndex];
//    [self.changes addObject:change];
//}
//
//- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
//    ORMChange *change = [ORMChange.alloc initWithType:type indexPath:indexPath destinationIndexPath:newIndexPath];
//    [self.changes addObject:change];
//}
//
//- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
//    if (self.userDrivenChange) {
//    } else {
//        if (self.itemAnimation) {
//            [self.collectionView performBatchUpdates:^{
//                for (ORMChange *change in self.changes) {
//                    if (change.kind == ORMChangeKindSection) {
//                        if (change.type == NSFetchedResultsChangeInsert) {
//                            NSIndexSet *sections = [NSIndexSet indexSetWithIndex:change.destinationIndex];
//                            [self.collectionView insertSections:sections];
//                        } else if (change.type == NSFetchedResultsChangeDelete) {
//                            NSIndexSet *sections = [NSIndexSet indexSetWithIndex:change.index];
//                            [self.collectionView deleteSections:sections];
//                        } else if (change.type == NSFetchedResultsChangeMove) {
//                            [self.collectionView moveSection:change.index toSection:change.destinationIndex];
//                        } else {
//                            NSIndexSet *sections = [NSIndexSet indexSetWithIndex:change.index];
//                            [self.collectionView reloadSections:sections];
//                        }
//                    } else {
//                        if (change.type == NSFetchedResultsChangeInsert) {
//                            [self.collectionView insertItemsAtIndexPaths:@[change.destinationIndexPath]];
//                        } else if (change.type == NSFetchedResultsChangeDelete) {
//                            [self.collectionView deleteItemsAtIndexPaths:@[change.indexPath]];
//                        } else if (change.type == NSFetchedResultsChangeMove) {
//                            [self.collectionView moveItemAtIndexPath:change.indexPath toIndexPath:change.destinationIndexPath];
//                        } else {
//                            [self.collectionView reloadItemsAtIndexPaths:@[change.indexPath]];
//                        }
//                    }
//                }
//            } completion:nil];
//        } else {
//            [self.collectionView reloadData];
//        }
//    }
//}
//
//@end
