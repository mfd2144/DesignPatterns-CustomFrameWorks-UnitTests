//
//  TafMetar.swift
//  AviationMeteorologyVIPER
//
//  Created by Mehmet fatih DOĞAN on 22.06.2021.
//

import Foundation


final class TafMetarPresentation:NSObject{
    var taf:TafPresentation?
    var metar:MetarPresentation?
       
    init(taf:TafPresentation?,metar:MetarPresentation?) {
        self.metar = metar
        self.taf = taf
    }
    
    var counter:Int{
        get{
            if taf != nil &&  metar != nil{
                return 2
            }else if taf == nil && metar == nil{
                return 0
            }else {
                return 1
            }
        }
    }
}
