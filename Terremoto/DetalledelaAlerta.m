//
//  DetalledelaAlerta.m
//  Terremoto
//
//  Created by Guillermo González Irigoyen on 16/04/15.
//  Copyright (c) 2015 Nerb. All rights reserved.
//

#import "DetalledelaAlerta.h"

@interface DetalledelaAlerta ()

@end

@implementation DetalledelaAlerta

@synthesize mag = _mag;
@synthesize fec = _fec;
@synthesize ubi = _ubi;
@synthesize lon = _lon;
@synthesize lat = _lat;
@synthesize pro = _pro;

@synthesize magnituddelTemblor = _magnituddelTemblor;
@synthesize fecha = _fecha;
@synthesize ubicacion = _ubicacion;
@synthesize longitud = _longitud;
@synthesize latitud = _latitud;
@synthesize profundidad = _profundidad;

@synthesize mapa = _mapa;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.82 green:0.88 blue:0.89 alpha:1.0];
    
    self.magnituddelTemblor.text = _mag;
    self.fecha.text = _fec;
    self.ubicacion.text = _ubi;
    self.longitud.text = _lon;
    self.latitud.text = _lat;
    self.profundidad.text = _pro;
    
    self.mapa.delegate = self;
    
    CLLocationCoordinate2D coordenada = {[_lat floatValue],[_lon floatValue]};
    MKPointAnnotation *punto = [[MKPointAnnotation alloc] init];
    punto.coordinate = coordenada;    
    [self.mapa addAnnotation:punto];
    
    MKCoordinateRegion region;
    region.center.latitude = [_lat floatValue];
    region.center.longitude = [_lon floatValue];
    region.span.latitudeDelta = 0.1;
    region.span.longitudeDelta = 0.1;
    [_mapa setRegion:region animated:YES];   
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark MKMapView Delegate methods




@end
