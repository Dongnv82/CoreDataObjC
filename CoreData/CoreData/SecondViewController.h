//
//  SecondViewController.h
//  CoreData
//
//  Created by MT382 on 10/15/19.
//  Copyright © 2019 DongNV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface SecondViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (strong, nonatomic) AppDelegate *delegate;
@property(strong) NSManagedObject *contactDB;

- (IBAction)back:(UIButton *)sender;
- (IBAction)save:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
