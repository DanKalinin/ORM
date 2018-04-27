//
//  Main.h
//  ORM
//
//  Created by Dan Kalinin on 4/27/18.
//  Copyright © 2018 Dan Kalinin. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <Helpers/Helpers.h>
#import "PersistentContainer.h"










@interface ORMLoad : Operation

@property (readonly) PersistentContainer *container;

- (instancetype)initWithContainer:(PersistentContainer *)container;

@end










@interface ORM : OperationQueue

@property PersistentContainer *container;

- (ORMLoad *)loadWithContainer:(PersistentContainer *)container;

@end
