//
//  ActivityView.swift
//  AviationMeteorologyVIPER
//
//  Created by Mehmet fatih DOĞAN on 21.06.2021.
//

import class UIKit.UIActivityIndicatorView


extension UIActivityIndicatorView{
    open override var isHidden: Bool{
        didSet{
           
                    self.isHidden ? self.stopAnimating():self.startAnimating()
               
        }
    }
}



