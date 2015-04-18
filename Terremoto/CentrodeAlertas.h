//
//  CentrodeAlertas.h
//  Terremoto
//
//  Created by Guillermo González Irigoyen on 16/04/15.
//  Copyright (c) 2015 Nerb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CeldadeAlerta.h"
#import "DetalledelaAlerta.h"


@interface CentrodeAlertas : UITableViewController <UITableViewDelegate>
{
    UINavigationController *_controldeNavegacion;
    UINavigationItem *_barradeNavegacion;
    UITableView *_vistadelaTabladeAlertas;

    NSData *_informacionAlertas;
    NSMutableDictionary *_diccionarioJSON;
    
    NSMutableArray *_ultimasAlertas;
    NSMutableString *_magnituddelTemblor;
    NSMutableString *_fecha;
    NSMutableString *_ubicacion;
    NSMutableString *_longitud;
    NSMutableString *_latitud;
    NSMutableString *_profundidad;
    
}


@property IBOutlet UINavigationController *controldeNavegacion;
@property IBOutlet UINavigationItem *barradeNavedacion;
@property IBOutlet UITableView *vistadelaTabladeAlertas;

@property NSData *informacionAlertas;
@property NSMutableDictionary *diccionarioJSON;

@property NSMutableArray *ultimasAlertas;
@property NSMutableString *magnituddelTemblor;
@property NSMutableString *fecha;
@property NSMutableString *ubicacion;
@property NSMutableString *longitud;
@property NSMutableString *latitud;
@property NSMutableString *profundidad;


-(IBAction)refrescarFeed:(id)sender;

@end
