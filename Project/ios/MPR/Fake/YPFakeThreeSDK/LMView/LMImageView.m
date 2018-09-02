//
//  LMImageView.m
//  AiMianDan
//
//  Created by li on 14-6-17.
//  Copyright (c) 2014年 li. All rights reserved.
//

#import "LMImageView.h"
#import "UIImageView+WebCache.h"
@implementation LMImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
+(UIImageView *)lmImageView:(CGRect)rect andUrl:(NSString *)imageUrl andImageName:(NSString *)imagename
{
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:rect];
    if (imageUrl) {
        [imageView sd_setImageWithURL:[NSURL URLWithString:[imageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:imagename]];
        //[imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",imageUrl]] placeholderImage:[UIImage imageNamed:imagename]];
    }else
    {
        imageView.image=[UIImage imageNamed:imagename];
    }
    return imageView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
