//
//  LABaseColletionView.swift
//  ChunBo
//
//  Created by hjjwinner on 15/7/2.
//  Copyright (c) 2015年
//

import Foundation
import UIKit

protocol LABaseColletionViewDelegate :NSObjectProtocol {
    
    func LAcollectionView(collectionView:UICollectionView , indexPath:NSIndexPath , data:NSDictionary) -> UICollectionViewCell
    
    func LAcollectionViewdidSelec(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath ,withData data: LACollectionViewCellModel) -> Void

    
}

class LABaseColletionView: UIView,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout ,UICollectionViewDataSource{
    
    var collectionItemDict:NSMutableDictionary = [:]{
        
        /**
        *  @author 黄俊杰, 15-07-09 16:07:56
        *
        *  @brief  set方法
        */
        didSet(newCellDict){
            
        }
        
        willSet(newCellDict){
            self.collectionItemDict = newCellDict
            self.colletionView.reloadData()

        }

    }
    
    var clickCompletion :((collectionView: UICollectionView, indexPath: NSIndexPath ,model : [NSObject: AnyObject]?) -> Void)?
    
    var colletionView :UICollectionView!
    
    var delegate: LABaseColletionViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layoutCollectionView()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "relodaData", name: LACollectionViewReload, object: nil)
    }

    deinit{
       NSNotificationCenter.defaultCenter().removeObserver(self, name: LACollectionViewReload, object: nil)
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func layoutCollectionView(){
        let flowLayout : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        flowLayout.itemSize = CGSizeMake((ScreenWidth-7)/2, 210)
//        flowLayout.scrollDirection = UICollectionViewScrollDirection.Vertical//设置垂直显示
//        flowLayout.sectionInset = UIEdgeInsetsMake(0, 1, 0, 1)//设置边距
//        flowLayout.minimumLineSpacing = 0.0;//每个相邻layout的上下
//        flowLayout.minimumInteritemSpacing = 0.0;//每个相邻layout的左右
//        flowLayout.headerReferenceSize = CGSizeMake(0, 0);
        flowLayout.scrollDirection  = UICollectionViewScrollDirection.Vertical
        
        colletionView = UICollectionView(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight), collectionViewLayout: flowLayout)
        
        colletionView.multipleTouchEnabled = false
        colletionView.exclusiveTouch = true
        colletionView.delegate = self
        colletionView.dataSource = self
        colletionView.backgroundColor = UIColor.blueColor()

        self.addSubview(colletionView)
        
    }
  
    func relodaData(){
        colletionView.reloadData()
    }
    
    func LACollectionViewRegisterClass(cellClass:AnyClass , forCellWithReuseIdentifier identifier:String){
        
       colletionView.registerClass(cellClass, forCellWithReuseIdentifier: identifier)
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let number :String = "\(section)"
        
        let itemArray : NSArray = self.collectionItemDict.objectForKey(number) as! NSArray
        
        if itemArray.count > 0 {
            return itemArray.count
        }else{
            return 0
        }
        
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        let number : Int = self.collectionItemDict.count
        
        if number > 0{
            return number
        }else{
            return 0
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cellNerom = UICollectionViewCell()
        
        if (delegate != nil && delegate?.respondsToSelector("LAcollectionView") != nil){
          let cell =  delegate?.LAcollectionView(collectionView, indexPath: indexPath, data: self.collectionItemDict)
            return cell!
        }else{
            
        }
        return cellNerom
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
//            var model: AnyObject? = self.collectionItemDict.objectForKey("\(indexPath.section)")?.objectAtIndex(indexPath.row)
        let model : LACollectionViewCellModel = self.collectionItemDict.objectForKey("\(indexPath.section)")?.objectAtIndex(indexPath.row) as! LACollectionViewCellModel

            if self.delegate != nil && delegate?.respondsToSelector("LAcollectionViewdidSelec") != nil {
                delegate?.LAcollectionViewdidSelec(collectionView, didSelectItemAtIndexPath: indexPath, withData: model )
            }
        
    }
    
    

    //MARK:--UICollectionViewDelegateFlowLayout
    //MARK:实现model内的参数
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        let model:LACollectionViewCellModel = self.collectionItemDict.objectForKey("\(section)")?.firstObject as! LACollectionViewCellModel
        
        if (model.cellEdgeInstes != nil) {
            return model.cellEdgeInstes!
        }else{
            return UIEdgeInsetsMake(1, 1, 1, 1)
        }
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let model:LACollectionViewCellModel = self.collectionItemDict.objectForKey("\(indexPath.section)")?.objectAtIndex(indexPath.row) as! LACollectionViewCellModel

        if (model.cellSize != nil){
            return model.cellSize!
        }else{
            return CGSizeMake(100, 100)
        }
    }
    
    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    
    

 //MARK:暴露在外面的方法
    
    /**
    *  @author 黄俊杰, 15-07-10 18:07:46
    *
    *  @brief  暴露在外面的方法
    */
    func setCollectionViewBackgroundColor(color:UIColor){
        self.colletionView.backgroundColor = color
    }
}