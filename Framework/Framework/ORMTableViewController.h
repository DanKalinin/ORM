//
//  ORMTableViewController.h
//  ORM
//
//  Created by Dan Kalinin on 5/6/18.
//

#import <CoreData/CoreData.h>
#import <Controls/Controls.h>



@interface ORMTableViewController : TableViewController <NSFetchedResultsControllerDelegate>

@property NSFetchedResultsController *controller;

@property IBInspectable UITableViewRowAnimation rowAnimation;

@end
