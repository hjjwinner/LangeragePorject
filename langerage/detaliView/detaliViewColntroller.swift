//
//  detaliViewColntroller.swift
//  langerage
//
//  Created by autonavi on 16/2/7.
//  Copyright © 2016年 langerage. All rights reserved.
//

import Foundation
import AVFoundation
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
    
    var audioPlayer = AVAudioPlayer()
    
    let db = LASQLite.sharedInstance
    
    let letfButton: UIButton = UIButton()

    let ringhtButton: UIButton = UIButton()

    
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
        
        letfButton.setImage(UIImage(named: "ic_like"), forState: UIControlState.Normal)
        letfButton.addTarget(self, action: "playActionClick", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(letfButton)
        
        letfButton.snp_makeConstraints { (make) -> Void in
            
            make.width.height.equalTo(100)
            make.top.equalTo(350)
            make.bottom.equalTo(150)

        }
        
        ringhtButton.setImage(UIImage(named: "ic_skip"), forState: UIControlState.Normal)
        ringhtButton.addTarget(self, action: "nextActionClick", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(ringhtButton)
        
        ringhtButton.snp_makeConstraints { (make) -> Void in
            
            make.width.height.equalTo(100)
            make.right.lessThanOrEqualTo(self.view)
            make.top.equalTo(350)
            make.bottom.equalTo(150)
            
        }

    }
    
    func playActionClick(){
        
        detaliView?.swipe(SwipeResultDirection.Left)

    }
    
    func nextActionClick(){
        
        detaliView?.swipe(SwipeResultDirection.Right)
        
    }
    
    
    func loadData(){
        detaliList =  db.getDetaliList(1, languageID: 8,toLanguageID: 3)
        
    }
    
}

//MARK: KolodaViewDelegate

extension detaliViewColntroller:KolodaViewDelegate{
    func koloda(kolodaDidRunOutOfCards koloda: KolodaView) {
        //Example: reloading
        detaliView.resetCurrentCardNumber()
    }
    
    func koloda(koloda: KolodaView, didSelectCardAtIndex index: UInt) {
        
        let languageModel : LAModel = detaliList.objectAtIndex(Int(index)) as! LAModel
        
        let soundData  =  db.soundWintLanguage(languageModel.toLanguageID!, phraseID:languageModel.phraseID! )
        
        do {
            
            audioPlayer = try AVAudioPlayer(data: soundData)
            
        } catch _ as NSError {
            
        }
        audioPlayer.prepareToPlay()
        audioPlayer.play()
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
        
        let labelLanguage1 : UILabel = UILabel()
        
        
        if self.detaliList.count > 0 {
            
            let detaliModel :LAModel = self.detaliList.objectAtIndex(Int(index)) as! LAModel
            
            labelLanguage1.text = detaliModel.phrase
            
            print(labelLanguage1.text)
        }
                
        labelLanguage1.backgroundColor = UIColor.greenColor()
        
        ///<tolanguage
        let labelLanguage2 : UILabel = UILabel()
        
        
        if self.detaliList.count > 0 {
            
            let detaliModel :LAModel = self.detaliList.objectAtIndex(Int(index)) as! LAModel
            
            labelLanguage2.text = detaliModel.toPhrase
            
            print(labelLanguage2.text)
        }
        

        
        labelLanguage2.backgroundColor = UIColor.brownColor()
        
        let imageString = db.getLanguageCode(8)
        
        let colours:UIImageView = UIImageView(image: UIImage(named: imageString))
        
        
//        let KolodaView :detaliKolodaView = detaliKolodaView(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight))
//        KolodaView.backImageView = UIImageView(image: UIImage(named: "cards_\((index + 1)%5)"))
//        KolodaView.backImageView.image =  UIImage(named: "cards_\((index + 1)%5)")
        let image : UIImageView = UIImageView(image: UIImage(named: "cards_\((index + 1)%5)"))
        
//        KolodaView.addSubview(UIImageView(image: UIImage(named: "cards_\((index + 1)%5)")))
        
        image.addSubview(labelLanguage1)
        image.addSubview(labelLanguage2)
        image.addSubview(colours)
        
        labelLanguage1.snp_makeConstraints { (make) -> Void in
            make.left.top.equalTo(20)
            make.right.equalTo(-20)
        }

        labelLanguage2.snp_makeConstraints { (make) -> Void in
            make.size.equalTo(labelLanguage1)
            make.left.equalTo(20)
            make.top.equalTo(labelLanguage1.snp_bottom).offset(20)
            
        }
        
        colours.snp_makeConstraints { (make) -> Void in
            make.size.equalTo((colours.image?.size)!)
            make.top.equalTo(100)
            make.left.equalTo(20)
        }
        
        return image
    }
    
    func koloda(koloda: KolodaView, viewForCardOverlayAtIndex index: UInt) -> OverlayView? {
        
        let overlay:CustomOverlayView = CustomOverlayView()
        overlay.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight)
        return overlay
    }
}