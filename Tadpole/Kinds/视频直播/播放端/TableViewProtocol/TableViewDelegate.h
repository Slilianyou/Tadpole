//
//  TableViewDelegate.h
//  Tadpole
//
//  Created by ss-iOS-LLY on 16/6/27.
//  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^CellSelectedBlock) (id obj);
@interface TableViewDelegate : NSObject<UITableViewDelegate>
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) CellSelectedBlock cellSelectedBlock;
@end
