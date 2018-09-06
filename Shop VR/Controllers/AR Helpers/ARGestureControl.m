//
//  ARGestureControl.m
//  ARKit_with_ObjC
//
//  Created by Raju on 11/7/17.
//  Copyright © 2017 rajubd49. All rights reserved.
//

#import "ARGestureControl.h"

@interface ARGestureControl ()

@property (nonatomic, strong) SCNHitTestResult *removeHitResult;
@property (nonatomic, strong) ARHitTestResult *initialHitTestResult;
@property (nonatomic, strong) SCNNode *movedObject;

@end

@implementation ARGestureControl

#pragma mark - Set Gesture Recognizers

- (void)setupGestureRecognizer {
    
    // Tap Gesture
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleAddObjectFrom:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [self.viewController.sceneView addGestureRecognizer:tapGestureRecognizer];
    
}

#pragma mark - GestureRecognizer

- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}


#pragma mark - Handle Gesture Recognizers

- (void)handleAddObjectFrom: (UITapGestureRecognizer *)recognizer {
    
    [self insertARObject:recognizer];
}


#pragma mark - Insert AR Object

- (void)insertARObject:(UITapGestureRecognizer *)recognizer {
    
    CGPoint tapPoint = [recognizer locationInView:self.viewController.sceneView];
    NSArray<ARHitTestResult *> *result = [self.viewController.sceneView hitTest:tapPoint types:ARHitTestResultTypeExistingPlaneUsingExtent];
    
    if (result.count == 0) {
        return;
    }
    
    ARHitTestResult *hitResult = [result firstObject];
    

    SCNPlane *plane = [SCNPlane planeWithWidth:.2 height:.2];
    plane.firstMaterial.diffuse.contents = self.viewController.productImage;
    plane.firstMaterial.doubleSided = YES;
    SCNNode *node = [SCNNode nodeWithGeometry:plane];
    float insertionYOffset = 0.01;
    node.position = SCNVector3Make(
                                   hitResult.worldTransform.columns[3].x,
                                   hitResult.worldTransform.columns[3].y + insertionYOffset,
                                   hitResult.worldTransform.columns[3].z
                                   );
    
    [self.viewController.sceneNode addObject:node];
    [self.viewController.sceneView.scene.rootNode addChildNode:node];
}

@end
