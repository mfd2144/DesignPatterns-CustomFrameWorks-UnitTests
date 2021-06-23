//
//  DecodedPageView.swift
//  AviationMeteorologyVIPER
//
//  Created by Mehmet fatih DOĞAN on 23.06.2021.
//

import UIKit


final class DecodedPageView:UIViewController{
    
    var presenter:DecodedPagePresenterProtocol!
    @IBOutlet weak var airportName: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var coordinatesLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var windlabel: UILabel!
    @IBOutlet weak var barometerLabel: UILabel!
    @IBOutlet weak var thermometerLabel: UILabel!
    @IBOutlet weak var elevationLabel: UILabel!
    @IBOutlet weak var cloudLabel: UILabel!
    @IBOutlet weak var dewPointLabel: UILabel!
    @IBOutlet weak var flightRulesLabel: UILabel!
    @IBOutlet weak var visibilitLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.load()
    }
}

extension DecodedPageView:DecodedPageViewProtocol{
    func update(_ metar: MetarPresentation) {
        print("here")
        navigationController?.navigationBar.topItem?.backButtonTitle = metar.icao
        airportName.text = metar.name
        timeLabel.text = metar.time.convertToString()
        conditionLabel.text = metar.condition
        coordinatesLabel.text = "lon:\(metar.longitude) lat:\(metar.latitude)"
        windlabel.text = "\(metar.windDirection)˚/\(metar.windSpeed) kts"
        barometerLabel.text = " \(metar.barometerHg) hg"
        thermometerLabel.text = " \(metar.thermometer) C˚"
        dewPointLabel.text = " \(metar.dewPoint) C˚"
        elevationLabel.text = "\(metar.elevation) feet "
        cloudLabel.text = metar.cloud ?? "-"
        flightRulesLabel.text = metar.flightCategory
        visibilitLabel.text = metar.visibility
        
    }
    
    
}
