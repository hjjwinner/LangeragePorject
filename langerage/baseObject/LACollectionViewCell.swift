//
//  LACollectionViewCell.swift
//  langerage
//
//  Created by autonavi on 16/2/7.
//  Copyright © 2016年 langerage. All rights reserved.
//

import Foundation
import UIKit
import SnapKit


class LACollectionViewCell: UICollectionViewCell {
    
}
/**
 *  @author 黄俊杰, 15-07-11 01:07:50
 *
 *  @brief  单品页Cell
 */
class categoryCollectionViewCell: LACollectionViewCell {
    
    var imageView:UIImageView?
    var titleLabel:UILabel?


    
    
    var cellData:categoryCellModel?{
        willSet(newCellData){
            self.cellData = newCellData
            self.layoutIfNeeded()
            self.layoutSubviews()
        }
        
        
    }
    
    let margin = 12
    
    let speasd = 7
    
    convenience  required  init(coder aDecoder: NSCoder) {
        
        self.init(frame:CGRectMake(0, 0, 0 , 0))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRectMake(0, 0, 145*percent, 190*percent)
        self.backgroundColor = UIColor.whiteColor()
        self.creatTheUI()
        
    }
    
    
    func creatTheUI(){
        

        self.imageView = UIImageView(frame: CGRectMake(0, 0, 145*percent, 106*percent))
        self.addSubview(self.imageView!)
        
        self.titleLabel = UILabel()
        self.addSubview(titleLabel!)
        
       
    }
    
    override func layoutSubviews() {
        
        self.layer.borderWidth = 0.5
        self.layer.borderColor = RGBA(235, g: 238, b: 242, a: 1).CGColor
        
        imageView?.backgroundColor = UIColor.grayColor()
        self.imageView!.snp_makeConstraints{ (make) -> Void in
            make.width.equalTo(145*percent)
            make.height.equalTo(106*percent)
            
        }
        
 
        
        self.titleLabel?.snp_makeConstraints{ (make) -> Void in
            make.width.equalTo(self.frame.size.width - 24)
            make.height.equalTo(15)
            make.top.equalTo(self.imageView!.snp_bottom).offset(speasd)
            make.left.equalTo(margin)
            
        }
        self.titleLabel?.font = UIFont.systemFontOfSize(12)
        self.titleLabel?.text = cellData?.name
        
    }
    
    
}















