//
//  DPFriendModel.m
//  TestChinese
//
//  Created by Ray on 15/12/16.
//  Copyright © 2015年 Ray. All rights reserved.
//

#import "DPFriendModel.h"

@implementation DPFriendModel

#pragma mark - 返回tableview右方 indexArray
+(NSMutableArray*)IndexArray:(NSArray*)modelArr
{
    NSMutableArray *tempArray = [self ReturnSortChineseModelArrar:modelArr];
    NSMutableArray *A_Result = [NSMutableArray array];
    NSString *tempString ;
    
    for (NSString* object in tempArray)
    {
        NSString *pinyin = [((DPFriendModel*)object).userNamePingYing substringToIndex:1];
        //不同
        if(![tempString isEqualToString:pinyin])
        {
            // NSLog(@"IndexArray----->%@",pinyin);
            [A_Result addObject:pinyin];
            tempString = pinyin;
        }
    }
    return A_Result;
}

#pragma mark - 返回联系人

+(NSMutableArray*)LetterSortModelArray:(NSArray*)modelArr
{
    NSMutableArray *tempArray = [self ReturnSortChineseModelArrar:modelArr];
    NSMutableArray *LetterResult = [NSMutableArray array];
    NSMutableArray *item = [NSMutableArray array];
    NSString *tempString;
    //拼音分组
    for (DPFriendModel* object in tempArray) {
        
        NSString *pinyin = [((DPFriendModel*)object).userNamePingYing substringToIndex:1];
        //        NSString *string = ((DPFriendModel*)object).userName;
        //不同
        if(![tempString isEqualToString:pinyin])
        {
            //分组
            item = [NSMutableArray array];
            [item  addObject:object];
            [LetterResult addObject:item];
            //遍历
            tempString = pinyin;
        }else//相同
        {
            [item  addObject:object];
        }
    }
    return LetterResult;
}


#pragma mark - 返回排序好的model数组
+(NSMutableArray*)ReturnSortChineseModelArrar:(NSArray*)modelArr
{
    //获取字符串中文字的拼音首字母并与字符串共同存放
    NSMutableArray *chineseModelsArray=[NSMutableArray array];
    for(int i=0;i<[modelArr count];i++)
    {
        
        DPFriendModel *model = modelArr[i] ;
        
        if(model.userName == nil){
            model.userName = @"";
        }
        //去除两端空格和回车
        model.userName = [model.userName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        
        //这里我自己写了一个递归过滤指定字符串   RemoveSpecialCharacter
        model.userName = [DPFriendModel RemoveSpecialCharacter:model.userName];
        
        
        //判断首字符是否为字母
        NSString *regex = @"[A-Za-z]+";
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
        NSString *initialStr = [model.userName length]?[model.userName substringToIndex:1]:@"";
        if ([predicate evaluateWithObject:initialStr])
        {
            NSLog(@"chineseString.string== %@",model.userName);
            //首字母大写
            model.userNamePingYing = [model.userName capitalizedString] ;
        }else{
            if(![model.userName isEqualToString:@""]){
                NSString *pinYinResult = [NSString string];
                for(int j=0;j<model.userName.length;j++){
                    NSString *singlePinyinLetter = [[NSString stringWithFormat:@"%c",
                                                     
                                                     pinyinFirstLetter([model.userName characterAtIndex:j])]uppercaseString];
                    //                    NSLog(@"singlePinyinLetter ==%@",singlePinyinLetter);
                    
                    pinYinResult = [pinYinResult stringByAppendingString:singlePinyinLetter];
                }
                model.userNamePingYing = pinYinResult;
            }else{
                model.userNamePingYing = @"";
            }
        }
        [chineseModelsArray addObject:model];
    }
    //按照拼音首字母对这些Strings进行排序
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"userNamePingYing" ascending:YES]];
    [chineseModelsArray sortUsingDescriptors:sortDescriptors];
    
    //    for(int i=0;i<[chineseStringsArray count];i++){
    //        NSLog(@"chineseStringsArray====%@",((ChineseString*)[chineseStringsArray objectAtIndex:i]).pinYin);
    //    }
    NSLog(@"-----------------------------");
    return chineseModelsArray;
}


#pragma mark - 返回一组字母排序数组
+(NSMutableArray*)SortArray:(NSArray*)modelArr
{
    NSMutableArray *tempArray = [self ReturnSortChineseModelArrar:modelArr];
    
    //把排序好的内容从ChineseString类中提取出来
    NSMutableArray *result = [NSMutableArray array];
    for(int i=0;i<[modelArr count];i++){
        [result addObject:((DPFriendModel*)[tempArray objectAtIndex:i]).userName];
        NSLog(@"SortArray----->%@",((DPFriendModel*)[tempArray objectAtIndex:i]).userName);
    }
    return result;
}


//过滤指定字符串   里面的指定字符根据自己的需要添加 过滤特殊字符
+(NSString*)RemoveSpecialCharacter: (NSString *)str {
    NSRange urgentRange = [str rangeOfCharacterFromSet: [NSCharacterSet characterSetWithCharactersInString: @",.？、 ~￥#&<>《》()[]{}【】^@/￡¤|§¨「」『』￠￢￣~@#&*（）——+|《》$_€"]];
    if (urgentRange.location != NSNotFound)
    {
        return [self RemoveSpecialCharacter:[str stringByReplacingCharactersInRange:urgentRange withString:@""]];
    }
    return str;
}
@end