//
//  TWPickerViewController.m
//  TWToolkit
//
//  Created by Sam Soffes on 10/9/08.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "TWPickerViewController.h"

@implementation TWPickerViewController

@synthesize selectedKey = _selectedKey, keys = _keys, currentIndexPath = _currentIndexPath;

#pragma mark -
#pragma mark NSObject
#pragma mark -

- (id)init {
	return self = [super initWithStyle:UITableViewStyleGrouped];
}


#pragma mark -
#pragma mark UIViewController Methods
#pragma mark -

- (void)viewDidLoad {
	[super viewDidLoad];
	[self loadKeys];
	if(self.selectedKey != nil) {
		self.currentIndexPath = [[NSIndexPath indexPathForRow:[self.keys indexOfObject:self.selectedKey] inSection:0] retain];
		[self.tableView reloadData];
		[self.tableView scrollToRowAtIndexPath:self.currentIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
	}
}

- (void)dealloc {
	[_keys release];
	[_selectedKey release];
	[_currentIndexPath release];
    [super dealloc];
}

#pragma mark -
#pragma mark PickerViewController Methods
#pragma mark -

// This method should be overridden by a subclass
- (void)loadKeys {
	self.keys = nil;
	self.selectedKey = nil;
}

// This method should be overridden by a subclass
- (NSString *)cellTextForKey:(NSString *)key {
	return key;
}

#pragma mark -
#pragma mark UITableViewDelegate
#pragma mark -

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	self.currentIndexPath = indexPath;
}

#pragma mark -
#pragma mark UITableViewDataSource
#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.keys count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *cellIdentifier = @"cellIdentifier";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:cellIdentifier] autorelease];
    }
	NSString *key = [self.keys objectAtIndex:indexPath.row];
	cell.textLabel.text = [self cellTextForKey:key];
	if([key isEqual:self.selectedKey] == YES) {
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
	} else {
		cell.accessoryType = UITableViewCellAccessoryNone;
	}
    return cell;
}

@end
