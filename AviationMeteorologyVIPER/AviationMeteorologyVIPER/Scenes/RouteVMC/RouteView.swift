//
//  RouteView.swift
//  AviationMeteorologyVIPER
//
//  Created by Mehmet fatih DOĞAN on 22.06.2021.
//

import UIKit


final class RouteView:UIView{
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var activityIndicator:UIActivityIndicatorView!{
        didSet{
            activityIndicator.isHidden = true
        }
    }
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        }
    }
    
    weak var delegate: RouteViewDelegate?
    var tafMetars = [TafMetarPresentation]()
    var shapeLayer: CAShapeLayer?
    let path = UIBezierPath()


    
    @IBAction func claearBtnPushed(_ sender: UIButton ){
        searchBar.isUserInteractionEnabled = true
        clearTextField()
        tafMetars = []
    }
    
}



extension RouteView:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        tafMetars.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tafMetars[section].counter
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let tafMetar = tafMetars[indexPath.section]
    
        switch indexPath.row {
        case 0:
            if let metar = tafMetar.metar {
                cell.textLabel?.text = metar.metarText
            }else if let taf = tafMetar.taf{
                cell.textLabel?.text = taf.tafText
                break
            }
       case 1:
            if let taf = tafMetar.taf  {
                cell.textLabel?.text = taf.tafText
            }
        default:
            fatalError()
        }
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tafMetars[section].taf?.icao ?? tafMetars[section].metar?.icao
    }
}


extension RouteView:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let selectedIcao = tafMetars[indexPath.section].metar?.icao else {return}
        delegate?.selectAnAirport(for: selectedIcao)
    }
}



extension RouteView:RouteViewProtocol{
    func returnReports(tafMetars: [TafMetarPresentation]) {
        self.tafMetars = tafMetars
        tableView.reloadData()
        
    }
    
    func routeError(_ error: Error) {
        //ToDO
    }
    
  
    
    func setLoading(_ isLoading: Bool) {
        activityIndicator.isHidden = !isLoading
    }

  
}

extension RouteView:UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        //        uppercase users input
        searchBar.text = searchBar.text?.uppercased()
        if (searchBar.text?.count == 4 || searchBar.text?.count == 9 || searchBar.text?.count == 14 || searchBar.text?.count == 19) {
            //            add dash between airports
            searchBar.text?.append("-")
            
        }
        if searchBar.text?.count == 24{
            //            it start when user enters 5 icao codes
            searchBar.endEditing(true)
            searchBar.isUserInteractionEnabled = false
            let icaoCodes = searchBar.text?.split(separator: "-").map({String($0)})
            drawLine(icao: icaoCodes!)
            searchBarSearchButtonClicked(searchBar)
        }
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text != ""{
        guard let icaoCodes = searchBar.text?.split(separator: "-").map({String($0)}) else { return }
        searchBar.endEditing(true)
            drawLine(icao: icaoCodes)
        }else{
//            aviationAppData.userAlert(sender: self, message: "Please Enter ICAO Codes ")
        }
        
    }
    
    
    func clearTextField(){
        while topView.viewWithTag(101) != nil{
            let textfield = topView.viewWithTag(101)
            textfield!.removeFromSuperview()
        }
        searchBar.text = nil
        self.shapeLayer?.removeFromSuperlayer()
    }
    
}


extension RouteView{
    
    
    func drawLine(icao: [String] ) {
        
        //         remove old shape layer if any
        self.shapeLayer?.removeFromSuperlayer()
        
        // create whatever path you want
        
        let xPoint = topView.frame.size.width
        let yPoint = topView.frame.size.height
        
        addLabel(name: icao[0],xPoint: xPoint/6-50, yPoint: yPoint/3*2)
        let count = icao.count
        
        if count > 1{
            path.move(to: CGPoint(x: xPoint/6, y: yPoint/3*2))
            path.addLine(to: CGPoint(x: xPoint/6*2, y: yPoint/3))
            addLabel(name: icao[1],xPoint: xPoint/6*2-50, yPoint: yPoint/3-20)
        }
        if count > 2{
            path.move(to: CGPoint(x: xPoint/6*2, y: yPoint/3))
            path.addLine(to: CGPoint(x: xPoint/6*3, y: yPoint/3 ))
            addLabel(name: icao[2],xPoint: xPoint/6*3-25, yPoint: yPoint/3)
        }
        if count > 3{
            path.move(to: CGPoint(x: xPoint/6*3, y: yPoint/3 ))
            path.addLine(to: CGPoint(x: xPoint/6*4, y: yPoint/3 ))
            addLabel(name: icao[3],xPoint: xPoint/6*4, yPoint: yPoint/3-20)
        }
        if count > 4{
            path.move(to: CGPoint(x: xPoint/6*4, y: yPoint/3 ))
            path.addLine(to: CGPoint(x: xPoint/6*5, y: yPoint/3*2))
            addLabel(name: icao[4],xPoint: xPoint/6*5, yPoint: yPoint/3*2)
        }
        //         create shape layer for that path
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        shapeLayer.strokeColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).cgColor
        shapeLayer.lineWidth = 4
        shapeLayer.path = path.cgPath
        
//        // request data
        delegate?.searchRoute(for: icao)
        
        // animate it
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.duration = 2
        shapeLayer.add(animation, forKey: "MyAnimation")
        self.shapeLayer = shapeLayer
        topView.layer.addSublayer(shapeLayer)
    }
    func addLabel(name: String,xPoint: CGFloat, yPoint: CGFloat){
        
        let textLabel = UILabel(frame: CGRect(x:  xPoint, y: yPoint, width: 50, height: 20))
        textLabel.text = name
        textLabel.tag = 101
        textLabel.font = UIFont(name: "System", size: CGFloat(7))
        topView.addSubview(textLabel)
        
    }
}









