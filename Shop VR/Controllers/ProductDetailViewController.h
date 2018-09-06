//
//  ProductDetailViewController.h
//  Shop VR
//
//  Created by Dan Ray on 9/6/18.
//  Copyright © 2018 Ray Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductDetailViewController : UIViewController

@property (nonatomic, retain) IBOutlet UIImageView              *productImage;
@property (nonatomic, retain) IBOutlet UILabel                  *brandLabel;
@property (nonatomic, retain) IBOutlet UILabel                  *nameLabel;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView  *spinner;

- (IBAction)place:(id)sender;

@end
