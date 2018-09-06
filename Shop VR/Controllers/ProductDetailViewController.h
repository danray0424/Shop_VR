//
//  ProductDetailViewController.h
//  Shop VR
//
//  Created by Dan Ray on 9/6/18.
//  Copyright © 2018 Ray Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"
#import <WebKit/WebKit.h>

@interface ProductDetailViewController : UIViewController

@property (nonatomic, retain) IBOutlet UIImageView              *productImage;
@property (nonatomic, retain) IBOutlet UILabel                  *brandLabel;
@property (nonatomic, retain) IBOutlet UILabel                  *nameLabel;
@property (nonatomic, retain) IBOutlet WKWebView               *productDescription;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView  *spinner;
@property (nonatomic, retain) IBOutlet UIButton                 *placeButton;

@property (nonatomic, retain) Product *product;

- (IBAction)place:(id)sender;

@end
