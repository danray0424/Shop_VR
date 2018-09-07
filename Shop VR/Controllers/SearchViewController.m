//
//  ViewController.m
//  Shop VR
//
//  Created by Dan Ray on 9/5/18.
//  Copyright © 2018 Ray Solutions. All rights reserved.
//

#import "SearchViewController.h"
#import "ResultsTableViewController.h"
#import "Product.h"
#import "SearchResults.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"Search";
    self.spinner.hidden = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)search:(id)sender {
    
    self.spinner.hidden = NO;
    [self.spinner startAnimating];
    
    // Clean up input string
    NSString *safeSearchText = [self.searchTerm.text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSString *requestString = [NSString stringWithFormat:@"https://api.shop.com/AffiliatePublisherNetwork/v2/products?publisherId=AP1234567&locale=en_US&perPage=15&term=%@", safeSearchText];
    
    //Configure and fire API request
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
                                                
                                                SearchResults *results = [[SearchResults alloc] init];
                                                results.products = [NSMutableArray array];
                                                
                                                // Iterate through products JSON object and store Product entities in SearchResults
                                                NSArray *products = [searchResults objectForKey:@"products"];
                                                for (NSDictionary *product in products) {
                                                    Product *item = [[Product alloc] init];
                                                    item.name = [product objectForKey:@"name"];
                                                    NSDictionary *imagery = (NSDictionary *)[product objectForKey:@"image"];
                                                    NSArray *images = (NSArray *)[imagery objectForKey:@"sizes"];
                                                    item.imageURL = [[images objectAtIndex:[images count] - 1] objectForKey:@"url"];
                                                    item.shortDescription  = [product objectForKey:@"shortDescription"];
                                                    item.brand = [product objectForKey:@"brand"];
                                                    item.productID = [product objectForKey:@"id"];
                                                    
                                                    [results.products addObject:item];
                                                }
                                                
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                    self.spinner.hidden = YES;
                                                    ResultsTableViewController *resultsTable = [self.storyboard instantiateViewControllerWithIdentifier:@"resultsController"];
                                                    resultsTable.results = results;
                                                    [self.navigationController pushViewController:resultsTable animated:YES];
                                                });
                                            }];
    
    
    [task resume];
}

@end
