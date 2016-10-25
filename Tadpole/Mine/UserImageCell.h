//
//  UserImageCell.h
//  CrazyDiary
//
//  Created by ss-iOS-LLY on 16/9/12.
//  Copyright © 2016年 lilianyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UserImageCellDelegate <NSObject>

- (void)tapUserImageForChange;

@end
@interface UserImageCell : UITableViewCell
@property (nonatomic, assign) id <UserImageCellDelegate> delegate;
@end
