//
//  ViewController.m
//  CustomPaging
//
//  Created by Mariya Kholod on 5/2/13.
//  Copyright (c) 2013 Mariya Kholod. All rights reserved.
//

#import "ViewController.h"
#define PAGES_NUMBER 6

@interface ViewController ()

@end

@implementation ViewController

-(void)SetActivePageControlWithIndex:(int)index
{
    for (int i=0; i<[PageControlBtns count]; i++)
    {
        UIImage *backgroundImg = [[PageControlBtns objectAtIndex:i] backgroundImageForState:(i==index)?UIControlStateHighlighted:UIControlStateDisabled];
        [[PageControlBtns objectAtIndex:i] setBackgroundImage:backgroundImg forState:UIControlStateNormal];
        [[PageControlBtns objectAtIndex:i] setTitleColor:(i==index)?[UIColor whiteColor]:[UIColor grayColor] forState:UIControlStateNormal];
    }
}

-(void)onPageControlBtnPressed:(id)sender
{
    UIButton *button = (UIButton *)sender;
    
    int tag=button.tag-2000;
    
    [scrollView setContentOffset:CGPointMake(scrollView.frame.size.width*tag, 0) animated:YES];
    
    [self SetActivePageControlWithIndex:tag];
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)sender
{
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    [self SetActivePageControlWithIndex:page];
}

-(void)GeneratePages
{
    UIImage *PageControlImg = [UIImage imageNamed:@"page_deselected.png"];
    int x_coord = (self.view.frame.size.width-PageControlImg.size.width*PAGES_NUMBER)/2.0;
    
    PageControlBtns = [[NSMutableArray alloc] init];
    
    for (int i=0; i<PAGES_NUMBER; i++)
    {
        
        UIView *Page = [[UIView alloc] initWithFrame:CGRectMake(scrollView.frame.size.width*i, 0.0, scrollView.frame.size.width, scrollView.frame.size.height)];
        Page.backgroundColor = [UIColor colorWithRed:0.32 green:0.55 blue:0.88 alpha:1.0];
        
        UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 10.0, Page.frame.size.width-20.0, 40.0)];
        titleLbl.backgroundColor = [UIColor clearColor];
        titleLbl.textColor = [UIColor whiteColor];
        titleLbl.font = [UIFont boldSystemFontOfSize:16.0];
        titleLbl.text = [NSString stringWithFormat:@"This is page number %d", i+1];
        titleLbl.textAlignment = UITextAlignmentCenter;
        [Page addSubview:titleLbl];
        
        [scrollView addSubview:Page];
        
        UIButton *PageControlBtn = [[UIButton alloc] initWithFrame:CGRectMake(x_coord+i*PageControlImg.size.width, scrollView.frame.origin.y+scrollView.frame.size.height+20.0, PageControlImg.size.width, PageControlImg.size.height)];
        [PageControlBtn setBackgroundImage:[UIImage imageNamed: (i==0)?@"page_selected.png":@"page_deselected.png"] forState:UIControlStateNormal];
        [PageControlBtn setBackgroundImage:[UIImage imageNamed: @"page_selected.png"] forState:UIControlStateHighlighted];
        [PageControlBtn setBackgroundImage:[UIImage imageNamed: @"page_deselected.png"] forState:UIControlStateDisabled];
        [PageControlBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [PageControlBtn setTitleColor:(i==0)?[UIColor whiteColor]:[UIColor grayColor] forState:UIControlStateNormal];
        PageControlBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
        PageControlBtn.titleLabel.textAlignment = UITextAlignmentCenter;
        [PageControlBtn setTitle:[NSString stringWithFormat:@"%d", i+1] forState:UIControlStateNormal];
        [PageControlBtn setTitle:[NSString stringWithFormat:@"%d", i+1] forState:UIControlStateSelected];
        [PageControlBtn setTag:i+2000];
        [PageControlBtn addTarget:self action:@selector(onPageControlBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:PageControlBtn];
        
        [PageControlBtns addObject:PageControlBtn];
    }
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width*PAGES_NUMBER, scrollView.frame.size.height);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(50.0, 50.0, self.view.frame.size.width-100.0, self.view.frame.size.width-100.0)];
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:scrollView];
    
    [self GeneratePages];
}

-(NSUInteger)supportedInterfaceOrientations
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        return UIInterfaceOrientationMaskAll;
    else
        return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        return YES;
    else
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
