//
//  detaliViewColntroller.swift
//  langerage
//
//  Created by autonavi on 16/2/7.
//  Copyright © 2016年 langerage. All rights reserved.
//

import Foundation
import UIKit
import pop

private var numberOfCards: UInt = 0
private let frameAnimationSpringBounciness:CGFloat = 9
private let frameAnimationSpringSpeed:CGFloat = 16
private let kolodaCountOfVisibleCards = 2
private let kolodaAlphaValueSemiTransparent:CGFloat = 0.1


class detaliViewColntroller: UIViewController {
    
    var detaliView: CustomKolodaView! = CustomKolodaView()
    
    var detaliList:NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadData()
        numberOfCards = UInt(detaliList.count)
        
        detaliView.frame = CGRectMake(0, ScreenTabelBarHeight, ScreenWidth, ScreenHeight)
        detaliView.alphaValueSemiTransparent = kolodaAlphaValueSemiTransparent
        detaliView.countOfVisibleCards = kolodaCountOfVisibleCards
        detaliView.delegate = self
        detaliView.dataSource = self
        self.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
        
        self.view.addSubview(detaliView)
        detaliView.backgroundColor = UIColor.yellowColor()


        }
    
    
    
    func loadData(){
        let db = LASQLite.sharedInstance
        detaliList =  db.getDetaliList(1, languageID: 8)
        
    }
    
}

//MARK: KolodaViewDelegate

extension detaliViewColntroller:KolodaViewDelegate{
    func koloda(kolodaDidRunOutOfCards koloda: KolodaView) {
        //Example: reloading
        detaliView.resetCurrentCardNumber()
    }
    
    func koloda(koloda: KolodaView, didSelectCardAtIndex index: UInt) {
//        UIApplication.sharedApplication().openURL(NSURL(string: "http://yalantis.com/")!)
    }
    
    func koloda(kolodaShouldApplyAppearAnimation koloda: KolodaView) -> Bool {
        return true
    }
    
    func koloda(kolodaShouldMoveBackgroundCard koloda: KolodaView) -> Bool {
        return false
    }
    
    func koloda(kolodaShouldTransparentizeNextCard koloda: KolodaView) -> Bool {
        return true
    }
    
    func koloda(kolodaBackgroundCardAnimation koloda: KolodaView) -> POPPropertyAnimation? {
        let animation = POPSpringAnimation(propertyNamed: kPOPViewFrame)
        animation.springBounciness = frameAnimationSpringBounciness
        animation.springSpeed = frameAnimationSpringSpeed
        return animation
    }

}


//MARK: KolodaViewDataSource

extension detaliViewColntroller:KolodaViewDataSource{
    func koloda(kolodaNumberOfCards koloda:KolodaView) -> UInt {
        return numberOfCards
    }
    
    func koloda(koloda: KolodaView, viewForCardAtIndex index: UInt) -> UIView {
        
        let label : UILabel = UILabel()
        
        label.frame = CGRectMake(0, 0, 300, 100)
        
        if self.detaliList.count > 0 {
            
            let detaliModel :LAModel = self.detaliList.objectAtIndex(Int(index)) as! LAModel
            
            label.text = detaliModel.phrase
            print(label.text)
        }
                
        label.backgroundColor = UIColor.greenColor()
        
        let image : UIImageView = UIImageView(image: UIImage(named: "cards_\((index + 1)%5)"))
        
        image.addSubview(label)
        
        return image
    }
    
    func koloda(koloda: KolodaView, viewForCardOverlayAtIndex index: UInt) -> OverlayView? {
        
        let overlay:CustomOverlayView = CustomOverlayView()
        overlay.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight)
        return overlay
    }
}