//
//  DetalledelaAlerta.h
//  Terremoto
//
//  Created by Guillermo González Irigoyen on 16/04/15.
//  Copyright (c) 2015 Nerb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface DetalledelaAlerta : UIViewController <MKMapViewDelegate>
{
    NSString *_mag;
    NSString *_fec;
    NSString *_ubi;
    NSString *_lon;
    NSString *_lat;
    NSString *_pro;
    
    UILabel *_magnituddelTemblor;
    UILabel *_fecha;
    UILabel *_ubicacion;
    UILabel *_longitud;
    UILabel *_latitud;
    UILabel *_profundidad;
    
    MKMapView *_mapa;
}

@property (strong, nonatomic) NSString *mag;
@property (strong, nonatomic) NSString *fec;
@property (strong, nonatomic) NSString *ubi;
@property (strong, nonatomic) NSString *lon;
@property (strong, nonatomic) NSString *lat;
@property (strong, nonatomic) NSString *pro;

@property (strong, nonatomic) IBOutlet UILabel *magnituddelTemblor;
@property (strong, nonatomic) IBOutlet UILabel *fecha;
@property (strong, nonatomic) IBOutlet UILabel *ubicacion;
@property (strong, nonatomic) IBOutlet UILabel *longitud;
@property (strong, nonatomic) IBOutlet UILabel *latitud;
@property (strong, nonatomic) IBOutlet UILabel *profundidad;

@property (nonatomic, strong) IBOutlet MKMapView *mapa;

@end
