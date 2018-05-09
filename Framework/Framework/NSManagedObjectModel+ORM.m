//
//  NSManagedObjectModel+ORM.m
//  ORM
//
//  Created by Dan Kalinin on 5/9/18.
//

#import "NSManagedObjectModel+ORM.h"
#import <Helpers/Helpers.h>



@implementation NSManagedObjectModel (ORM)

+ (void)load {
    SEL original = @selector(fetchRequestFromTemplateWithName:substitutionVariables:);
    SEL swizzled = @selector(ORM_NSManagedObjectModel_fetchRequestFromTemplateWithName:substitutionVariables:);
    [self swizzleInstanceMethod:original with:swizzled];
}

- (NSFetchRequest *)ORM_NSManagedObjectModel_fetchRequestFromTemplateWithName:(NSString *)name substitutionVariables:(NSDictionary<NSString *, id> *)variables {
    NSFetchRequest *request = [self ORM_NSManagedObjectModel_fetchRequestFromTemplateWithName:name substitutionVariables:variables];
    NSString *key = [NSString stringWithFormat:@"%@.%@", NSStringFromClass(NSFetchRequest.class), name];
    NSString *value = request.entity.userInfo[key];
    if (value) {
        NSURLComponents *components = NSURLComponents.new;
        components.query = value;
        NSMutableArray *descriptors = NSMutableArray.array;
        for (NSURLQueryItem *item in components.queryItems) {
            NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:item.name ascending:item.value.boolValue];
            [descriptors addObject:descriptor];
        }
        request.sortDescriptors = descriptors;
    }
    return request;
}

@end
