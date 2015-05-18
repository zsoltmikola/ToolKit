/**
 * @file    TKDependencyInjector.m
 * @author  Zsolt Mikola
 * @copyright Zsolt Mikola. All rights reserved.
 */

#import "TKDependencyInjector.h"
#import <objc/runtime.h>

@interface TKDependencyInjector ()

@property (nonatomic, strong) NSMapTable* mapping;

@end

Class WWgetPropertyType(objc_property_t property);

@implementation TKDependencyInjector

- (instancetype)init
{
    if (!(self = [super init])){
        return self;   
    }
    
    _mapping = [NSMapTable weakToStrongObjectsMapTable];
    
    return self;
}

- (void)registerInstance:(id)anInstance{
    
    if (!anInstance) {
        return;
    }
    
    [_mapping setObject:anInstance forKey:[anInstance class]];
}

- (BOOL)hasRegistered:(Class)instanceClass{
    return ([_mapping objectForKey:instanceClass] != nil);
}

- (void)injectInstancesForObject:(id)anObject{

    unsigned int propertyCount, i;
    objc_property_t *propertyList = class_copyPropertyList([anObject class], &propertyCount);
    for (i = 0; i < propertyCount; i++) {
        objc_property_t prop = propertyList[i];
        Class type = WWgetPropertyType(prop);
        if (type && [_mapping objectForKey:type] != nil) {
            NSString *propertyName = [NSString stringWithCString:property_getName(prop) encoding:[NSString defaultCStringEncoding]];
            id instanceToInject = [_mapping objectForKey:type];
            [anObject setValue:instanceToInject forKeyPath:propertyName];
        }
    }
    free(propertyList);
}

Class WWgetPropertyType(objc_property_t property) {
    NSString *propertyAttributeString =  [NSString stringWithCString:property_getAttributes(property) encoding:[NSString defaultCStringEncoding]];
    NSArray *propertyAttributes = [propertyAttributeString componentsSeparatedByString:@","];
    NSString *propertyType = [propertyAttributes firstObject];
    Class propertyClass = nil;
    if ([propertyType hasPrefix:@"T@"] && propertyType.length > 4) {
        NSString *className = [propertyType substringWithRange:NSMakeRange(3, propertyType.length - 4)];
        propertyClass = NSClassFromString(className);
    }
    return propertyClass;
}

@end
