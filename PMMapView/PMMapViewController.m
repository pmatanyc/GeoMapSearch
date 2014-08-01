//
//  PMMapViewController.m
//  PMMapView
//
//  Created by Paola Mata Maldonado on 7/17/14.
//
//

#import "PMMapViewController.h"
#import "PMMapAnnotationView.h"

@interface PMMapViewController ()

@end

@implementation PMMapViewController

@synthesize matchingItems;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
        locationManager = [[CLLocationManager alloc]init];
        [locationManager setDelegate:self];
        [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.mapView setDelegate:self];
    [self.searchTextField setDelegate:self];
    self.mapView.showsUserLocation = YES;
    
}



-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    NSLog(@"Location: %f, %f",
          userLocation.location.coordinate.latitude,
          userLocation.location.coordinate.longitude);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.location.coordinate, 5000, 5000);
    [self.mapView setRegion:region animated:YES];
    
}

-(void)getLocalSearchResults{
    
    self.annotationView = [[MKAnnotationView alloc] init];
    
//    MKCoordinateRegion region;
//    CLLocationCoordinate2D myCoordinate;
//    myCoordinate.latitude  = 40.741444;
//    myCoordinate.longitude = -73.99007;
//    
//    region = MKCoordinateRegionMakeWithDistance(myCoordinate, 5000, 5000);
//    [self.mapView setRegion:region animated:YES];
//    
//    
//    PMMapAnnotationView *annotation = [[PMMapAnnotationView alloc] init];
//    annotation.coordinate = myCoordinate;
//    annotation.title = @"TurnToTech";
//    annotation.subtitle =@"184 5th Ave";
//    [self.mapView addAnnotation:annotation];

    
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    [request setNaturalLanguageQuery: self.searchTextField.text];
//    [request setRegion: self.mapView.region];
    
    
    if (!matchingItems)
        matchingItems = [[NSMutableArray alloc]init];
    else{
        [matchingItems removeAllObjects];
        [self.mapView removeAnnotations:self.mapView.annotations];
    }
    
    MKLocalSearch *search = [[MKLocalSearch alloc]initWithRequest:request];
    
    [search startWithCompletionHandler:^(MKLocalSearchResponse
                                         *response, NSError *error) {
        if (response.mapItems.count == 0)
            NSLog(@"No Matches");
        else
            for (MKMapItem *item in response.mapItems)
            {
//                NSLog(@"name = %@", item.placemark.addressDictionary);
//                [matchingItems addObject:item];
                
                PMMapAnnotationView *annotation = [[PMMapAnnotationView alloc]init];
                annotation.coordinate = item.placemark.coordinate;
                annotation.title = item.name;
                NSString *address = [item.placemark.addressDictionary objectForKey:@"Street"];
                NSString *neighborhood = [item.placemark.addressDictionary objectForKey:@"SubLocality"];
                annotation.subtitle = [NSString stringWithFormat:@"%@ - %@", address, neighborhood];
                [self.mapView addAnnotation:annotation];
            }
    }];
    
}

-(BOOL)textFieldShouldReturn:(UITextField*)textfield{
    
    [self getLocalSearchResults];
    
    [textfield resignFirstResponder];
    
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)changeMapView:(id)sender{
    switch (((UISegmentedControl *)sender).selectedSegmentIndex) {
        case 0:
            self.mapView.mapType = MKMapTypeStandard;
            break;
        case 1:
            self.mapView.mapType = MKMapTypeSatellite;
            break;
        case 2:
            self.mapView.mapType = MKMapTypeHybrid;
            break;
            
        default:
            break;
    }
}


@end
