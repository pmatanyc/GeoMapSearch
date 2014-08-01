//
//  PMMapAnnotationView.h
//  PMMapView
//
//  Created by Paola Mata Maldonado on 7/17/14.
//
//

#import <MapKit/MapKit.h>

@interface PMMapAnnotationView : MKAnnotationView

@property (nonatomic,assign) CLLocationCoordinate2D coordinate;
@property (nonatomic,copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@end
