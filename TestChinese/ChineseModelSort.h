//
//  ChineseModelSort.h
//  TestChinese
//
//  Created by Ray on 15/12/16.
//  Copyright © 2015年 Ray. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "pinyin.h"
#import "DPFriendModel.h"

@interface ChineseModelSort : NSObject


 @property(strong,nonatomic)NSString *string;
@property(strong,nonatomic)NSString *pinYin;

//-----  返回tableview右方indexArray
+(NSMutableArray*)IndexArray:(NSArray*)stringArr;

//-----  返回联系人
 +(NSMutableArray*)LetterSortModelArray:(NSArray*)stringArr ;



///----------------------
//返回一组字母排序数组(中英混排)
+(NSMutableArray*)SortArray:(NSArray*)stringArr;

@end
