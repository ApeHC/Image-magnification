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
    __weak typeof(self) _weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        _weakSelf.AvatarImage.frame = CGRectMake(UISIZE.width * 0.5, UISIZE.height * 0.5, 1, 1);
        _weakSelf.BgView.frame   = CGRectMake(UISIZE.width * 0.5, UISIZE.height * 0.5, 1, 1);
    }completion:^(BOOL finished) {
        _weakSelf.BgView = nil;
        _weakSelf.AvatarImage = nil;
        _weakSelf.TapButton = nil;
        [_weakSelf removeFromSuperview];
    }];
}

- (void)PopViewWithImageUrl:(NSString *)url{
    [self.AvatarImage sd_setImageWithURL:[NSURL URLWithString:url]
                        placeholderImage:[UIImage imageNamed:@"图片的展位图"]];
    __weak typeof(self) _weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        _weakSelf.AvatarImage.frame = [UIScreen mainScreen].bounds;
        _weakSelf.BgView.frame = [UIScreen mainScreen].bounds;
    }];
}

@end
