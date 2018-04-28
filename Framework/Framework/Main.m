//
//  Main.m
//  ORM
//
//  Created by Dan Kalinin on 4/28/18.
//

#import "Main.h"
#import <Helpers/Helpers.h>



@interface ORM ()

@end



@implementation ORM

+ (instancetype)orm {
    return nil;
}

- (instancetype)initWithName:(NSString *)name bundle:(NSBundle *)bundle {
    NSURL *url = [bundle URLForResource:name withExtension:ExtensionMOMD];
    NSManagedObjectModel *model = [NSManagedObjectModel.alloc initWithContentsOfURL:url];
    self = [super initWithName:name managedObjectModel:model];
    return self;
}

@end
