//
//  SPAvatarView.m
//  WYSP
//
//  Created by HeChuang⌚️ on 16/9/28.
//  Copyright © 2016年 HeChuang⌚️. All rights reserved.
//

#import "SPAvatarView.h"
#import <UIImageView+WebCache.h>//需要SDIWebImage
@interface SPAvatarView ()
@property (strong, nonatomic) UIImageView * AvatarImage;
@property (strong, nonatomic) UIButton    * TapButton;
@property (strong, nonatomic) UIView      * BgView;
@end
@implementation SPAvatarView

- (instancetype)initWithAvatarUrl:(NSString *)avatarImage{
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        [[[UIApplication sharedApplication] keyWindow] addSubview:self];
        //AlphaView
        self.BgView = [[UIView alloc] init];
        self.BgView.frame = CGRectMake(UISIZE.width * 0.5, UISIZE.height * 0.5, 1, 1);
        self.BgView.backgroundColor = [UIColor whiteColor];
        self.BgView.alpha = 0.9;
        [self addSubview:self.BgView];
        //Image
        self.AvatarImage = [[UIImageView alloc] init];
        self.AvatarImage.frame = CGRectMake(UISIZE.width * 0.5, UISIZE.height * 0.5, 1, 1);
        self.AvatarImage.backgroundColor = [UIColor clearColor];
        self.AvatarImage.alpha = 1;
        self.AvatarImage.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.AvatarImage];
        //TapButton
        self.TapButton = [[UIButton alloc] init];
        [self addSubview:self.TapButton];
        [self.TapButton addTarget:self
                           action:@selector(dissView)
                 forControlEvents:UIControlEventTouchUpInside];
        self.TapButton.backgroundColor = [UIColor clearColor];
        self.TapButton.frame = [UIScreen mainScreen].bounds;
        //Pop
        [self PopViewWithImageUrl:avatarImage];
    }
    return self;
}

- (void)dissView{
    [UIView animateWithDuration:0.3 animations:^{
        self.AvatarImage.frame = CGRectMake(UISIZE.width * 0.5, UISIZE.height * 0.5, 1, 1);
        self.BgView.frame   = CGRectMake(UISIZE.width * 0.5, UISIZE.height * 0.5, 1, 1);
    }completion:^(BOOL finished) {
        self.BgView = nil;
        self.AvatarImage = nil;
        self.TapButton = nil;
        [self removeFromSuperview];
    }];
}

- (void)PopViewWithImageUrl:(NSString *)url{
    [self.AvatarImage sd_setImageWithURL:[NSURL URLWithString:url]
                        placeholderImage:[UIImage imageNamed:@"图片的占位图"]];
    [UIView animateWithDuration:0.3 animations:^{
        self.AvatarImage.frame = [UIScreen mainScreen].bounds;
        self.BgView.frame = [UIScreen mainScreen].bounds;
    }];
}

@end
