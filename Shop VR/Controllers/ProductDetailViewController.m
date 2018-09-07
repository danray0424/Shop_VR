//
//  ProductDetailViewController.m
//  Shop VR
//
//  Created by Dan Ray on 9/6/18.
//  Copyright © 2018 Ray Solutions. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "ARViewController.h"
#import "Product.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ProductDetailViewController ()

@end

@implementation ProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.brandLabel.text = @"";
    self.nameLabel.text  = @"";
    self.placeButton.hidden = YES;
    
    NSString *requestString = [NSString stringWithFormat:@"https://api.shop.com/AffiliatePublisherNetwork/v2/products/%@?publisherId=AP1234567&locale=en_US", self.product.productID];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:requestString]];
    NSString *apikey = (NSString *)[NSUserDefaults.standardUserDefaults objectForKey:@"apikey"];
    [request setValue:apikey forHTTPHeaderField:@"apikey"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                NSDictionary *searchResults = [NSJSONSerialization JSONObjectWithData:data
                                                                                                              options:NSJSONReadingAllowFragments
                                                                                                                error:nil];
                                    
                                                self.product.productDescription = [searchResults objectForKey:@"description"];
                                                
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                    self.spinner.hidden = YES;
                                                    self.placeButton.hidden = NO;
                                                    [self.productImage sd_setImageWithURL:[NSURL URLWithString:self.product.imageURL]];
                                                    self.brandLabel.text = self.product.brand;
                                                    self.nameLabel.text = self.product.name;
                                                    
                                                    // Stick a viewport header on the HTML to control scaling in the WKWebView
                                                    NSString *sizedContent = [NSString stringWithFormat:@"<head><meta name='viewport' content='width=device-width, initial-scale=0.5, maximum-scale=0.5, minimum-scale=0.5'></head>%@", self.product.productDescription];
                                                    [self.productDescription loadHTMLString:sizedContent baseURL:nil];
                                                    
                                                });
                                            }];
    
    
    [task resume];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)place:(id)sender
{
    ARViewController *ar = [self.storyboard instantiateViewControllerWithIdentifier:@"arController"];
    ar.productImage = self.productImage.image;
    [self.navigationController pushViewController:ar animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
