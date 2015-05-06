//
//  MapViewController.m
//  Humon
//
//  Created by Charlie Massry on 5/4/15.
//  Copyright (c) 2015 Charlie Massry. All rights reserved.
//

#import "MapViewController.h"
#import "EventViewController.h"
#import <MapKit/MapKit.h>
#import "RailsClient.h"
#import "UserSession.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface MapViewController () <MKMapViewDelegate>
@property(strong, nonatomic) MKMapView *mapView;
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"Humon", nil);
    self.mapView = [[MKMapView alloc] initWithFrame:self.view.frame];
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
    
    [self initializeAddButton];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (![UserSession userIsLoggedIn]) {
        [SVProgressHUD show];
        
        [[RailsClient sharedClient] createCurrentUserWithCompletionBlock:^(NSError *error) {
            if (error) {
                [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"App authentication error", nil)];
            } else {
                [SVProgressHUD dismiss];
            }
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initializeAddButton {
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                               target:self
                                                                               action:@selector(addButtonPressed)];
    self.navigationItem.leftBarButtonItem = addButton;
}

- (void)addButtonPressed {
    EventViewController *eventViewController = [[EventViewController alloc] init];
    [self.navigationController pushViewController:eventViewController
                                         animated:YES];
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
