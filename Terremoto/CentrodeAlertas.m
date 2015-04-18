//
//  CentrodeAlertas.m
//  Terremoto
//
//  Created by Guillermo González Irigoyen on 16/04/15.
//  Copyright (c) 2015 Nerb. All rights reserved.
//

#define BackQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define FeeddeAlertas [NSURL URLWithString:@"http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_hour.geojson"]
#import "CentrodeAlertas.h"


@interface CentrodeAlertas ()
@end



@implementation CentrodeAlertas

@synthesize controldeNavegacion = _controldeNavegacion;
@synthesize barradeNavedacion = _barradeNavegacion;
@synthesize vistadelaTabladeAlertas = _vistadelaTabladeAlertas;

@synthesize informacionAlertas = _informacionAlertas;
@synthesize diccionarioJSON = _diccionarioJSON;

@synthesize ultimasAlertas = _ultimasAlertas;
@synthesize magnituddelTemblor = _magnituddelTemblor;
@synthesize fecha = _fecha;
@synthesize ubicacion = _ubicacion;
@synthesize longitud = _longitud;
@synthesize latitud = _latitud;
@synthesize profundidad = _profundidad;



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self solicitarFeed];

}


//QUEUE en back para solicitar la información del feed
-(void)solicitarFeed
{

    dispatch_async(BackQueue, ^{
        _informacionAlertas = [NSData dataWithContentsOfURL: FeeddeAlertas];
        [self performSelectorOnMainThread:@selector(informacionObtenida:) 
                               withObject:_informacionAlertas waitUntilDone:YES];
    });
}

//Función para refrescar el feed por medio del botón
-(IBAction)refrescarFeed:(id)sender
{
    NSLog(@"Refrescando la tabla...");
    [self solicitarFeed];
}



- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_ultimasAlertas count];
}





//Vistas de la Celdas
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifierdelaCelda = @"celdadeAlerta";
    CeldadeAlerta *celda = [tableView dequeueReusableCellWithIdentifier:identifierdelaCelda];
    
    //Propiedades
    NSDictionary *propiedades = [[_ultimasAlertas objectAtIndex:indexPath.row] objectForKey:@"properties"];
    _magnituddelTemblor = [propiedades objectForKey:@"mag"];
    _ubicacion = [propiedades objectForKey:@"place"];
        
    celda.magnitud.text = [NSString stringWithFormat:@"%@",_magnituddelTemblor];
    celda.ubicacion.text = [NSString stringWithFormat:@"%@",_ubicacion];
    
    return celda;
}



#pragma mark PrepareForSeague Storyboard
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"segueDetalle"])
    {
    
        DetalledelaAlerta *detalledelaAlerta = [segue destinationViewController];
        NSIndexPath *indexPath = [self.vistadelaTabladeAlertas indexPathForSelectedRow];
        
        //Propiedades
        NSDictionary *propiedades = [[_ultimasAlertas objectAtIndex:indexPath.row] objectForKey:@"properties"];
        detalledelaAlerta.mag = [NSString stringWithFormat:@"%@", [propiedades objectForKey:@"mag"]];
        detalledelaAlerta.ubi = [NSString stringWithFormat:@"%@", [propiedades objectForKey:@"place"]];
        NSString *tiempoFeed = [propiedades objectForKey:@"updated"];
        NSTimeInterval _intervalodeTiempo = ([tiempoFeed longLongValue]/1000.0);
        NSDate *fechaconelTiempodelFeed = [NSDate dateWithTimeIntervalSince1970:_intervalodeTiempo];
        NSDateFormatter *formatodeFecha = [[NSDateFormatter alloc] init];
        [formatodeFecha setDateFormat:@"MMM dd, yyyy HH:mm:ss"];
        NSString *fecha = [formatodeFecha stringFromDate:fechaconelTiempodelFeed];
        detalledelaAlerta.fec = [NSString stringWithFormat:@"%@", fecha];
        
  
        
        //Coordenadas
        NSDictionary *geometrias = [[_ultimasAlertas objectAtIndex:indexPath.row] objectForKey:@"geometry"];
        NSArray *coordenadas = [geometrias objectForKey:@"coordinates"];
        detalledelaAlerta.lon = [NSString stringWithFormat:@"%@", [coordenadas objectAtIndex:0]];
        detalledelaAlerta.lat = [NSString stringWithFormat:@"%@", [coordenadas objectAtIndex:1]];
        detalledelaAlerta.pro = [NSString stringWithFormat:@"%@", [coordenadas objectAtIndex:2]];
    
    }
}



// metodo para dar color a la lista antes de renderear
- (void)tableView: (UITableView*)tableView 
  willDisplayCell: (UITableViewCell*)cell 
forRowAtIndexPath: (NSIndexPath*)indexPath
{
    NSDictionary *propiedades = [[_ultimasAlertas objectAtIndex:indexPath.row] objectForKey:@"properties"];
    _magnituddelTemblor = [propiedades objectForKey:@"mag"];
    
    cell.backgroundColor = [UIColor colorWithRed:0.82 green:0.88 blue:0.89 alpha:1.0];
    if(NSLocationInRange([_magnituddelTemblor floatValue], NSMakeRange(0.0,(0.9-0.0)+1)))
    {
        cell.backgroundColor = [UIColor colorWithRed:0.63 green:0.84 blue:0.56 alpha:1.0];
    }
    if(NSLocationInRange([_magnituddelTemblor floatValue], NSMakeRange(9.0,(9.9-0.9)+1)))
    {
        cell.backgroundColor = [UIColor colorWithRed:0.89 green:0.22 blue:0.22 alpha:1.0];
    }
}



#pragma mark - Información Obtenida
- (void)informacionObtenida:(NSData *) informacionRespuesta 
{
    NSLog(@"Información Obtenida...");
    NSError *error;
    _diccionarioJSON = [NSJSONSerialization JSONObjectWithData:informacionRespuesta
                                                       options:kNilOptions 
                                                         error:&error];
    
    //Metadata
    NSDictionary *metas = [_diccionarioJSON  objectForKey:@"metadata"];
    _barradeNavegacion.title = [metas objectForKey:@"title"];
    
    
    NSLog(@"Información procesada...");
    _ultimasAlertas = [_diccionarioJSON objectForKey:@"features"];
    

    NSLog(@"Refrescando la tabla...");
    [self.vistadelaTabladeAlertas reloadData];
  
}

@end
