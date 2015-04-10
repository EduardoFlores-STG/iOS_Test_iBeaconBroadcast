//
//  ViewController.h
//  Test_iBeaconBroadcast
//
//  Created by Eduardo Flores on 4/4/15.
//  Copyright (c) 2015 Eduardo Flores. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController <CBPeripheralManagerDelegate, CLLocationManagerDelegate>

- (IBAction)button_startBroadcasting:(id)sender;
- (IBAction)button_lookForBeacon:(id)sender;

@property (nonatomic, strong) CLBeaconRegion *myBeaconRegion;
@property (nonatomic, strong) NSDictionary *myBeaconData;
@property (nonatomic, strong) CBPeripheralManager *peripheralManager;

@property (nonatomic, strong) CLLocationManager *locationManager;

@end

