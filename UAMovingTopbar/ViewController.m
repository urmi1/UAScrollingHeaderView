

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


#pragma mark - View Life Cycle

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    _arrheaderInfo = [[NSMutableArray alloc] initWithObjects:@"Nov 10, 2013",@"Sept 11, 2013",@"Aug 12, 2013",@"Nov 13, 2013",@"Nov 14, 2013",@"Nov 15, 2013",@"Nov 16, 2013",@"Dec 17, 2013",@"Nov 18, 2013", nil];
    NSMutableArray *titleTextArray = [[NSMutableArray alloc] init];
    NSMutableArray *arrColorInfo = [[NSMutableArray alloc] init];
    
    _arrTableInfo = [[NSMutableArray alloc] init];
    for(int i=0;i<9;i++){
        
        if(i== 1 || i == 4){
            arrColorInfo = [[NSMutableArray alloc] initWithObjects:[UIColor yellowColor],[UIColor greenColor],[UIColor cyanColor], nil];
            titleTextArray = [[NSMutableArray alloc] initWithObjects:@"Title 1",@"Title 2",@"Title 3", nil];
        }else if(i== 2 || i == 7){
            arrColorInfo = [[NSMutableArray alloc] initWithObjects:[UIColor lightGrayColor],[UIColor clearColor],[UIColor purpleColor], nil];
            titleTextArray = [[NSMutableArray alloc] initWithObjects:@"Title 4",@"Title 5",@"Title 6", nil];
        }else if(i == 3 || i == 5){
            arrColorInfo = [[NSMutableArray alloc] initWithObjects:[UIColor redColor],[UIColor cyanColor],[UIColor magentaColor], nil];
            titleTextArray = [[NSMutableArray alloc] initWithObjects:@"Title 7",@"Title 8",@"Title 9", nil];
        }else if(i == 0 || i == 6){
            arrColorInfo = [[NSMutableArray alloc] initWithObjects:[UIColor redColor],[UIColor cyanColor],[UIColor blackColor], nil];
            titleTextArray = [[NSMutableArray alloc] initWithObjects:@"Title 10",@"Title 11",@"Title 12", nil];
        }else{
            arrColorInfo = [[NSMutableArray alloc] initWithObjects:[UIColor greenColor],[UIColor darkGrayColor],[UIColor magentaColor], nil];
            titleTextArray = [[NSMutableArray alloc] initWithObjects:@"Title 13",@"Title 14",@"Title 15", nil];
        }
        
        NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
        for(int j=0;j<3;j++){
            TableInfo *tableInfo = [[TableInfo alloc] init];
            tableInfo.name = [titleTextArray objectAtIndex:j];
            tableInfo.viewColor = [arrColorInfo objectAtIndex:j];
            tableInfo.desctiptionDetail = @"Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque";
            [tmpArray addObject:tableInfo];
        }
        
        [_arrTableInfo addObject:tmpArray];
    }
    
    _arrSearchInfo = [[NSMutableArray alloc] initWithArray:_arrTableInfo];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [_arrTableInfo count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if([[_arrTableInfo objectAtIndex:section] count] > 0)
        return 25.0;
    else
        return 0.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 78.0;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CustomHeaderView *customHeaderView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CustomHeaderView class]) owner:nil options:nil][0];
    customHeaderView.lblHeader.text = [NSString stringWithFormat:@"%@",[_arrheaderInfo objectAtIndex:section]];
    return customHeaderView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[_arrTableInfo objectAtIndex:section] count];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    [cell setBackgroundColor:[UIColor clearColor]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"CustomCell";
    CustomCell *cell = (CustomCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!cell){
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CustomCell class]) owner:nil options:nil][0];
    }
    
    TableInfo * tableInfo = [[_arrTableInfo objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    [cell.viewColor setBackgroundColor:tableInfo.viewColor];
    cell.lblTitle.text = tableInfo.name;
    cell.lblDescription.text = tableInfo.desctiptionDetail;
    
    return cell;
}


-(void)loadSectionData{
    _arrTableInfo = [NSMutableArray arrayWithArray:_arrSearchInfo];
    [self.tableViewController reloadData];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if(searchText.length == 0)
        [self loadSectionData];
    else
        [self searchAutocompleteEntriesWithSubstring:searchBar.text];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar{
    [searchBar resignFirstResponder];
    [self loadSectionData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    [self searchAutocompleteEntriesWithSubstring:searchBar.text];
}

- (void)searchAutocompleteEntriesWithSubstring:(NSString *)searchText{
    [_arrTableInfo removeAllObjects];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(name CONTAINS[c] %@) OR (desctiptionDetail CONTAINS[c] %@)",searchText,searchText];
    
    _arrTableInfo = [[NSMutableArray alloc] init];
    [_arrSearchInfo enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSArray *tmpArray = [[NSArray arrayWithArray:[_arrSearchInfo objectAtIndex:idx]] filteredArrayUsingPredicate:predicate];
        [_arrTableInfo addObject:tmpArray];
    }];
    
    [self.tableViewController reloadData];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    searchBar.showsCancelButton = YES;
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    searchBar.showsCancelButton = NO;
    return YES;
}

@end
