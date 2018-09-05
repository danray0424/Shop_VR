//
//  ViewController.m
//  Shop VR
//
//  Created by Dan Ray on 9/5/18.
//  Copyright © 2018 Ray Solutions. All rights reserved.
//

#import "ViewController.h"
#import "ResultsTableViewController.h"
#import <RestKit/RestKit.h>
#import "Product.h"
@interface ViewController ()

@end

@implementation ViewController

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
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Product class]];
    [mapping addAttributeMappingsFromArray:@[@"name", @"description", @"imageurl"]];
    NSIndexSet *statusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful);
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping
                                                                                            method:RKRequestMethodGET
                                                                                       pathPattern:@"/path/path"
                                                                                           keyPath:@""
                                                                                       statusCodes:statusCodes];
    
    NSString *requestString = [NSString stringWithFormat:@"https://api.shop.com/AffiliatePublisherNetwork/v2/products?publisherId=AP1234567&locale=en_US&perPage=15&term=%@", self.searchTerm.text];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:requestString]];
    
    RKObjectRequestOperation *operation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[responseDescriptor]];
    
    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        NSLog(@"%@", mappingResult);
        ResultsTableViewController *results = [self.storyboard instantiateViewControllerWithIdentifier:@"resultsController"];
        [self.navigationController pushViewController:results animated:YES];
        self.spinner.hidden = YES;
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"failed with error: %@", [error localizedDescription]);
    }];
    [operation start];
    
}

@end
