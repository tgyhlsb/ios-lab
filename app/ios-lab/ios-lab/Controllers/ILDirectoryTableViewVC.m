//
//  ILDirectoryTableViewVC.m
//  ios-lab
//
//  Created by Tanguy Hélesbeux on 03/05/2015.
//  Copyright (c) 2015 Tanguy Hélesbeux. All rights reserved.
//

#import "ILDirectoryTableViewVC.h"

// Controllers
#import "ILImageVC.h"

// Models
#import "ILTreeItem.h"
#import "ILImageFile.h"

@interface ILDirectoryTableViewVC ()

@end

@implementation ILDirectoryTableViewVC

#pragma mark - Constructors

+ (instancetype)newWithDirectory:(ILDirectory *)directory {
    return [[ILDirectoryTableViewVC alloc] initWithDirectory:directory];
}

- (id)initWithDirectory:(ILDirectory *)directory {
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        self.directory = directory;
        self.title = NSLocalizedString(@"DEFAULT_DIRECTORY_NAME", nil);
    }
    return self;
}

#pragma mark - Getters & Setters

- (void)setDirectory:(ILDirectory *)directory {
    _directory = directory;
    [self.tableView reloadData];
}

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
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
    return [self.directory.tree count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
//        Initialize cell
        
    }
//     Customize cell
    ILTreeItem *treeItem = [self.directory.tree objectAtIndex:indexPath.row];
    cell.textLabel.text = [treeItem nameWithExtension:YES];
    
    if ([treeItem isDirectory]) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ILTreeItem *treeItem = [self.directory.tree objectAtIndex:indexPath.row];
    
    if ([treeItem isDirectory]) {
        [self openDirectory:(ILDirectory *)treeItem];
    } else if ([treeItem isImage]) {
        [self openImagefile:(ILImageFile *)treeItem];
    } else {
        
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)openDirectory:(ILDirectory *)directory {
    ILDirectoryTableViewVC *destination = [ILDirectoryTableViewVC newWithDirectory:directory];
    [self.navigationController pushViewController:destination animated:YES];
}

- (void)openImagefile:(ILImageFile *)imageFile {
    ILImageVC *destination = [ILImageVC newWithImageFile:imageFile];
    [self.navigationController pushViewController:destination animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end