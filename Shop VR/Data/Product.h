//
//  Product.h
//  Shop VR
//
//  Created by Dan Ray on 9/5/18.
//  Copyright © 2018 Ray Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *imageURL;
@property (nonatomic) NSString *shortDescription;
@property (nonatomic) NSString *productDescription;
@property (nonatomic) NSString *brand;
@property (nonatomic) NSNumber *productID;

@end
