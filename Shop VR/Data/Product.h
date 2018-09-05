//
//  Product.h
//  Shop VR
//
//  Created by Dan Ray on 9/5/18.
//  Copyright © 2018 Ray Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@interface Product : JSONModel

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *imageURL;
@property (nonatomic) NSString *shortDescription;
@property (nonatomic) NSString *description;
@property (nonatomic) NSString *brand;

@end
