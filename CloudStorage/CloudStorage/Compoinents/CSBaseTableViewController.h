//
//  CSBaseTableViewController.h
//  CloudStorage
//
//  Created by Anh Quoc on 7/14/14.
//  Copyright (c) 2014 anhquoc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSBaseTableViewController : UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate> {
    BOOL                            _isNeedSearch;
    BOOL                            _isSearchMode;
    UISearchBar                     *_searchBar;
    UISearchDisplayController       *searchDisplayController;
}

@property (nonatomic, assign) BOOL isNeedSearch;

@end
