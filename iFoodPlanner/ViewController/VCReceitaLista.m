//
//  VCReceitaLista.m
//  iFoodPlanner
//
//  Created by Flavio Akira Nakahara on 7/12/17.
//  Copyright © 2017 Flavio Akira Nakahara. All rights reserved.
//

#import "VCReceitaLista.h"
#import "VCItemReceitaTableViewCell.h"

@interface VCReceitaLista ()

@end

@implementation VCReceitaLista
@synthesize listaReceitas;
@synthesize listaVazia;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dbreceitas.sql"];
    NSString *consulta = @"select titulo from receita oder by titulo";
    self.listaReceitas = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:consulta]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger nroReceitas = listaReceitas.count;
    
    if (nroReceitas == 0) {
        [listaVazia setHidden:NO];
        [tableView setHidden:YES];
    } else{
        [listaVazia setHidden:YES];
        [tableView setHidden:NO];
    }
    
    return nroReceitas;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VCItemReceitaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ItemReceitaIdentifier" forIndexPath:indexPath];
    
    NSInteger indexTitulo = [self.dbManager.arrColumnNames indexOfObject:@"titulo"];
    [cell.lblTitulo setText:[NSString stringWithFormat:@"%@", [[self.listaReceitas objectAtIndex:indexPath.row] objectAtIndex:indexTitulo]]];
    
    return cell;
}

@end
