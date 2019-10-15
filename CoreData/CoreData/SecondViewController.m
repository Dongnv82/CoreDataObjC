//
//  SecondViewController.m
//  CoreData
//
//  Created by MT382 on 10/15/19.
//  Copyright © 2019 DongNV. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController
@synthesize contactDB;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.contactDB) {
        [self.name setText:[self.contactDB valueForKey:@"fullName"]];
        [self.email setText:[self.contactDB valueForKey:@"email"]];
        [self.phone setText:[self.contactDB valueForKey:@"phone"]];
    }
    
}

-(NSManagedObjectContext *)managedobjectcontext {
    NSManagedObjectContext *context = nil;
    _delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    if ([_delegate respondsToSelector:@selector(persistentContainer)]) {
        context = _delegate.persistentContainer.viewContext;
    }
    return context;
}

- (IBAction)back:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save:(UIButton *)sender {
    NSManagedObjectContext *context = [self managedobjectcontext];
    if (self.contactDB) {
        // update Contact
        [self.contactDB setValue:self.name.text forKey:@"fullName"];
        [self.contactDB setValue:self.email.text forKey:@"email"];
        [self.contactDB setValue:self.phone.text forKey:@"phone"];
    }else{
        // create new
        NSManagedObject *newContact =[NSEntityDescription insertNewObjectForEntityForName:@"Contacts" inManagedObjectContext:context];
        [newContact setValue:self.name.text forKey:@"fullName"];
        [newContact setValue:self.email.text forKey:@"email"];
        [newContact setValue:self.phone.text forKey:@"phone"];
    }
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"can't save %@ %@",error,[error localizedDescription]);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
