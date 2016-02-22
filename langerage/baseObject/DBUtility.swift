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
    let audio_file = Expression<SQLite.Blob>("audio_file")///<
    
    
    let nativeLanguageTable = Table("native_language")///<语言列表
    let language_code = Expression<String>("language_code")///<语言code
    let feminine_id = Expression<Int64>("feminine_id")///<
    let itef_tag = Expression<Int64>("itef_tag")///<
    let language_name = Expression<String>("language_name")///<


    


    
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
    func getDetaliList(categoryID:Int64,languageID:Int64,toLanguageID:Int64)->NSArray{
        let categoryList : NSMutableArray = []
        
        do{
            let path = NSBundle.mainBundle().pathForResource("lingopal", ofType: "sqlite3")!
            
            let LADB = try Connection(path, readonly: true)
            
            var needFilterRow:Int64 = 0;
            
            for row in try LADB.prepare(phrase_category.select(needs_filtering,phrase_id).filter(category_id == categoryID)) {
                
                let languageModel : LAModel = LAModel()
                
                let needfilter = row[needs_filtering]
                
                
                languageModel.languageID = languageID
                
                languageModel.toLanguageID = toLanguageID

                
                if needfilter != 1 {
                    
                    languageModel.phraseID = row[phrase_id]
                    
                    languageModel.phrase = self.getPhraseString(languageID, phraseID:row[phrase_id]) as String
                    languageModel.toPhrase = self.getPhraseString(toLanguageID, phraseID:row[phrase_id]) as String

//                    self.soundWintLanguage(languageID, phraseID:row[phrase_id])
                    categoryList.addObject(languageModel)
                    needFilterRow = 0
                    
                }else{
                    
                    if needFilterRow == languageID {
                        
                        languageModel.phraseID = row[phrase_id]
                        languageModel.phrase = self.getPhraseString(languageID, phraseID:row[phrase_id]) as String
                        languageModel.toPhrase = self.getPhraseString(toLanguageID, phraseID:row[phrase_id]) as String

                        categoryList.addObject(languageModel)
                        
                    }
                    
                    needFilterRow += 1
                    

                }
                                
            }
            
        }catch{
            
        }
        
        return categoryList
    }
    
    ///<获取对话文字
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
    
    ///语言国家国旗图片
    func getLanguageCode(languageID:Int64)->String{
        do{
            let path = NSBundle.mainBundle().pathForResource("lingopal", ofType: "sqlite3")!
            
            let LADB = try Connection(path, readonly: true)
            
            
            for rowData in try LADB.prepare(nativeLanguageTable.select(language_code).filter(language_id == languageID)) {
                
                
                return String( rowData[language_code])
                
            }
            
        }catch{
            
        }
        
        return String("")

    }
    
    func countryList()->NSArray{
        
        let list : NSMutableArray = []
        
        do{
            let path = NSBundle.mainBundle().pathForResource("lingopal", ofType: "sqlite3")!
            
            let LADB = try Connection(path, readonly: true)
            
            
            for rowData in try LADB.prepare(nativeLanguageTable.select(language_code,feminine_id,itef_tag,language_name)) {
                
                let model : UserLanguageModel = UserLanguageModel()
                
                model.language_code = rowData[language_code]
                model.feminine_id = rowData[feminine_id]
                model.itef_tag = rowData[itef_tag]
                model.language_name = rowData[language_name]
                
                print(model.language_code,model.language_name,model.itef_tag,model.language_name)
                
                
                list.addObject(model)

                
            }
            
        }catch{
            
        }

        return list
        
    }
    
    

    ///获取播放语音
    func soundWintLanguage(languageID:Int64, phraseID:Int64)->NSData{
        
        var audioData : NSData = NSData()
        
        do {
            
            let path = NSBundle.mainBundle().pathForResource("audio", ofType: "sqlite3")!
            
            let LADB = try Connection(path, readonly: true)
            
            
            for row in try LADB.prepare(audioTable.select(audio_file).filter(language_id == languageID).filter(phrase_id == phraseID)) {
                print("audio_file =\(row[audio_file])")
                
                 audioData  = NSData.fromDatatypeValue(row[audio_file])
                
                return audioData
                
            }
            
        }catch{
            
        }
        
        return audioData
        
    }

    
}