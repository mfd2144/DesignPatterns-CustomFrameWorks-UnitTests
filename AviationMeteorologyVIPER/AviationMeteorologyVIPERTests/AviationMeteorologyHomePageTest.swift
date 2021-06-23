//
//  AviationMeteorologyVIPERTests.swift
//  AviationMeteorologyVIPERTests
//
//  Created by Mehmet fatih DOĞAN on 18.06.2021.
//Warning Group

import XCTest
@testable import AviationMeteorologyVIPER
@testable import AviatonMeteorologyAPI
@testable import Utility

class AviationMeteorologyHomePageTest: XCTestCase {
    
    // HomePages' Properties
    private var mockMetarService: MockMetarService!
    private var mockTafService: MockTafService!
    private var mockHomePageRouter: MockHomeRouter!
    private var mockHomePageView: MockHomeViewController!
    private var homePageInteractor: HomePageInteractor!
    private var homePagePresenter: HomePagePresenter!


    override func setUp() {
        // HomePage SetUps
        mockMetarService = MockMetarService()
        mockTafService = MockTafService()
        mockHomePageView = MockHomeViewController()
        mockHomePageRouter = MockHomeRouter()
        homePageInteractor = HomePageInteractor(metarService: mockMetarService, tafService: mockTafService)
        homePagePresenter = HomePagePresenter(interactor: homePageInteractor, view: mockHomePageView, router: mockHomePageRouter)
        
        homePageInteractor.delegate = homePagePresenter
        mockHomePageView.presenter = homePagePresenter
        
 
    }
    
    func testHomePage() throws{
        //Given
        let metar = try ResourceLoader.loadSingleMetar(resource: .metarData1)
        let taf = try ResourceLoader.loadSingleTaf(resource: .tafData1)
        mockMetarService.metars = [metar]
        mockTafService.tafs = [taf]
        
        //When
        mockHomePageView.viewDidLoad()
        
        //Then
        XCTAssertEqual(mockHomePageView.outputs.count, 6)
        XCTAssertEqual(mockHomePageView.outputs[0], .setMetarLoading(true))
        XCTAssertEqual(mockHomePageView.outputs[1], .setTafLoading(true))
        XCTAssertEqual(mockHomePageView.outputs[2],.setMetarLoading(false))
        XCTAssertEqual(mockHomePageView.outputs[3], .showMetar(MetarPresentation.init(metar: metar)))
        XCTAssertEqual(mockHomePageView.outputs[4], .setTafLoading(false))
        XCTAssertEqual(mockHomePageView.outputs[5], .showTaf(TafPresentation.init(taf: taf)))
     
       
    }
    
    
}

final class MockMetarService: AviationMetarServiceProtocol{
    var metars = [Metar]()
    
    func fetchMetarReport(icao: [String], completion: @escaping (Results<AviationMetarResponses>) -> Void) {
        completion(.success(.init(results: metars)))
    }
}

final class MockTafService: AviationTafServiceProtocol{
    
    var tafs = [TAF]()
    
    func fetchTafReport(icao: [String], completion: @escaping (Results<AviationTafResponses>) -> Void) {
        completion(.success(.init(results: tafs)))
    }
}

final class MockHomeViewController:HomePageViewProtocol{
    var outputs = [HomePagePresenterOutput]()
    var presenter: HomePagePresenter!
  
    public func viewDidLoad() {
        presenter.searchPressed(for: ["LTAT"])
    }
    
    func handleOutput(_ output: HomePagePresenterOutput) {
        outputs.append(output)
    }
}

final class MockHomeRouter:HomePageRouterProtocol{
    func navigateToRoute(_ route: HomePageRouter) {
        
    }
    
    
}



