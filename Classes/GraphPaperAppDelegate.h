//
//  graphPaperAppDelegate.h
//  graphPaper
//
//  Created by James Randall on 11/10/2010.
//  Copyright 2010 Accidental Fish. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ApplicationViewController;

@interface GraphPaperAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    ApplicationViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ApplicationViewController *viewController;

@end

