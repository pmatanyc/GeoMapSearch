//
//  PMMapViewController.h
//  PMMapView
//
//  Created by Paola Mata Maldonado on 7/17/14.
//
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

#import <CoreLocation/CoreLocation.h>


@interface PMMapViewController : UIViewController<CLLocationManagerDelegate, MKMapViewDelegate, UITextFieldDelegate>{
    
    CLLocationManager *locationManager;
}

@property (strong, nonatomic) IBOutlet UITextField *searchTextField;
@property (nonatomic, retain)IBOutlet MKMapView *mapView;

@property(strong, nonatomic)NSMutableArray *matchingItems;

@property(nonatomic,retain)MKAnnotationView *annotationView;

-(IBAction)changeMapView:(id)sender;

@end
