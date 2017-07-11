//
//  VCListaReceitas.h
//  iFoodPlanner
//
//  Created by Flavio Akira Nakahara on 7/7/17.
//  Copyright © 2017 Flavio Akira Nakahara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBManager.h"

@interface VCListaReceitas : UITableViewController

@property(nonatomic, strong) NSArray *listaReceitas;
@property(nonatomic, strong) DBManager *dbManager;

@end
