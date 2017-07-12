//
//  VCCozinhaLista.m
//  iFoodPlanner
//
//  Created by Flavio Akira Nakahara on 7/12/17.
//  Copyright © 2017 Flavio Akira Nakahara. All rights reserved.
//

#import "VCCozinhaLista.h"
#import "VCCozinhaItemCell.h"

@interface VCCozinhaLista ()

@end

@implementation VCCozinhaLista
@synthesize listaReceitas;
@synthesize listaVazia;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    listaReceitas = @[
                      @{@"titulo": @"Macarronada", @"ingrediente": @"macarrao", @"preparo":@"Cozinhe macarrao na agua fervente."},
                      @{@"titulo": @"Arroz", @"ingrediente": @"arroz", @"preparo":@"Cozinhe arroz com agua em fogo brando ate levantar fervura."},
                      @{@"titulo": @"Feijao", @"ingrediente": @"feijao", @"preparo":@"Cozinhe feijao com agua dentro da panela de pressao por 30 minutos."}
                      ];
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
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger nroReceitas = listaReceitas.count;
    
    if(nroReceitas == 0){
        [listaVazia setHidden:NO];
        [tableView setHidden:YES];
    } else{
        [listaVazia setHidden:YES];
        [tableView setHidden:NO];
    }
    
    return nroReceitas;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VCCozinhaItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CozinhaItemCelIdentifier" forIndexPath:indexPath];
    
    [cell.titulo setText:[[listaReceitas objectAtIndex:indexPath.row] objectForKey:@"titulo"]];
    
    return cell;
}

@end
