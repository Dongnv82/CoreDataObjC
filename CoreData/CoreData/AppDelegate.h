//
//  AppDelegate.h
//  CoreData
//
//  Created by MT382 on 10/15/19.
//  Copyright © 2019 DongNV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedobjectcontext;

@property (readonly, strong, nonatomic) NSManagedObjectModel *managedobjectmodel;

@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentstorecontainer;

- (void)saveContext;

-(NSURL *)applicationdocumentdirectionry;

@end

