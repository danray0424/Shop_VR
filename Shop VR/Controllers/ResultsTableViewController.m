//
//  ResultsTableViewController.m
//  Shop VR
//
//  Created by Dan Ray on 9/5/18.
//  Copyright © 2018 Ray Solutions. All rights reserved.
//

#import "ResultsTableViewController.h"
#import "ProductDetailViewController.h"
#import "SearchResults.h"

@interface ResultsTableViewController ()

@end

@implementation ResultsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Results";
    
    self.clearsSelectionOnViewWillAppear = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.results.products count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cells" forIndexPath:indexPath];
    
    // Configure the cell...
 
    Product *product = (Product *)[self.results.products objectAtIndex:indexPath.row];
    cell.textLabel.text = product.name;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductDetailViewController *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"detailController"];
    detail.product = (Product *)[self.results.products objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];
}


@end
