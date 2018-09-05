//
//  SearchResults.h
//  Shop VR
//
//  Created by Dan Ray on 9/5/18.
//  Copyright © 2018 Ray Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Product.h"

@interface SearchResults : NSObject

@property (nonatomic, retain) NSMutableArray<Product *> *products;

@end
