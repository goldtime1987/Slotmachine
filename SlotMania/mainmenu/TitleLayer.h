//
//  TitleLayer.h
//  hotair
//
//  Created by admin on 12/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "AppDelegate.h"
#import "GrowButton.h"
#import "AppDelegate.h"

@interface TitleLayer : CCLayer {
    AppDelegate* m_appDelegate;
    GrowButton *m_menuItem[6];
    CCLabelTTF *m_lblScore;
    //float       m_fScale;
}
-(void) initData;
-(void) initImages;
-(void) initLabels;
-(void) initMenu;
-(void) initStages;
-(void) initControls;
@end
