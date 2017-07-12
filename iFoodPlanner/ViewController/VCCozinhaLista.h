//
//  VCCozinhaLista.h
//  iFoodPlanner
//
//  Created by Flavio Akira Nakahara on 7/12/17.
//  Copyright © 2017 Flavio Akira Nakahara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBManager.h"

@interface VCCozinhaLista : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *listaVazia;
@property(nonatomic, strong) DBManager *dbManager;
@property(nonatomic, strong) NSArray *listaReceitas;

@end
