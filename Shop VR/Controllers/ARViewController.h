//
//  ARViewController.h
//  Shop VR
//
//  Created by Dan Ray on 9/5/18.
//  Copyright © 2018 Ray Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SceneKit/SceneKit.h>
#import <ARKit/ARKit.h>
#import <Photos/Photos.h>
#import <AVFoundation/AVFoundation.h>


@interface ARViewController : UIViewController


@property (nonatomic, retain) NSMutableArray<SCNNode *> *sceneNode;
@property (nonatomic, copy) NSString *sceneName;
@property (nonatomic, assign) CGFloat currentYAngle;

@property (strong, nonatomic) IBOutlet ARSCNView *sceneView;

@property (nonatomic, strong) UIImage *productImage;

@end
