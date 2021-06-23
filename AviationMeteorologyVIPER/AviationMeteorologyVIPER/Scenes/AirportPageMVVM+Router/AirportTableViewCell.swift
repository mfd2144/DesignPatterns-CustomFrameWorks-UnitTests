//
//  AirportTableViewCell.swift
//  AviationMeteorologyVIPER
//
//  Created by Mehmet fatih DOĞAN on 21.06.2021.
//
//


import UIKit

class AirportTableViewCell: UITableViewCell {

    @IBOutlet private weak var circle: UIImageView!
    @IBOutlet private weak var arrow: UIImageView!
    @IBOutlet private weak var statusLabel: UILabel!
    @IBOutlet private weak var statusImage: UIImageView!
    @IBOutlet private weak var coordinatesLabel: UILabel!
    @IBOutlet private weak var distanceLabel: UILabel!
    @IBOutlet private weak var bearingLabel: UILabel!
    @IBOutlet private weak var cityCountryLabel: UILabel!
    @IBOutlet private weak var airportNameLabel: UILabel!
    @IBOutlet private weak var airportHeight: UILabel!
    @IBOutlet private weak var timeDifferenceLabel: UILabel!
    @IBOutlet private weak var icaoLabel: UILabel!
    @IBOutlet private weak var iataLabel: UILabel!
    var airportPresentation:AirportPresentation?{
        didSet{
            setCell()
        }
    }
 
    private func setCell(){
        guard let airport = airportPresentation else {return}
        statusLabel.text = airport.status
        distanceLabel.text = String(airport.miles)
        airportNameLabel.text = airport.name
        icaoLabel.text = airport.icao
        
        
    }
    
   
    func addImageView(angle: Int)->UIImageView{
        let frame = CGRect(x: 33, y: 71, width: 46, height: 72)
        let newArrow = UIImageView(frame: frame)
        newArrow.image = UIImage(systemName: "arrow.up")
        let rotationAngle : CGFloat = CGFloat(angle) * CGFloat.pi / 180.0
        newArrow.transform = newArrow.transform.rotated(by: rotationAngle)
        return newArrow
    }
}
