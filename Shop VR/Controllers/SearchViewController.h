//
//  ViewController.h
//  Shop VR
//
//  Created by Dan Ray on 9/5/18.
//  Copyright © 2018 Ray Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController

@property (nonatomic, retain) IBOutlet UITextField    *searchTerm;
@property (nonatomic, retain) IBOutlet UIButton       *searchButton;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView  *spinner;

-(IBAction)search:(id)sender;

@end

