//
//  ORMTableViewController.m
//  ORM
//
//  Created by Dan Kalinin on 5/6/18.
//

#import "ORMTableViewController.h"



@interface ORMTableViewController ()

@end



@implementation ORMTableViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.rowAnimation = UITableViewRowAnimationNone;
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil; // TODO: Implement
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
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    NSIndexSet *sections = [NSIndexSet indexSetWithIndex:sectionIndex];
    if (type == NSFetchedResultsChangeInsert) {
        [self.tableView insertSections:sections withRowAnimation:self.rowAnimation];
    } else {
        [self.tableView deleteSections:sections withRowAnimation:self.rowAnimation];
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    if (type == NSFetchedResultsChangeInsert) {
        [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:self.rowAnimation];
    } else if (type == NSFetchedResultsChangeDelete) {
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:self.rowAnimation];
    } else if (type == NSFetchedResultsChangeMove) {
        [self.tableView moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
    } else {
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:self.rowAnimation];
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

@end
