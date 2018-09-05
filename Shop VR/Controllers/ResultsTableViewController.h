//
//  ResultsTableViewController.h
//  Shop VR
//
//  Created by Dan Ray on 9/5/18.
//  Copyright © 2018 Ray Solutions. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "Product.h"
#import "SearchResults.h"

@interface ResultsTableViewController : UITableViewController

@property (nonatomic, retain) SearchResults *results;

@end
