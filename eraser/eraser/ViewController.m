//
//  ViewController.m
//  eraser
//
//  Created by 沈 晨豪 on 14-5-4.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+SCHEraser.h"

@interface ViewController ()

@property (nonatomic,strong) UIImageView    *image_view;
@property (nonatomic,strong) NSMutableArray *point_array;

@end

@implementation ViewController

- (void)test
{
    NSArray *temp_point_array = @[[NSValue valueWithCGPoint:CGPointMake(309.000000, 71.500000)],[NSValue valueWithCGPoint:CGPointMake(303.000000, 71.500000)],[NSValue valueWithCGPoint:CGPointMake(288.000000, 72.500000)],[NSValue valueWithCGPoint:CGPointMake(244.500000, 79.000000)],[NSValue valueWithCGPoint:CGPointMake(216.500000, 80.000000)],[NSValue valueWithCGPoint:CGPointMake(186.000000, 83.000000)],[NSValue valueWithCGPoint:CGPointMake(147.500000, 86.000000)],[NSValue valueWithCGPoint:CGPointMake(104.500000, 88.000000)],[NSValue valueWithCGPoint:CGPointMake(67.000000, 90.000000)],[NSValue valueWithCGPoint:CGPointMake(38.000000, 91.500000)],[NSValue valueWithCGPoint:CGPointMake(11.500000, 93.500000)],[NSValue valueWithCGPoint:CGPointMake(98.000000, 206.500000)],[NSValue valueWithCGPoint:CGPointMake(131.500000, 225.500000)],[NSValue valueWithCGPoint:CGPointMake(165.000000, 245.000000)],[NSValue valueWithCGPoint:CGPointMake(196.000000, 258.500000)],[NSValue valueWithCGPoint:CGPointMake(249.500000, 270.000000)],[NSValue valueWithCGPoint:CGPointMake(265.000000, 271.000000)],[NSValue valueWithCGPoint:CGPointMake(276.500000, 273.000000)],[NSValue valueWithCGPoint:CGPointMake(282.500000, 273.000000)],[NSValue valueWithCGPoint:CGPointMake(288.000000, 273.000000)],[NSValue valueWithCGPoint:CGPointMake(291.000000, 273.000000)],[NSValue valueWithCGPoint:CGPointMake(292.000000, 274.000000)],[NSValue valueWithCGPoint:CGPointMake(292.500000, 275.000000)],[NSValue valueWithCGPoint:CGPointMake(292.500000, 277.000000)],[NSValue valueWithCGPoint:CGPointMake(292.500000, 278.000000)],[NSValue valueWithCGPoint:CGPointMake(292.500000, 279.000000)],[NSValue valueWithCGPoint:CGPointMake(285.500000, 284.500000)],[NSValue valueWithCGPoint:CGPointMake(267.500000, 291.500000)],[NSValue valueWithCGPoint:CGPointMake(241.500000, 299.000000)],[NSValue valueWithCGPoint:CGPointMake(204.000000, 305.000000)],[NSValue valueWithCGPoint:CGPointMake(160.500000, 312.500000)],[NSValue valueWithCGPoint:CGPointMake(106.000000, 319.500000)],[NSValue valueWithCGPoint:CGPointMake(59.500000, 325.500000)],[NSValue valueWithCGPoint:CGPointMake(12.500000, 331.000000)],[NSValue valueWithCGPoint:CGPointMake(48.000000, 451.000000)],[NSValue valueWithCGPoint:CGPointMake(97.000000, 477.000000)],[NSValue valueWithCGPoint:CGPointMake(146.000000, 498.000000)],[NSValue valueWithCGPoint:CGPointMake(190.000000, 514.500000)],[NSValue valueWithCGPoint:CGPointMake(226.500000, 523.000000)],[NSValue valueWithCGPoint:CGPointMake(259.500000, 528.000000)],[NSValue valueWithCGPoint:CGPointMake(294.000000, 533.500000)],[NSValue valueWithCGPoint:CGPointMake(198.500000, 550.500000)],[NSValue valueWithCGPoint:CGPointMake(131.000000, 550.500000)],[NSValue valueWithCGPoint:CGPointMake(68.500000, 550.500000)],[NSValue valueWithCGPoint:CGPointMake(21.500000, 550.500000)]];
    
    [self.image_view startErasureAnimationByPointFrame:temp_point_array
                                             frameTime:1 /40.0f
                                                radius:150.0f
                                        animationStart:^{
                                            NSLog(@"开始");
                                        } animationEnd:^{
                                            NSLog(@"结束");
                                        }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.image_view = [[UIImageView alloc] initWithFrame:self.view.bounds];
    
    [self.view addSubview:self.image_view];
    
    [self.image_view setImage:[UIImage imageNamed:@"hot_line-bottom@2x.png"]];
    
    [self.image_view addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
    
    self.point_array = [[NSMutableArray alloc] init];
    
//    [UIView animateWithDuration:10.0f animations:^{
//        self.image_view.frame = CGRectOffset(self.image_view.frame,
//                                       100.0f,
//                                       0.0f);
//    }];
//
    
    [self performSelector:@selector(test) withObject:nil afterDelay:3.0f];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    return;
	UITouch *touch = [touches anyObject];
	if(YES)
	{
		CGPoint currentPoint = [touch locationInView:self.image_view];
        
        [self.point_array addObject:[NSValue valueWithCGPoint:currentPoint]];
        
		UIGraphicsBeginImageContext(self.image_view.frame.size);
		[self.image_view.image drawInRect:self.image_view.bounds];
		CGContextClearRect (UIGraphicsGetCurrentContext(), CGRectMake(currentPoint.x-45, currentPoint.y-150.0f, 90.0f, 300));
		self.image_view.image = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();
	}
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
   
    NSLog(@"位置 %@",NSStringFromCGRect(self.image_view.frame));
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

    
    NSMutableString *t = [[NSMutableString alloc] init];
    [t appendString:@"@["];
    for (NSValue *value in self.point_array)
    {
        CGPoint point = [value CGPointValue];
        
        NSString *s = [NSString stringWithFormat:@"[NSValue valueWithCGPoint:CGPointMake(%f, %f)],",point.x,point.y];
        [t appendString:s];
    }
    
    [t appendString:@"]"];
    
    NSLog(@"%@",t);

}

@end
