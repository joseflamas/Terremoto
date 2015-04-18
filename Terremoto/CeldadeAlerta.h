//
//  CeldadeAlerta.h
//  Terremoto
//
//  Created by Guillermo González Irigoyen on 16/04/15.
//  Copyright (c) 2015 Nerb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CeldadeAlerta : UITableViewCell
{
    UILabel *_magnitud;
    UILabel *_ubicacion;
}

@property IBOutlet UILabel *magnitud;
@property IBOutlet UILabel *ubicacion;




@end
