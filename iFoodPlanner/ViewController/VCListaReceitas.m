//
//  VCListaReceitas.m
//  iFoodPlanner
//
//  Created by Flavio Akira Nakahara on 7/7/17.
//  Copyright © 2017 Flavio Akira Nakahara. All rights reserved.
//

#import "VCListaReceitas.h"
#import "VCItemReceitaTableViewCell.h"

@interface VCListaReceitas ()

@end

@implementation VCListaReceitas
@synthesize listaReceitas;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
     listaReceitas = @[
                               @{@"titulo": @"Macarronada", @"ingrediente": @"macarrao", @"preparo":@"Cozinhe macarrao na agua fervente."},
                               @{@"titulo": @"Arroz", @"ingrediente": @"arroz", @"preparo":@"Cozinhe arroz com agua em fogo brando ate levantar fervura."},
                               @{@"titulo": @"Feijao", @"ingrediente": @"feijao", @"preparo":@"Cozinhe feijao com agua dentro da panela de pressao por 30 minutos."}
                               ];
    
    [self.tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"woodback"]]];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"receitas.sql"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger nroReceitas = listaReceitas.count;
    
    if(nroReceitas == 0){
        UILabel *lblVazio = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, self.tableView.bounds.size.height)];
        [lblVazio setText:@"Nenhuma receita cadastrada"];
        [lblVazio setTextColor:[UIColor blackColor]];
        [lblVazio setTextAlignment:NSTextAlignmentCenter];
        [self.tableView.backgroundView insertSubview:lblVazio atIndex:0];
    }
    
    return nroReceitas;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VCItemReceitaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ItemReceitaIdentifier" forIndexPath:indexPath];
    
    [cell.lblTitulo setText:[listaReceitas[indexPath.row] objectForKey:@"titulo"]];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
