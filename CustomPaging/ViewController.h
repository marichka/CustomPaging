//
//  ViewController.h
//  CustomPaging
//
//  Created by Mariya Kholod on 5/2/13.
//  Copyright (c) 2013 Mariya Kholod. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIScrollViewDelegate>
{
    UIScrollView* scrollView;

    NSMutableArray *PageControlBtns;
}
@end
