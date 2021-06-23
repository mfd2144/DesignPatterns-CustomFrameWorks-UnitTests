//
//  HomePageViewController.swift
//  AviationMeteorologyVIPER
//
//  Created by Mehmet fatih DOĞAN on 18.06.2021.
//

import UIKit


final class HomePageView:UIViewController{
    
    var presenter:HomePagePresenterProtocol!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tafDecodedLabel: UILabel!
    @IBOutlet weak var metarDecodedLabel: UILabel!
    @IBOutlet weak var metarActivity: UIActivityIndicatorView!
    @IBOutlet weak var tafActivity: UIActivityIndicatorView!
    
    @IBOutlet weak var decodeButton:UIButton!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        decodeButton.isHidden = true
        metarActivity.isHidden = true
        tafActivity.isHidden = true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
     
    }
    
    func searchDidStart(icao:String){
        presenter.searchPressed(for: [icao])
    }
    
    @IBAction func deodedButtonPressed(_ sender:UIButton){
        presenter.metarDecodedPressed()
    }
    
}

extension HomePageView:HomePageViewProtocol{
    func handleOutput(_ output: HomePagePresenterOutput) {
        switch output {
        case .showTaf(let tafPresentation):
            tafDecodedLabel.text = tafPresentation.tafText
        case .showMetar(let metarPresentation):
            metarDecodedLabel.text = metarPresentation.metarText
            decodeButton.isHidden = false
        case .errorContainer(let error):
            print(error)
        case .setMetarLoading(let isloading):
            metarActivity.isHidden = !isloading
        case .setTafLoading(let isloading):
            tafActivity.isHidden = !isloading
        }
    }
}

extension HomePageView:UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            let icaoCode = searchBar.text!
            if icaoCode.count != 4 {
                userAlert(message: "You must enter 4 characters in search field")
                searchBar.text = ""
                return
            }
    //        Clear reports which belongs before search
            tafDecodedLabel.text = ""
            metarDecodedLabel.text = ""
            decodeButton.isHidden = true
    //        Data request
        searchDidStart(icao: icaoCode)
            searchBar.endEditing(true)
            searchBar.text = ""
        
    }
    
    func userAlert(message: String){
        let alert = UIAlertController(title: "", message: message , preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel){_ in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}

