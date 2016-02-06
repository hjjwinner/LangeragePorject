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
    
    let language_id = Expression<Int64>("language_id")///<
    let category_name = Expression<String>("category_name")///<
    
    let tabCategory = Table("category")///<列表

    static let sharedInstance = LASQLite();

    
    
    func categoryListWithLanguageNumber(LanguageNumber:Int64)->NSArray{
        
        let categoryList : NSMutableArray = []
        
        do{
            let path = NSBundle.mainBundle().pathForResource("lingopal", ofType: "sqlite3")!
            
            let LADB = try Connection(path, readonly: true)
        
            for row in try LADB.prepare(tabCategory.select(category_name).filter(language_id == LanguageNumber)) {
                
                var dictCategory : NSMutableDictionary = [:]
                
                dictCategory.setObject(row[category_name], forKey: "name")
                
                
                print(row[category_name])
                
                
                categoryList.addObject(dictCategory)
            }
            
        }catch{
            
        }
        
        return categoryList        
        
    }
    
    
    

    ///初始化
    private init() {}

    
}