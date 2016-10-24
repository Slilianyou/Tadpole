//
//  LLYPhotoSource.h
//  Tadpole
//
//  Created by ss-iOS-LLY on 15/12/27.
//  Copyright © 2015年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//



#pragma mark LLYPhotoSource
@protocol LLYPhotoSource <NSObject>
/*
 * Array containing photo data objects.
 */
@property (nonatomic, readonly,retain) NSArray *photos;
/*
 * Number of photos.
 */
@property (nonatomic,readonly) NSInteger numberOfPhotos;
/*
 * Should return a photo from the photos array, at the index passed.
 */
- (id)photoAtIndex:(NSInteger)index;
@end

#pragma mark
#pragma mark LLYPhoto
@protocol LLYPhoto <NSObject>
/*
 * URL of the image, varied URL size should set according to display size.
 */

@property (nonatomic,readonly,retain) NSURL *url;
/*
 * The caption of the image.
 */
@property (nonatomic, readonly,retain)NSString *caption;
/*
 * Size of the image, CGRectZero if image is nil.
 */
@property (nonatomic)CGSize size;
/*
 * The image after being loaded, or local.
 */
@property (nonatomic,retain)UIImage *image;
@property (nonatomic,assign,getter=didFail)BOOL failed;











@end
