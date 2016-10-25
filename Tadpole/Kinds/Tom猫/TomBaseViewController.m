//
//  TomBaseViewController.m
//  Tadpole
//
//  Created by ss-iOS-LLY on 16/5/24.
//  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import "TomBaseViewController.h"

@interface TomBaseViewController ()

@end

@implementation TomBaseViewController

//- (void)viewWillAppear:(BOOL)animated
//{
//    [self.navigationController setNavigationBarHidden:YES];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initGifImageView];
}
- (void)initGifImageView
{
    gifImageView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    gifImageView.image = [UIImage imageNamed:@"cat_zeh0030.jpg"];
    [self.view addSubview:gifImageView];
}

- (void)startYawn
{
    [self initYawnArray];
    [self startAnimationWithImages:yawnArray duration:3];
    [self playSoundWithFile:@"p_yawn3_11a"];
}

- (void)initYawnArray
{
    if (!yawnArray) {
        yawnArray = [NSMutableArray arrayWithCapacity:31];
        for (int i = 0; i < 31; i++) {
            NSString *count = [NSString stringWithFormat:@"%02d",i];
            NSString *imageName = [NSString stringWithFormat:@"cat_zeh00%@.jpg",count];
            UIImage *image = [UIImage imageNamed:imageName];
            [yawnArray addObject:image];
        }
    }

}

- (void)initCymbalArray
{
    if (!cymbalArray) {
        cymbalArray = [NSMutableArray arrayWithCapacity:13];
        for (int i = 0; i < 13; i++) {
            NSString *count = [NSString stringWithFormat:@"%02d",i];
            NSString *imageName = [NSString stringWithFormat:@"cat_cymbal00%@.jpg",count];
            UIImage *image = [UIImage imageNamed:imageName];
            [cymbalArray addObject:image];
        }
    }
}

- (void)initTalkArray
{
    if (!talkArray) {
        talkArray = [NSMutableArray arrayWithCapacity:15];
        for (int i = 0; i < 15; i++) {
            NSString *count = [NSString stringWithFormat:@"%02d",i];
            NSString *imageName = [NSString stringWithFormat:@"cat_talk00%@.jpg",count];
            UIImage *image = [UIImage imageNamed:imageName];
            
            [talkArray addObject:image];
        }
    }

}

- (void)initDrinkArray
{
    if (!drinkArray) {
        drinkArray = [NSMutableArray arrayWithCapacity:81];
        for (int i = 0; i < 81; i++) {
            
            NSString *count= [NSString stringWithFormat:@"%02d",i];
            
            NSString *imageName = [NSString stringWithFormat:@"cat_drink00%@.jpg",count];
            UIImage *image = [UIImage imageNamed:imageName];
            
            [drinkArray addObject:image];
        }

    }
}

- (void)initFootLeftArray
{
    if (!footLeftArray) {
        footLeftArray = [NSMutableArray arrayWithCapacity:30];
        for (int i = 0; i < 30; i++) {
            NSString *count = [NSString stringWithFormat:@"%02d",i];
            
            NSString *imageName = [NSString stringWithFormat:@"cat_foot_left00%@.jpg",count];
            UIImage *image = [UIImage imageNamed:imageName];
            [footLeftArray addObject:image];
        }
    }
}

- (void)initFootRightArray
{
    if (!footRightArray) {
        footRightArray = [NSMutableArray arrayWithCapacity:30];
        for (int i = 0; i < 30; i++) {
            NSString *count = [NSString stringWithFormat:@"%02d",i];
            NSString *imageName = [NSString stringWithFormat:@"cat_foot_right00%@.jpg",count];
            UIImage *image = [UIImage imageNamed:imageName];
            [footRightArray addObject:image];
        }
    }
}
- (void)initStomachArray
{
    if (!stomachArray) {
        stomachArray = [NSMutableArray arrayWithCapacity:34];
        for (int i = 0; i < 33; i++) {
            NSString *count = [NSString stringWithFormat:@"%02d",i];
            NSString *imageName = [NSString stringWithFormat:@"cat_stomach00%@.jpg",count];
          
            UIImage *image = [UIImage imageNamed:imageName];
            [stomachArray addObject:image];
        }
    }
}

- (void)initKnockout1Array
{
    if (!knockout1Array) {
        knockout1Array = [NSMutableArray arrayWithCapacity:10];
        for (int i = 0; i < 10; i++) {
             NSString *count = [NSString stringWithFormat:@"%02d",i];
            NSString *imageName = [NSString stringWithFormat:@"cat_knockout00%@.jpg",count];
            UIImage *image = [UIImage imageNamed:imageName];
            [knockout1Array addObject:image];
        }
    }
}

- (void)initKnockout2Array
{
    if (!knockout2Array) {
        knockout2Array = [NSMutableArray arrayWithCapacity:81];
        for (int i = 0; i < 81; i++) {
             NSString *count = [NSString stringWithFormat:@"%02d",i];
            NSString *imageName = [NSString stringWithFormat:@"cat_knockout00%@.jpg",count];
            UIImage *image = [UIImage imageNamed:imageName];
            [knockout2Array addObject:image];
        }
    }
}
- (void)initScratchArray
{
    if (!scratchArray) {
        scratchArray = [NSMutableArray arrayWithCapacity:56];
         for (int i = 0; i < 56; i++) {
         NSString *count = [NSString stringWithFormat:@"%02d",i];
            NSString *imageName = [NSString stringWithFormat:@"Scratch00%@.jpg",count];
            UIImage *image = [UIImage imageNamed:imageName];
            [scratchArray addObject:image];
        }
    }
}
- (void)initBirdArray
{
    if (!birdArray) {
        birdArray = [NSMutableArray arrayWithCapacity:40];
        for (int i = 0; i < 40; i++) {
           NSString *count = [NSString stringWithFormat:@"%02d",i];
            NSString *imageName = [NSString stringWithFormat:@"cat_eat00%@.jpg",count];
         
            UIImage *image = [UIImage imageNamed:imageName];
            
            [birdArray addObject:image];
        }
    }
}

- (void)initPieArray
{
    if (!pieArray) {
        pieArray = [NSMutableArray arrayWithCapacity:23];
        for (int i = 0; i < 23; i++) {
          NSString *count = [NSString stringWithFormat:@"%02d",i];
            NSString *imageName = [NSString stringWithFormat:@"pie00%@.jpg",count];
            UIImage *image = [UIImage imageNamed:imageName];
            [pieArray addObject:image];
        }
    }
}

- (void)initFartArray
{
    if (!fartArray) {
        fartArray = [NSMutableArray arrayWithCapacity:28];
        for (int i = 0; i < 28; i++) {
            NSString *count = [NSString stringWithFormat:@"%02d",i];
            NSString *imageName = [NSString stringWithFormat:@"cat_fart00%@.jpg",count];
            UIImage *image = [UIImage imageNamed:imageName];
            [fartArray addObject:image];
        }
    }

}
- (void)initAngryArray
{
    
    if (!angryArray) {
        angryArray = [NSMutableArray arrayWithCapacity:26];
        for (int i = 0; i < 26; i++) {
            NSString *count = [NSString stringWithFormat:@"%02d",i];
            NSString *imageName = [NSString stringWithFormat:@"cat_angry00%@.jpg",count];
            UIImage *image = [UIImage imageNamed:imageName];
            [angryArray addObject:image];
        }
    }
}
- (void)initHappyArray
{
    if (!happyArray) {
        happyArray = [NSMutableArray arrayWithCapacity:29];
        for (int i = 0; i < 29; i++) {
            NSString *count = [NSString stringWithFormat:@"%02d",i];
            NSString *imageName = [NSString stringWithFormat:@"cat_happy00%@.jpg",count];
            UIImage *image = [UIImage imageNamed:imageName];
            [happyArray addObject:image];
        }
    }

}
-(void)startAnimationWithImages:(NSMutableArray *)images duration:(NSTimeInterval)duration
{
    [self startAnimationWithImages:images duration:duration repeatCount:1];
}

-(void)startAnimationWithImages:(NSMutableArray *)images duration:(NSTimeInterval)duration repeatCount:(int)repeatCount
{
    if (gifImageView.isAnimating) {
        [gifImageView stopAnimating];
    }
    
    if (player) {
        [player stop];
    }
    
    [NSThread cancelPreviousPerformRequestsWithTarget:self selector:@selector(playSoundWithFile:) object:@"pour_milk"];
    [NSThread cancelPreviousPerformRequestsWithTarget:self selector:@selector(playSoundWithFile:) object:@"p_drink_milk"];
    gifImageView.animationImages = nil;
    gifImageView.animationImages = images;
    
    gifImageView.animationDuration = duration;
    gifImageView.animationRepeatCount = repeatCount;
    
    [gifImageView startAnimating];
}

- (void)playSoundWithFile:(NSString *)filename
{
    [[SCListener sharedListener] stop];
    
    NSString *outputSound = [[NSBundle mainBundle]pathForResource:filename ofType:@"wav"];
    outUrlB = [NSURL fileURLWithPath:outputSound];
    
    NSError *error = nil;
    player = [[AVAudioPlayer alloc]initWithContentsOfURL:outUrlB error:&error];
    if (error) {
       NSLog(@"AVAudioPlayer error %@, %@", error, [error userInfo]);
    }
    
    [player play];
    player.delegate = self;
}

- (void)clearWithArray:(NSMutableArray *)array
{
    [array removeAllObjects];
}
- (void)startListen
{
    gifImageView.image = [UIImage imageNamed:@"cat_listen.jpg"];
}
- (void)stopListen
{
      gifImageView.image = [UIImage imageNamed:@"cat_zeh0030.jpg"];
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

@end
