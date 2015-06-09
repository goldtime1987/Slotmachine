//
//  Engine.cpp
//  SlotoRama
//
//  Created by admin on 9/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#include "Engine.h"
#import "DeviceSettings.h"
#import "AppSettings.h"
#import "SoundManager.h"

int nCardsScore[CHARACTER_COUNT][COL_] = {
    {0, 5, 50, 500, 5000},
    {0, 0, 5,  25,  50},
    {0, 2, 40, 200, 1000},
    {0, 2, 30, 150, 500},
    {0, 2, 25, 100, 300},
    {0, 0, 20, 75,  200},
    {0, 0, 20, 75,  200},
    {0, 0, 15, 50,  100},
    {0, 0, 15, 50,  100},
    {0, 0, 10, 25,  50},
    {0, 0, 10, 25,  50},
};

int nArrRules[RULE_LINE_COUNT][COL_][2] = {
    {{2,0}, {2,1}, {2,2}, {2,3}, {2,4}},
    {{1,0}, {1,1}, {1,2}, {2,3}, {1,4}},
    {{3,0}, {3,1}, {3,2}, {3,3}, {3,4}},
    {{1,0}, {2,1}, {3,2}, {2,3}, {1,4}},
    {{3,0}, {2,1}, {1,2}, {2,3}, {3,4}},
    {{2,0}, {1,1}, {1,2}, {1,3}, {2,4}},
    {{2,0}, {3,1}, {3,2}, {3,3}, {2,4}},
    {{1,0}, {2,1}, {2,2}, {2,3}, {1,4}},
    {{3,0}, {2,1}, {2,2}, {2,3}, {3,4}},
};

Engine::Engine() {
    InitVariable();
    InitSlot();
}

void Engine::getInfo() {
    m_nGameCoin = [AppSettings getCoin];
    m_nRuleLineCount = [AppSettings getLineCount];
    m_nMaxLineCount = [AppSettings getMaxLineCount];
    m_nBet = [AppSettings getBetCount];
}

void Engine::InitVariable() {
    m_bStartSlot = false;
    int nPrevStep = PREVSTEP;
    getInfo();
    for (int i = 0; i < COL_; i++) {
        m_nRowIndex[i] = DEFAULT_RINDEX;
    }
    for(int i = 0; i < COL_; i++){
        InitCardStartPosY(i);
        m_bSloting[i] = false;
        m_fMovingYStep[i] = MIN_VEL;
        m_fPrevStep[i] = - (rand() % nPrevStep + iDevPixelY(2.0f));
    }
}

void Engine::LoadSlot() {
    m_bStartSlot = true;
    m_bLoad = true;
    NSString* strSlot = [AppSettings getSlot];
    NSString* strTempSlot = [AppSettings getTempSlot];
    NSString* strRowIndex = [AppSettings getRowIndex];
    NSString* strGameResult = [AppSettings getGameResult];
    int nCount = 0;    
    for (int i = 0; i < CHARACTER_COUNT; i++) {
        for (int j = 0; j < COL_; j++) {
            if (i == 0)
                m_nRowIndex[i] = [strRowIndex characterAtIndex:nCount] - 1;
            if (i < ROW_)
                m_nArrSlot[i][j] = [strSlot characterAtIndex:nCount] - 1;
            m_nArrTempSlot[i][j] = [strTempSlot characterAtIndex:nCount] - 1;
            nCount++;
        }
    }
    nCount = [AppSettings getGameResultCount];
    for (int i = 0; i < nCount; i++) {
        int result;
        GAMERESULT_ r;
        result =[strGameResult characterAtIndex:i*3] - 1;
        r.nRuleLineIndex = result;
        result= [strGameResult characterAtIndex:i*3+1] - 1; 
        r.nEqualCount  = result;
        result = [strGameResult characterAtIndex:i*3+2] - 1;
        r.nCharacterIndex = result;
        
        m_vecGameResult.push_back(r);
    }
}

void Engine::InitSlot() {
    int temp = 0;
    int changeIndex = 0;    
    
    if ([AppSettings getPayTableFlag]) {
        LoadSlot();
        return;
    }
    for (int i = 0; i < CHARACTER_COUNT; i++) {
        for (int j=  0; j < COL_; j++) {
            m_nArrTempSlot[i][j] = i;
        }
    }
    for (int loopIndex = 0; loopIndex < 5; loopIndex++) {
        for (int i = 0; i < CHARACTER_COUNT; i++) {
            for (int j=  0; j < COL_; j++) {
                bool bFlag = true;
                while (bFlag) {
                    changeIndex = rand() % CHARACTER_COUNT;
                    if (changeIndex != i) {
                        temp = m_nArrTempSlot[i][j];
                        m_nArrTempSlot[i][j] = m_nArrTempSlot[changeIndex][j];
                        m_nArrTempSlot[changeIndex][j] = temp;
                        bFlag = false;
                    }
                }
            }
        }
    }
    
    for (int i = 0; i < ROW_; i++) {
        for (int j = 0; j < COL_; j++)
            m_nArrSlot[i][j] = m_nArrTempSlot[i+7][j];
    }
}

void Engine::SetCardBetweenY(float fBetweenY) {
    m_fBetweenY = fBetweenY;
}

void Engine::InitCardStartPosY(int nColIndex) {
    if (m_bSloting[nColIndex])
        m_fMovingY[nColIndex] -= m_fBetweenY;
    else 
         m_fMovingY[nColIndex] = 0;
}

void Engine::ResetSlot(int nColIndex) {
    if(m_fMovingY[nColIndex] >= m_fBetweenY){
        for(int j = ROW_ - 2; j >= 0; j--)
            m_nArrSlot[j + 1][nColIndex] = m_nArrSlot[j][nColIndex];
        m_nArrSlot[0][nColIndex] = m_nArrTempSlot[m_nRowIndex[nColIndex]][nColIndex];
        m_nRowIndex[nColIndex]--;
        if (m_nRowIndex[nColIndex] < 0) {
            m_nRowIndex[nColIndex] = CHARACTER_COUNT - 1;
        }
        InitCardStartPosY(nColIndex);
    }
}

void Engine::MoveSlot(int nColIndex) {
    if (m_strState[nColIndex] == @"prev") {
        m_fMovingY[nColIndex] += m_fPrevStep[nColIndex];
        if (m_fPrevStep[nColIndex] <= -iDevPixelY(0.2f))
            m_fPrevStep[nColIndex] /= 1.3f;
        else
            m_fPrevStep[nColIndex] = 0;
    }
    else {
        if (m_strState[nColIndex] == @"normal" && m_fMovingYStep[nColIndex] < MAX_VEL)
            m_fMovingYStep[nColIndex] += iDevPixelY(1.0f);
        
        if (m_strState[nColIndex] == @"last") {
            if (m_fMovingYStep[nColIndex] > MIN_VEL) {
                m_fMovingYStep[nColIndex] -= iDevPixelY(2.0f);
                if (m_fMovingYStep[nColIndex] < MIN_VEL)
                    m_fMovingYStep[nColIndex] = MIN_VEL;
            }
        }
        m_fMovingY[nColIndex] += m_fMovingYStep[nColIndex];
    }
}

void Engine::SetState(int tick, int nColIndex) {
    if (tick < PREVTICK)
        m_strState[nColIndex] = @"prev";
    else if (m_strState[nColIndex] != @"last")
        m_strState[nColIndex] = @"normal";
    if (m_bSloting[nColIndex] && m_strState[nColIndex] == @"last") {
        if (m_nSlotTick[nColIndex] < TICK) {
            m_nSlotTick[nColIndex]++;
        }
        else {
            m_bSloting[nColIndex] = false;
            m_nSlotTick[nColIndex] = 0;
        }
    }
}

void Engine::ProcessSlot(int tick) {
    
    for(int nColIndex = 0; nColIndex < COL_; nColIndex++){
        if(m_fMovingY[nColIndex] == 0 && !m_bSloting[nColIndex])
            continue;
        SetState(tick, nColIndex);
        MoveSlot(nColIndex);
        ResetSlot(nColIndex);        
    }   
}

bool Engine::isStopAllSlots() {
    bool bIsStop = true;
    for(int i = 0; i < COL_; i++)
        bIsStop &= !m_bSloting[i];
    return bIsStop;
}

void Engine::CompareCards() {
    int nPrevStep = PREVSTEP;
    for (int i = 0; i < COL_; i++) {
        m_fMovingYStep[i] = MIN_VEL;
        m_fPrevStep[i] = - (rand() % nPrevStep + iDevPixelY(2.0f));
    }
    
    m_bHit = false;
    m_bStartSlot = false;
    if (m_bLoad) {
        m_bLoad = false;
        return;
    }
    int nCardType = -1;
    int nEqualCount = 1;
    for(int nRuleLineIndex = 0; nRuleLineIndex < m_nRuleLineCount; nRuleLineIndex++){
        for(int nEqualIndex = 0; nEqualIndex < COL_ - 1; nEqualIndex++){
            int nFirstType = m_nArrSlot[nArrRules[nRuleLineIndex][nEqualIndex][0]][nArrRules[nRuleLineIndex][nEqualIndex][1]];
            int nSecondType = m_nArrSlot[nArrRules[nRuleLineIndex][nEqualIndex + 1][0]][nArrRules[nRuleLineIndex][nEqualIndex + 1][1]];
            if(nFirstType == nSecondType){
                nCardType = nFirstType;
                nEqualCount = nEqualIndex + 2;
            }
            else
                break;
        }
        int nCoin = nCardsScore[nCardType][nEqualCount - 1]; 
        if( nCoin > 0 && nCardType > -1){
            m_bHit = true;
            GAMERESULT_ r;
            r.nRuleLineIndex = nRuleLineIndex;
            r.nEqualCount = nEqualCount;
            r.nCharacterIndex = nCardType;
            
            m_vecGameResult.push_back(r);
            
            [[SoundManager sharedSoundManager] playEffect:@"increase.wav" bForce:YES];
            m_nGameCoin += m_nBet*nCardsScore[nCardType][nEqualCount - 1];
            nEqualCount = 1;
            nCardType = -1;
        }
    }
    if (!m_bHit) {
        [[SoundManager sharedSoundManager] playEffect:@"decrease.wav" bForce:YES];
        m_nGameCoin -= m_nBet*m_nRuleLineCount;
    }
    [AppSettings setCoin: m_nGameCoin];
}
