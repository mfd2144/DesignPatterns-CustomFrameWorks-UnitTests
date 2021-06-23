//
//  AviationMeteoerologyAirportTest.swift
//  AviationMeteorologyVIPERTests
//
//  Created by Mehmet fatih DOĞAN on 21.06.2021.
//
import XCTest
@testable import AviationMeteorologyVIPER
@testable import AviatonMeteorologyAPI
@testable import Utility

class AviationMeteorologyAirportPageTest: XCTestCase {
    private var viewModel:AirportViewModel!
    private var mockRouter: MockAirportRouter!
    private var mockViewController: MockAirportViewController!
    private var mockAirportService: MockAirportService!
    private var locationCore: MockCoreLocaltion!
    
    override  func setUp() {
        mockRouter = MockAirportRouter()
        mockViewController = MockAirportViewController()
        mockAirportService = MockAirportService()
        locationCore = MockCoreLocaltion()
//        viewModel = AirportViewModel(service: mockAirportService , router: mockRouter, locationCore: locationCore)
//        viewModel.delegate = mockViewController
//        mockViewController.viewModel = viewModel
    }
    
    func testAirport() throws{
        //Given
        let airport1 = try ResourceLoader.loadAirports(resource: .airport1)
        let airport2 = try ResourceLoader.loadAirports(resource: .airport2)
        let airport3 = try ResourceLoader.loadAirports(resource: .airport3)
        let airports = [airport1,airport2,airport3]
        mockAirportService.results = airports
 
        
         
    }
    
}

final class MockAirportService:AviationAirportServiceProtocol{
    var results:[Airport] =  []
    func fetchAirportInformation(icao: [String], coordinates: Coordinates, distance: Int, completion: @escaping (Results<AviationAirportResponses>) -> Void) {
        completion(.success(.init(results: results)))
    }
}

final class MockAirportRouter:AirportRouterProtocol{
    var outputs = [String]()
    func rootToAirportMetar(for icao: String) {
        outputs.append(icao)
    }
}

final class MockAirportViewController: AirportViewModelDelegate{
    var outputs:[AirportViewModelOutputs] = []
    var viewModel:AirportViewModel!
    
    func handleOutput(_ output: AirportViewModelOutputs) {
        outputs.append(output)
    }
    

    }
    
final class MockCoreLocaltion: CoreLocationUpdateProtocol{
    func handleOutputs(_ output: LocationManagerOutputs) {
        
    }
    
    
}
    
