//
//  VCListaIngredientes.h
//  iFoodPlanner
//
//  Created by Flavio Akira Nakahara on 7/7/17.
//  Copyright © 2017 Flavio Akira Nakahara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBManager.h"

@interface VCListaIngredientes : UITableViewController

@property(nonatomic, strong) DBManager *dbManager;
@property(nonatomic, strong) NSArray *listaIngredientes;

@end
