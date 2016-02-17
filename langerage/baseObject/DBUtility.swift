//
//  DBUtility.swift
//  langerage
//
//  Created by autonavi on 16/2/6.
//  Copyright © 2016年 langerage. All rights reserved.
//

import Foundation
import SQLite
import UIKit


class LASQLite {
    
    
    
//    var path :NSString
    
    
    let tabCategory = Table("category")///<列表
    let language_id = Expression<Int64>("language_id")///<
    let category_name = Expression<String>("category_name")///<
    let category_id = Expression<Int64>("category_id")
    
    let phrase_category = Table("phrase_category")///<列表对应语句ID
    let phrase_id = Expression<Int64>("phrase_id")
    let needs_filtering = Expression<Int64>("needs_filtering")
    
    
    let phraseTable = Table("phrase")///<列表对应语句
    let phrase = Expression<String>("phrase")///<
    
    let audioTable = Table("audio")///<语音table

    let audio_file = Expression<String>("audio_file")///<

    


    
    static let sharedInstance = LASQLite();

    ///初始化
    private init() {}
    
    ///获取首页列表
    func categoryListWithLanguageNumber(LanguageNumber:Int64)->NSArray{
        
        let categoryList : NSMutableArray = []
        
        do{
            let path = NSBundle.mainBundle().pathForResource("lingopal", ofType: "sqlite3")!
            
            let LADB = try Connection(path, readonly: true)
        
            
            for row in try LADB.prepare(tabCategory.select(category_name,category_id).filter(language_id == LanguageNumber)) {
                
                let dictCategory : NSMutableDictionary = [:]
                
                dictCategory.setObject(row[category_name], forKey: "name")
                dictCategory.setObject("\(row[category_id])", forKey: "cid")
                
                
                categoryList.addObject(dictCategory)
                
            }
            
        }catch{
            
        }
        
        return categoryList        
        
    }
    
    
    ///获取详情列表对应ID
    func getDetaliList(categoryID:Int64,languageID:Int64)->NSArray{
        let categoryList : NSMutableArray = []
        
        do{
            let path = NSBundle.mainBundle().pathForResource("lingopal", ofType: "sqlite3")!
            
            let LADB = try Connection(path, readonly: true)
            
            var needFilterRow:Int64 = 0;
            
            for row in try LADB.prepare(phrase_category.select(needs_filtering,phrase_id).filter(category_id == categoryID)) {
                
                let languageModel : LAModel = LAModel()
                
                let needfilter = row[needs_filtering]
                
                
                languageModel.languageID = languageID

                
                if needfilter != 1 {
                    
                    languageModel.phraseID = row[phrase_id]
                    
                    languageModel.phrase = self.getPhraseString(languageID, phraseID:row[phrase_id]) as String
//                    self.soundWintLanguage(languageID, phraseID:row[phrase_id])
                    categoryList.addObject(languageModel)
                    needFilterRow = 0
                    
                }else{
                    
                    if needFilterRow == languageID {
                        
                        languageModel.phraseID = row[phrase_id]
                        languageModel.phrase = self.getPhraseString(languageID, phraseID:row[phrase_id]) as String
                        categoryList.addObject(languageModel)
                        
                    }
                    
                    needFilterRow += 1
                    

                }
                                
            }
            
        }catch{
            
        }
        
        return categoryList
    }
    
    
    func getPhraseString(languageID:Int64, phraseID:Int64)->NSString{
        
        do{
            let path = NSBundle.mainBundle().pathForResource("lingopal", ofType: "sqlite3")!
            
            let LADB = try Connection(path, readonly: true)
            
            
            for rowData in try LADB.prepare(phraseTable.select(phrase).filter(language_id == languageID).filter(phrase_id == phraseID)) {
                
                
                return String( rowData[phrase])
            
            }
            
        }catch{
            
        }
        
        return String("")
    }
    
    
    
    
    
    
    
    ///获取播放语音
    func soundWintLanguage(languageID:Int64, phraseID:Int64){
        
        do {
            
            let path = NSBundle.mainBundle().pathForResource("audio", ofType: "sqlite3")!
            
            let LADB = try Connection(path, readonly: true)
            
            
            for row in try LADB.prepare(audioTable.select(audio_file).filter(language_id == languageID).filter(phrase_id == phraseID)) {
                print("audio_file =\(row[audio_file])")
                
                
            }
            
        }catch{
            
        }
        
        
    }
    



    
}