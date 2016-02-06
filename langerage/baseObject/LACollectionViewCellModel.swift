//
//  LACollectionViewCellModel.swift
//  ChunBo
//
//  Created by hjjwinner on 15/7/9.
//  Copyright (c) 2015年 chunbo. All rights reserved.
//

import UIKit
import ObjectMapper

class LACollectionViewCellModel: NSObject ,Mappable{
    var cellIdentifier:String?
    var cellEdgeInstes:UIEdgeInsets?
    var cellSize:CGSize?
    var userInfor:NSDictionary?
    
    
    override init(){}
    
    required init?(_ map: Map) {
        super.init()
        
        mapping(map)
    }
    
    func mapping(map: Map) {
    }
    
}

class categoryCellModel: LACollectionViewCellModel {
    var cid : String?
    var name : String?
    var pid : String?

    
    required init?(_ map: Map) {
        super.init()
        
        mapping(map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        
        cid	<- map["cid"]
        name	<- map["name"]
        pid	<- map["pid"]
        
    }
}





/*

class OneProductCollectionViewCellModel: LACollectionViewCellModel {
    var title:String?
    
    var chunboPrice : String!
    var discountPrice : String!
    var giftName : String!
    var imageId : String!
    var isMain : String!
    var marketPrice : String!
    
    var name : String!{
        willSet(value){
            self.name = value
        }
    }

    var priority : String!
    var productId : String!
    var promoActivityType : String!
    var promoPrice : String!
    var promotionPrice : String!
    var salePrice : String!
    var shortname : String!
    var skuCode : String!
    var specifications : String!
    var stock : Int!
    var stockCount : Int!
    var subname : String!
    var url : String!
    var promoType : [Int]!{
        willSet(newPromoType){
            if newPromoType != nil{
            self.promoType = newPromoType
            }
        }
        
        didSet{
            if promoType != nil {
            for (_,type) in promoType.enumerate(){
                if type == 3{
                    self.promo_type3 = true
                }else if type == 4{
                    self.promo_type4 = true
                }else if type == 6{
                    self.promo_type6 = true
                }
            }
            }
        }
  
    }
    var promo_type3: Bool = false
    var promo_type4: Bool = false
    var promo_type6: Bool = false
    
    required init?(_ map: Map) {
        super.init()
        
        mapping(map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        
        chunboPrice	<- map["chunbo_price"]
        discountPrice	<- map["discount_price"]
        giftName	<- map["gift_name"]
        imageId	<- map["image_id"]
        isMain	<- map["is_main"]
        marketPrice	<- map["market_price"]
        name	<- map["name"]
        priority	<- map["priority"]
        productId	<- map["product_id"]
        promoActivityType	<- map["promo_activity_type"]
        promoPrice	<- map["promo_price"]
        promotionPrice	<- map["promotion_price"]
        salePrice	<- map["sale_price"]
        shortname	<- map["shortname"]
        skuCode	<- map["sku_code"]
        specifications	<- map["specifications"]
        stock	<- map["stock"]
        stockCount	<- map["stock_count"]
        subname	<- map["subname"]
        url	<- map["url"]
        promoType	<- map["promo_type"]

        self.titleValue()
        
    }
    
    func titleValue(){
        if name == nil {
            name = subname
        }
    }
    
    
    func priceColor()->UIColor{
        var color = UIColor.redColor()
        
        if promo_type3 {
            color = RGBA(231, g: 95, b: 68, a: 1)
        }else{
            color = RGBA(43, g: 188, b: 106, a: 1)
        }
        
        return color
    }
    
    func priceValue()->NSString{
        
        let value : NSString? = ""
        
        return value!
    }
    
    
    func originalPriceValue()->NSString{
        var value : NSString?
        
        value = ""
        return value!
    }
    
    func saleImageWithImage()->AnyObject{
        
        var image : UIImage?
        
        if promo_type3 {
            image = UIImage(named: "limitBuy")
        }else if promo_type4 {
            image = UIImage(named: "presell")
        }else{
            return NSNull()
        }
        
        return image! 
    }
    
    
}

class TopBannerCellModel: LACollectionViewCellModel {
    var cid : String?
    var banner1 : String?
    var priority : String?
    var banner1_url : String?
    var pic : String?
    var link_type : String?
    var name : String?
    var model_url : String?
    var pid : String?
    var parent_id : String?
    
    required init?(_ map: Map) {
        super.init()
        
        mapping(map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        
        cid	<- map["cid"]
        banner1	<- map["banner1"]
        priority	<- map["priority"]
        banner1_url	<- map["banner1_url"]
        pic	<- map["pic"]
        link_type	<- map["link_type"]
        name	<- map["name"]
        model_url	<- map["model_url"]
        pid	<- map["pid"]
        parent_id	<- map["parent_id"]

    }
}


class SpecialCollectionViewCellModel: LACollectionViewCellModel {
    
    var name : String?
    var pic_url : String?
    var text : String?
    var link : String?
    var adflag : String?
    var pid : String?
    var link_type : String?
    var adViewArray : NSArray?

    required init?(_ map: Map) {
        super.init()
        
        mapping(map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        
        name	<- map["name"]
        pic_url	<- map["pic_url"]
        text	<- map["text"]
        link	<- map["link"]
        adflag	<- map["adflag"]
        pid	<- map["pid"]
        link_type	<- map["link_type"]

    }

}


class bestRCollectionViewCellModel: LACollectionViewCellModel {
    
    var product_id : String?
    var name : String?
    var subname : String?
    var market_price : String?
    var chunbo_price : String?
    var specifications : String?
    var image_id : String?
    var url : String?
    var shortname : String?
    var sku_code : String?
    var is_main : String?
    var priority : String?
    var content_id : String?
    var buyer : String?
    var start_time : String?
    var end_time : String?
    var creation_time : String?
    var modification_time : String?
    var is_enabled : String?
    var pid : String?
    var des : String?
    var title : String?
    var stock_count : String?
    var promo_type : [Int]!{
        willSet(newValue){
            if newValue != nil{
                self.promo_type = newValue
            }
        }
        
        didSet{
            if promo_type != nil {
                for (_,type) in promo_type.enumerate(){
                    if type == 3{
                        self.promo_type3 = true
                    }else if type == 4{
                        self.promo_type4 = true
                    }else if type == 6{
                        self.promo_type6 = true
                    }
                }
            }
        }
        
    }
    var promo_type3: Bool = false
    var promo_type4: Bool = false
    var promo_type6: Bool = false

    
    var promotion_price : String?
    var sale_price : String?
    var discount_price : String?
    var bestArray :NSArray?
    
    required init?(_ map: Map) {
        super.init()
        
        mapping(map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        
        product_id	<- map["product_id"]
        name	<- map["name"]
        subname	<- map["subname"]
        market_price	<- map["market_price"]
        chunbo_price	<- map["chunbo_price"]
        specifications	<- map["specifications"]
        image_id	<- map["image_id"]
        url	<- map["url"]
        shortname	<- map["shortname"]
        sku_code	<- map["sku_code"]
        is_main	<- map["is_main"]
        priority	<- map["priority"]
        content_id	<- map["content_id"]
        buyer	<- map["buyer"]
        start_time	<- map["start_time"]
        end_time	<- map["end_time"]
        creation_time	<- map["creation_time"]
        modification_time	<- map["modification_time"]
        is_enabled	<- map["is_enabled"]
        pid	<- map["pid"]
        des	<- map["des"]
        title	<- map["title"]
        stock_count	<- map["stock_count"]
        promo_type	<- map["promo_type"]
        promotion_price	<- map["promotion_price"]
        sale_price	<- map["sale_price"]
        discount_price	<- map["discount_price"]


    }
    
    func priceColor()->UIColor{
        var color = UIColor.redColor()
        
        if promo_type3 {
            color = RGBA(231, g: 95, b: 68, a: 1)
        }else{
            color = RGBA(43, g: 188, b: 106, a: 1)
        }
        
        return color
    }
}

*/

