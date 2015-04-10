//
//  ViewController.m
//  Test_iBeaconBroadcast
//
//  Created by Eduardo Flores on 4/4/15.
//  Copyright (c) 2015 Eduardo Flores. All rights reserved.
//

#import "ViewController.h"

// Tutorial from http://www.appcoda.com/ios7-programming-ibeacons-tutorial/
// UUID generated on terminal with uuidgen
#define MY_UUID     @"E258CAE3-6832-406C-8E17-65AEC949EB76"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)button_startBroadcasting:(id)sender
{
    NSUUID *uuid = [[NSUUID alloc]initWithUUIDString:MY_UUID];

    self.myBeaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                                  major:1
                                                                  minor:1
                                                             identifier:@"com.eduardoflores.Test-iBeaconBroadcast"];
    
    // Get the beacon data to advertise
    self.myBeaconData = [self.myBeaconRegion peripheralDataWithMeasuredPower:nil];
    
    // start the peripheral manager
    self.peripheralManager = [[CBPeripheralManager alloc]initWithDelegate:self
                                                                    queue:nil
                                                                  options:nil];
}

- (IBAction)button_lookForBeacon:(id)sender
{
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];

    
    NSUUID *uuid = [[NSUUID alloc]initWithUUIDString:MY_UUID];
    
    self.myBeaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                             identifier:@"com.eduardoflores.Test-iBeaconBroadcast"];
    
    self.myBeaconRegion.notifyEntryStateOnDisplay = YES;
    
    [self.locationManager startMonitoringForRegion:self.myBeaconRegion];
    [self.locationManager startRangingBeaconsInRegion:self.myBeaconRegion];
}

#pragma mark - Broadcast iBeacon
- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    if (peripheral.state == CBPeripheralManagerStatePoweredOn)
    {
        // bluetooth is on
        
        // start broadcasting
        [self.peripheralManager startAdvertising:self.myBeaconData];
        NSLog(@"I think we're broadcasting...");
    }
    else
    {
        NSLog(@"bluetooth is off?");
    }
}

#pragma mark - Listen for iBeacon
- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    NSLog(@"in didEnterRegion");
    [self.locationManager startRangingBeaconsInRegion:self.myBeaconRegion];
}
- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    NSLog(@"in didExitRegion");
    [self.locationManager stopRangingBeaconsInRegion:self.myBeaconRegion];
}

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    NSLog(@"iBeacon found!");
    
    CLBeacon *beacon = [beacons firstObject];
    NSLog(@"proximity = %ld", beacon.proximity);
    NSLog(@"rssi = %ld", (long)beacon.rssi);
}


@end

















































