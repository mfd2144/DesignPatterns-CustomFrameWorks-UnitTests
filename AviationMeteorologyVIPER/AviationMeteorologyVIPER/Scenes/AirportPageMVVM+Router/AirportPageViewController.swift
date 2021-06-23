//
//  AirportPageViewController.swift
//  AviationMeteorologyVIPER
//
//  Created by Mehmet fatih DOĞAN on 21.06.2021.
//

import UIKit

final class AirportPageViewController:UIViewController{
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var searchButton:UIButton!
    @IBOutlet weak var distanceSlider:UISlider!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var distanceLabel:UILabel!
    
    private var airportPresentations: [AirportPresentation] = []
    var viewModel:AirportViewModel!{
        didSet{
            viewModel.delegate = self
        }
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
    }
    
    
    @IBAction func distanceSliderDidChange(_ sender: UISlider) {
        sender.value = Float(Int(sender.value / 10) * 10)
        distanceLabel.text = "Search Airports, Heliports etc. in \(String(format: "%.0f", sender.value)) miles"
    }
    
    @IBAction func searchButtonPressed(_ sender:UIButton){
        viewModel.searchAirports(distance: Int(distanceSlider.value))
      
    }
    
   
    
}

extension AirportPageViewController:AirportViewModelDelegate{
    func handleOutput(_ output: AirportViewModelOutputs) {
        switch output {
        case .airportsList(let airportPresentations):
            self.airportPresentations = airportPresentations
            tableView.reloadData()
        case .loadDidFail(.modelError(let error)):
            print(error)
            // todo
        case .setLoading(let isLoading):
            activityIndicator.isHidden = !isLoading
        case .title(let title):
            navigationController?.navigationBar.topItem?.title = title
        }
    }
    
    
}

extension AirportPageViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        airportPresentations.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell  = tableView.dequeueReusableCell(withIdentifier: "AirportCell",for:indexPath) as? AirportTableViewCell else {return UITableViewCell()}
        let airport = airportPresentations[indexPath.row]
        cell.airportPresentation = airport
        return cell
    }
}

extension AirportPageViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        todo
    }
}


