//
//  LevelManager.h
//  Nature&Zombies
//
//  Created by WeiJinLong on 9/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface LevelManager : NSObject 
{
    int         m_nCurLevel;
	
	int			m_nTarget;
    NSMutableArray*     m_arrDish;
    
}
@property (nonatomic, assign) int           m_nCurLevel;
@property (nonatomic, assign) int			m_nTarget;
@property (nonatomic, retain) NSMutableArray* m_arrDish;

+(LevelManager*) sharedLevelManager;
-(void) initGameInfo;
-(void) setLevel: (int) level;
-(void) createLevelInfo: (int) level;

@end
