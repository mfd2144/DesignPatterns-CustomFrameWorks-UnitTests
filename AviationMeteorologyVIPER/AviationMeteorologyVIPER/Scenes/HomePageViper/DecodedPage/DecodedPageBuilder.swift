//
//  decodedPageBuilder.swift
//  AviationMeteorologyVIPER
//
//  Created by Mehmet fatih DOĞAN on 23.06.2021.
//

import UIKit
import struct AviatonMeteorologyAPI.Metar

final class DecodedPageBuilder{
    static func make(with metar:Metar)->UIViewController{
        let storybord = UIStoryboard.init(name: "DecodedPage", bundle: nil)
        guard let view = storybord.instantiateViewController(withIdentifier: "DecodedPageViewController") as? DecodedPageView else {fatalError()}
        let presenter = DecodePagePresenter(metar: metar)
        presenter.delegate = view
        view.presenter = presenter
        return view
    }
}
