//
//  Constant.swift
//  langerage
//
//  Created by autonavi on 16/2/6.
//  Copyright © 2016年 langerage. All rights reserved.
//

import Foundation
import UIKit

let ScreenWidth = UIScreen.mainScreen().bounds.size.width
/// 高
let ScreenHeight  = UIScreen.mainScreen().bounds.size.height
/// iphone适配比例
let percent = UIScreen.mainScreen().bounds.size.width / 320;

/**
 RGB颜色
 
 :param: r <#r description#>
 :param: g <#g description#>
 :param: b <#b description#>
 :param: a <#a description#>
 
 :returns: <#return value description#>
 */
func RGBA (r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) ->UIColor {
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}

/**
*  @author 黄俊杰, 15-07-12 00:07:14
*
*  @brief  宏定义Key
*/

let sessionID = "session_id"

let LACollectionViewReload = "LACollectionViewReloadData"
