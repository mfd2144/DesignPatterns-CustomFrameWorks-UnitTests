//
//  AviationMeterologyRouteTest.swift
//  AviationMeteorologyVIPERTests
//
//  Created by Mehmet fatih DOĞAN on 22.06.2021.
//
import XCTest
@testable import AviationMeteorologyVIPER
@testable import AviatonMeteorologyAPI
@testable import Utility

class AviationMeteorologyRouteTest: XCTestCase {
    private var mockTafService: MockTafService!
    private var mockMetarService: MockMetarService!
    private var mockRouteView: MockRouteView!
    private var routeController: RoutePageViewController!
    
    override  func setUp() {
        mockTafService = MockTafService()
        mockMetarService = MockMetarService()
        mockRouteView = MockRouteView()
        routeController = RoutePageViewController()
        
        routeController.metarService = mockMetarService
        routeController.tafService = mockTafService
        routeController.routeView = mockRouteView
        mockRouteView.delegate = routeController

    }
    
    func testRoute()throws {
        //Given
        let taf1 = try ResourceLoader.loadSingleTaf(resource: .tafData1)//LTAT
        let taf2 = try ResourceLoader.loadSingleTaf(resource: .tafData2)//LTAC
        let taf3 = try ResourceLoader.loadSingleTaf(resource: .tafData3)//LTAB
        let tafs = [taf1,taf2,taf3]
        
        let metar1 = try ResourceLoader.loadSingleMetar(resource: .metarData1)//LTAT
        let metar2 = try ResourceLoader.loadSingleMetar(resource: .metarData2)//LTAC
        let metar3 = try ResourceLoader.loadSingleMetar(resource: .metarData3)//LTAO
        let metars = [metar1,metar2,metar3]
        
        mockMetarService.metars = metars
        mockTafService.tafs = tafs
        
        //when
        mockRouteView.delegate?.searchRoute(for: ["mock","entries"])
        
        //Then
        //Output will be sorted according to icao code
        
        XCTAssertEqual(mockRouteView.tafMetarModel.count, 4)
        XCTAssertNil(mockRouteView.tafMetarModel.element(at: 0).metar)//LTAB
        XCTAssertEqual(mockRouteView.tafMetarModel.element(at: 1).metar, "LTAC")
        XCTAssertEqual(mockRouteView.tafMetarModel.element(at: 1).taf, "LTAC")
        XCTAssertEqual(mockRouteView.tafMetarModel.element(at: 2).metar, "LTAT")
        XCTAssertEqual(mockRouteView.tafMetarModel.element(at: 2).taf, "LTAT")
        XCTAssertNil(mockRouteView.tafMetarModel.element(at: 3).taf)//LTAO
        
        
    }

}

final class MockRouteView:RouteViewProtocol{
    var delegate: RouteViewDelegate?
    var tafMetarModel: [TafMetarPresentation] = []
    var loadingArray:[Bool] = []
    
    func returnReports(tafMetars: [TafMetarPresentation]) {
        self.tafMetarModel = tafMetars
    }
    
    func setLoading(_ isLoading: Bool) {
        loadingArray.append(isLoading)
    }
    
    func routeError(_ error: Error) {
       
    }
    
}


