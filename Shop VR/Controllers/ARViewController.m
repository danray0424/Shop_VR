//
//  ARViewController.m
//  Shop VR
//
//  Created by Dan Ray on 9/5/18.
//  Copyright © 2018 Ray Solutions. All rights reserved.
//

#import "ARViewController.h"
#import "ARAlertController.h"
#import "ARSCNViewControl.h"
#import "ARGestureControl.h"

@interface ARViewController ()

@property (nonatomic, strong) ARAlertController *alertController;
@property (nonatomic, strong) ARSCNViewControl *sceneControl;
@property (nonatomic, strong) ARGestureControl *gestureControl;

@end

@implementation ARViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initialGetter];
    [self setupScene];
    [self.gestureControl setupGestureRecognizer];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (ARWorldTrackingConfiguration.isSupported) {
        [self startSession];
    } else {
        [self.alertController showUnsupportedAlert];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.sceneView.session pause];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Getters

-(void)initialGetter {
    // Set up initial controllers and delegates
    if (!self.alertController) {
        self.alertController = [[ARAlertController alloc] init];
        self.alertController.viewController = self;
    }
    
    if (!self.sceneControl) {
        self.sceneControl = [[ARSCNViewControl alloc] init];
        self.sceneControl.viewController = self;
        self.sceneControl.alertController = self.alertController;
    }
    
    if (!self.gestureControl) {
        self.gestureControl = [[ARGestureControl alloc] init];
        self.gestureControl.viewController = self;
    }
}

#pragma mark - Configure SCNScene

- (void)setupSceneView {
    
    self.sceneView.delegate = self.sceneControl;
    self.sceneView.automaticallyUpdatesLighting = YES;
    self.sceneView.showsStatistics = NO;
}

- (void)setupScene {
    
    self.sceneView.delegate = self.sceneControl;
    self.sceneNode = [NSMutableArray new];
    self.sceneView.showsStatistics = YES;
    self.sceneView.autoenablesDefaultLighting = YES;
    self.sceneView.debugOptions = SCNDebugOptionNone;
    
    SCNScene *scene = [SCNScene new];
    self.sceneView.scene = scene;
}

#pragma mark - Configure ARSession

- (void)startSession {
    
    ARWorldTrackingConfiguration *configuration = [ARWorldTrackingConfiguration new];
    configuration.planeDetection = ARPlaneDetectionHorizontal;
    [self.sceneView.session runWithConfiguration:configuration];
    
}
#pragma mark - Media Premission Check

-(void)checkMediaPermissionAndButtonState {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if(status == AVAuthorizationStatusAuthorized || status == AVAuthorizationStatusNotDetermined) {
            [self.alertController showOverlyText:@"STARTING A NEW SESSION, TRY MOVING LEFT OR RIGHT" withDuration:2];
        } else {
            NSString *accessDescription = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSCameraUsageDescription"];
            [self.alertController showPermissionAlertWithDescription:accessDescription];
        }
        
        self.currentYAngle = 0.0;
    });
}

@end
