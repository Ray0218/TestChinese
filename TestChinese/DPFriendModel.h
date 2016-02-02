//
//  DPFriendModel.h
//  TestChinese
//
//  Created by Ray on 15/12/16.
//  Copyright © 2015年 Ray. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "pinyin.h"

@interface DPFriendModel : NSObject

@property(nonatomic,strong)NSString *userName ;
@property(nonatomic, assign)NSInteger userAge ;

@property(nonatomic,strong)NSString *userNamePingYing ;


//-----  返回tableview右方indexArray
+(NSMutableArray*)IndexArray:(NSArray*)modelArr;

//-----  返回联系人
+(NSMutableArray*)LetterSortModelArray:(NSArray*)modelArr ;



///----------------------
//返回一组字母排序数组(中英混排)
+(NSMutableArray*)SortArray:(NSArray*)modelArr;

@end
