//
//  PMMapAnnotationView.m
//  PMMapView
//
//  Created by Paola Mata Maldonado on 7/17/14.
//
//

#import "PMMapAnnotationView.h"

@implementation PMMapAnnotationView

@synthesize coordinate,title,subtitle;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
