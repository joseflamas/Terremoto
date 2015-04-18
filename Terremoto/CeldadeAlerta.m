//
//  CeldadeAlerta.m
//  Terremoto
//
//  Created by Guillermo González Irigoyen on 16/04/15.
//  Copyright (c) 2015 Nerb. All rights reserved.
//

#import "CeldadeAlerta.h"

@implementation CeldadeAlerta



@synthesize magnitud = _magnitud;
@synthesize ubicacion = _ubicacion;




- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
    {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
