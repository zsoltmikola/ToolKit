/**
 * @file    TKDependencyInjector.h
 * @author  Zsolt Mikola
 * @copyright Zsolt Mikola. All rights reserved.
 */

#import <Foundation/Foundation.h>

/**
 * Handles dependency injection mechanisms. Keeps ownership of the registered
 * object instances and can inject them into the appropriate properties of another
 * object instance on request.
 */
@interface TKObjectInjector : NSObject

/**
 * Registering an object
 *
 * The method registers and object instance which can be injected into another object's property later
 *
 * @param anInstance, The instance of the object for registration
 */
- (void)registerObject:(id)anInstance;

/**
 * Checking if a class is already registered with the injector
 *
 * @param instanceClass, The class of the registered instance
 * @return Returns YES/NO if a class is already registered
 */
- (BOOL)hasRegistered:(Class)objectClass;

/**
 * Injecting all the registered object instances into an object's properties
 *
 * The injectors trie>s to inject all the registred instances into an object's properties
 *
 * @param anObject, The object which has the recipient properties
 */

- (void)injectObjectsForObject:(id)anObject;

@end
