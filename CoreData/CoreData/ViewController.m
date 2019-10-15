//
//  ViewController.m
//  CoreData
//
//  Created by MT382 on 10/15/19.
//  Copyright © 2019 DongNV. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

-(NSManagedObjectContext *)managedobjectcontext {
    NSManagedObjectContext *context = nil;
    _delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    if ([_delegate respondsToSelector:@selector(persistentContainer)]) {
        context = _delegate.persistentContainer.viewContext;
    }
    return context;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // fetch contact from data base
    NSManagedObjectContext *managedObjectContext = [self managedobjectcontext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:@"Contacts"];
    self.arrContact = [[managedObjectContext executeFetchRequest:fetchRequest error:nil]mutableCopy];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrContact.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSManagedObject *contact = [self.arrContact objectAtIndex:indexPath.row];
    [cell.textLabel setText:[NSString stringWithFormat:@"%@",[contact valueForKey:@"fullName"]]];
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"%@",[contact valueForKey:@"phone"]]];
    return cell;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSManagedObjectContext *context = [self managedobjectcontext];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //delete object from database
        [context deleteObject:[self.arrContact objectAtIndex:indexPath.row]];
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"can't delete %@ %@",error,[error localizedDescription]);
            return;
        }
        //remove contact from tableview
        [self.arrContact removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier]isEqualToString:@"updateContact"]) {
        NSManagedObject *selectedContact = [self.arrContact objectAtIndex:[[self.tableView indexPathForSelectedRow]row]];
        SecondViewController *vc = segue.destinationViewController;
        vc.contactDB = selectedContact;
    }
}

@end
