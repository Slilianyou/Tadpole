//
//  TableViewDataSource.h
//  Tadpole
//
//  Created by ss-iOS-LLY on 16/6/24.
//  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TableViewDataSource : NSObject<UITableViewDataSource>
@property (nonatomic, strong) NSArray *array;
@end
