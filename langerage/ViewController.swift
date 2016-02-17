//
//  ViewController.swift
//  langerage
//
//  Created by autonavi on 16/2/6.
//  Copyright © 2016年 langerage. All rights reserved.
//

import UIKit
import ObjectMapper


class ViewController: UIViewController {
    
    var collection :LABaseColletionView = LABaseColletionView(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight))

    var categoryList:NSArray = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.loadData()
        
        self.creatUI()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func loadData(){
        
        let  homeData : NSMutableDictionary = [:]
        
        let db = LASQLite.sharedInstance
        categoryList =  db.categoryListWithLanguageNumber(8)
        
        let categoryArray :NSMutableArray = []

        
        for (_, item) in categoryList.enumerate(){
            
            let categoryModel : categoryCellModel = Mapper<categoryCellModel>().map(item)!
            
            categoryModel.cellIdentifier = "categoryCollectionViewCell"
            categoryModel.cellEdgeInstes = UIEdgeInsetsMake(0, 0, 0, 0)
            categoryModel.cellSize = CGSizeMake(ScreenWidth-20, 50)
            
            categoryArray.addObject(categoryModel)


        }
        
        homeData.setObject(categoryArray, forKey: "\(0)")

        collection.collectionItemDict = homeData;
        
    }
    
    func creatUI(){
        collection.delegate = self;
        self.view.addSubview(collection)

        collection.LACollectionViewRegisterClass(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "ViewCell")
        collection.LACollectionViewRegisterClass(categoryCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "categoryCollectionViewCell")

        
    }

    
//    var delegate:LABaseColletionViewDelegate?

    
    
    
  
    
    
}

extension ViewController:LABaseColletionViewDelegate{
    
    func LAcollectionView(collectionView: UICollectionView, indexPath: NSIndexPath, data: NSDictionary) -> UICollectionViewCell {
        
        let model : LACollectionViewCellModel = data.objectForKey("\(indexPath.section)")?.objectAtIndex(indexPath.row) as! LACollectionViewCellModel
        
        let identifier :NSString = model.cellIdentifier!
        
        if identifier.isEqualToString("categoryCollectionViewCell"){
            
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier as String, forIndexPath: indexPath) as!  categoryCollectionViewCell
            cell.cellData = model as? categoryCellModel
            
            return cell
            
        }else{
            let identify:String = "ViewCell"
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(
                identify, forIndexPath: indexPath)
            
            cell.backgroundColor = UIColor.yellowColor()
            return cell
        }
        
        
        
        
        
    }
    
    func LAcollectionViewdidSelec(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath ,withData data: LACollectionViewCellModel) -> Void
    {
        let detaliView:detaliViewColntroller = detaliViewColntroller()
        
        self.navigationController?.pushViewController(detaliView, animated: false)
    }
}

