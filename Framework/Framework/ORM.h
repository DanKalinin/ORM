//
//  Framework.h
//  Framework
//
//  Created by Dan Kalinin on 4/27/18.
//  Copyright © 2018 Dan Kalinin. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT double ORMVersionNumber;
FOUNDATION_EXPORT const unsigned char ORMVersionString[];

#import <ORM/ORMMain.h>
#import <ORM/PersistentContainer.h>
#import <ORM/ORMManagedObjectContext.h>
#import <ORM/MergePolicy.h>
#import <ORM/ORMController.h>
#import <ORM/NSManagedObjectModel+ORM.h>
#import <ORM/NSArray+ORM.h>
