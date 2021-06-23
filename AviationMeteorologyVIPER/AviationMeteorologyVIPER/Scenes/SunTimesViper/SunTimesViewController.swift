//
//  SunTimesViewController.swift
//  AviationMeteorologyVIPER
//
//  Created by Mehmet fatih DOĞAN on 20.06.2021.
//

import UIKit

final class SuntimesViewController:UIViewController{
    
    
    var presenter:SunTimesPagePresenterProtocol!
    var sunTimesPresentation:SunTimesPresentation?
    
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var zoneSegment: UISegmentedControl!
    @IBOutlet weak var dawnLabel: UILabel!
    @IBOutlet weak var sunRiseLabel: UILabel!
    @IBOutlet weak var sunSetLabel: UILabel!
    @IBOutlet weak var duskLabel: UILabel!
    @IBOutlet weak var activityIndicator :UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
        navigationController?.navigationBar.topItem?.title = "SunTimes"
    }
    
    @IBAction func searchBtnPressed(_ sender: UIButton) {
        let icaoCode = searchField.text!
            presenter.searchPressed(for: icaoCode)
            searchField.endEditing(true)
            searchField.text = ""
    
    }
    
    
    @IBAction func zoneSegmentChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            guard let selectedTimes = sunTimesPresentation?.local else {return}
            setSelectedTimes(selectedTimes)
        }else{
            guard let selectedTimes = sunTimesPresentation?.utc else {return}
            setSelectedTimes(selectedTimes)
        }

    }
    
}



extension SuntimesViewController{
    func setSelectedTimes(_ selectedTimes: SunTimesPresentation.Times){
        dawnLabel.text = selectedTimes.dawn
        duskLabel.text = selectedTimes.dusk
        sunSetLabel.text = selectedTimes.sunset
        sunRiseLabel.text = selectedTimes.sunrise
    }

    
}

extension SuntimesViewController:SunTimesPageViewProtocol{
    func handleOutput(_ output: SunTimesPagePresenterOutput) {
        switch output {
        case .setSunTimes(let isLoading) :
            activityIndicator.isHidden = !isLoading
        case .sunTimesErrorContainer(.modelError(let error)):
            print(error)
        case .showSunTimes(let sunTimesPresentation):
            self.sunTimesPresentation = sunTimesPresentation
            zoneSegmentChanged(zoneSegment)
            navigationController?.navigationBar.topItem?.title = "\(sunTimesPresentation.icao)/\(sunTimesPresentation.name)"
        }
        
    }
    
    
}
