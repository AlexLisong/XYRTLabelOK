//
//  ViewController.m
//  XYRTLabelOKDome
//
//  Created by Heaven on 12-12-6.
//  Copyright (c) 2012年 Heaven. All rights reserved.
//

#import "ViewController.h"
#import "XY_UILabelOK.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    label1 = [[[XYUILabelOK alloc] initWithFrame:CGRectMake(10, 40, 300, 500)] autorelease];
    NSString *str = [[[NSBundle mainBundle] bundlePath] stringByAppendingString:@"/text.txt"];
    [label1 setLabFont:@"HelveticaNeue-CondensedBold" labFontSize:12 labFontAddition:nil];
    [label1 setTextwithFile:str originTime:0 maxTime:5];
    [self.view addSubview:label1];
    [label1 setTask:kTASK_START];
    
    label2 = [[[XYUILabelOK alloc] initWithFrame:CGRectMake(10, 150, 300, 500)] autorelease];
    [label2 setLabFont:@"AmericanTypewriter" labFontSize:20 labFontAddition:nil];
    [label2 setTextwithFile:str originTime:5 maxTime:10];
    [self.view addSubview:label2];
    [label2 setTask:kTASK_START];
    
    label3 = [[[XYUILabelOK alloc] initWithFrame:CGRectMake(10, 300, 300, 500)] autorelease];
    [label3 setLabFont:@"HelveticaNeue-CondensedBold" labFontSize:20 labFontAddition:nil];
    [label3 setTextwithFile:str originTime:10 maxTime:19];
    [self.view addSubview:label3];
    [label3 setTask:kTASK_START];
    
    str = [[[NSBundle mainBundle] bundlePath] stringByAppendingString:@"/audio.mp3"];
   // [self playSound:str];
    
    timerTnterval = 0.1;
    timerLaber =[NSTimer scheduledTimerWithTimeInterval:timerTnterval target:self selector:@selector(runTimer:) userInfo:nil repeats:YES];
    
}
- (void)runTimer:(id)timer
{
    //需要调用的代码
    [label1 updataTextWithInterval:timerTnterval];
    [label2 updataTextWithInterval:timerTnterval];
    [label3 updataTextWithInterval:timerTnterval];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)playSound:(NSString *)playPath{
    NSURL *soundUrl=[[NSURL alloc] initFileURLWithPath:playPath];
    audioPlayer2=[[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
    audioPlayer2.numberOfLoops = 0;
    [audioPlayer2 setVolume:.5];
    [audioPlayer2 play];
    [soundUrl release];
}
@end
