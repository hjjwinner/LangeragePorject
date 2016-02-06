//
//  File.swift
//  langerage
//
//  Created by autonavi on 16/2/6.
//  Copyright © 2016年 langerage. All rights reserved.
//

import Foundation
import UIKit

class LATabBarController:UITabBarController {
    
    let compblock :(NSData,NSError) ->Void = { (data ,error)in
        
    }
    
    var CBtabBar :UIView = UIView(frame: CGRectMake(0, ScreenHeight - 49, ScreenWidth, 49))
    var barImageArray:NSMutableArray = []
    var barLabelArray:NSMutableArray = []
    
    override func viewDidLoad() {
        self.buildData()
        self.buildUI()
        
    }
    
    func buildData(){
        
        let muarray = NSMutableArray()
        
        for intdex in 1...5{
            var VC = UIViewController()
            if intdex%2 == 1{
                if intdex == 1{
                    VC = ViewController()
                }else{
                    VC.view.backgroundColor = UIColor.grayColor()
                }
                
            }else{
                VC.view.backgroundColor = UIColor.greenColor()
            }
            
            let naV = UINavigationController()
            
            if intdex == 1{
                naV.addChildViewController(VC)
                
            }else{
                naV.addChildViewController(VC)
                
            }
            let imag = UIImage()
            let str:NSString = "\(intdex)";
            let strr = String()
            strr.isEmpty
            
            naV.tabBarItem = UITabBarItem(title: str as String, image:imag, tag: intdex)
            
            muarray.addObject(naV)
            
        }
        
        self.viewControllers = muarray.copy() as? [UIViewController];
    }
    
    
    func buildUI(){
        self.tabBar.hidden = true;
        self.view.backgroundColor = UIColor.whiteColor()
        
        CBtabBar.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(CBtabBar)
        
        let lineView :UIView = UIView(frame: CGRectMake(0, 0, ScreenWidth, 1))
        lineView.backgroundColor = RGBA(153, g: 153, b: 153, a: 1)
        CBtabBar.addSubview(lineView)
        
        let items : NSArray = self.viewControllers!
        
        var images = ["home_tabbar_home",
            "home_tabbar_classify",
            "home_tabbar_discover",
            "home_tabbar_shoppingCar",
            "home_tabbar_profile"]
        
        var selectImages = ["home_tabbar_home_selected",
            "home_tabbar_classify_selected",
            "home_tabbar_discover_selected",
            "home_tabbar_shoppingCar_selected",
            "home_tabbar_profile_selected"]
        
        var itemName = ["类别","搜索","美食","收藏","设置"]
        
        
        
        
        for (index , _) in items.enumerate() {
            
            let itemWith :Int = Int(ScreenWidth)/items.count
            
            let itemRect : CGRect = CGRectMake(CGFloat( itemWith * index), CGFloat(0),CGFloat( itemWith), CGFloat(CBtabBar.bounds.height))
            
            
            let barItem = self.barItemCreat(index, imageName: images[index], selectImageName: selectImages[index], titleName: itemName[index], itemFram: itemRect)
            
            barItem.addTarget(self, action:"barItemClick:", forControlEvents: UIControlEvents.TouchUpInside)
            
            CBtabBar.addSubview(barItem)
            
        }
        /**
        默认选中第一个
        
        :returns: <#return value description#>
        */
        self.changeItemState(0)
    }
    
    func barItemCreat(barTag:Int , imageName:String , selectImageName:String ,titleName:String,itemFram:CGRect)->UIButton{
        let barItem :UIButton = UIButton(frame: itemFram)
        barItem.tag = barTag
        let itemImage :UIImageView = UIImageView(frame: CGRectMake(CGFloat((itemFram.width - 30)/2), 5 , 30, 25))
        itemImage.image = UIImage(named: imageName)
        itemImage.highlightedImage = UIImage(named: selectImageName)
        barItem.addSubview(itemImage)
        barImageArray.addObject(itemImage)
        
        let label: UILabel = UILabel(frame: CGRectMake(0, itemFram.height - 20, itemFram.width, 20))
        label.text = titleName
        label.textAlignment = .Center
        label.font = UIFont.systemFontOfSize(11)
        label.textColor = RGBA(153, g: 153, b: 153, a: 1)
        label.highlightedTextColor = RGBA(43, g: 188, b: 106, a: 1)
        barItem.addSubview(label)
        barLabelArray.addObject(label)
        
        return barItem;
    }
    
    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        print("\(item)\n");
    }
    
    
    func barItemClick(barItem:UIButton){
        self.selectedIndex = barItem.tag
        self.changeItemState(barItem.tag)
    }
    
    func changeItemState(index:Int){
        
        for (number,item) in barImageArray.enumerate()  {
            let itemImage :UIImageView = item as! UIImageView;
            if number == index{
                itemImage.highlighted = true
            }else{
                itemImage.highlighted = false
            }
        }
        
        for (number,item) in barLabelArray.enumerate()  {
            let itemLabel :UILabel = item as! UILabel;
            if number == index{
                itemLabel.highlighted = true
            }else{
                itemLabel.highlighted = false
            }
        }
    }

}