import XCTest
@testable import AviationMeteorologyVIPER
@testable import AviatonMeteorologyAPI
@testable import Utility

class AviationMeteorologySunTimesPageTest: XCTestCase {
    

    //SunTimesPages' Properties
    private var mockSunTimesService = MockSunTimesService()
    private var mockSunTimesView = MockSunTimesView()
    private var sunTimesInteractor: SunTimesPageInteractor!
    private var sunTimesPresenter: SunTimesPagePresenter!

    override func setUp() {
 
        
        sunTimesInteractor = SunTimesPageInteractor(service: mockSunTimesService)
        sunTimesPresenter = SunTimesPagePresenter(interactor: sunTimesInteractor, view: mockSunTimesView)
        
        mockSunTimesView.presenter = sunTimesPresenter
        sunTimesInteractor.delegate = sunTimesPresenter
        
        
    }
    
  
    func testSunTimesPage()throws {
        //Given
        let suntimes = try ResourceLoader.loadSunTimes(resource: .sunTimes1)
        mockSunTimesService.sunTimes = [suntimes]
   
        //When
        mockSunTimesView.viewDidLoad()
        //Then
        let expectedSunTimes = SunTimesPresentation.init(sunTimes: suntimes)
        XCTAssertEqual(mockSunTimesView.outputs[0],.setSunTimes(true))
        XCTAssertEqual(mockSunTimesView.outputs[1],.setSunTimes(false))
        XCTAssertEqual(mockSunTimesView.outputs[2],.showSunTimes(expectedSunTimes))
    }
    
}


//SuntimesCase Tests
    
 
    
    
    
    final class MockSunTimesService:AviationSunTimesServiceProtocol{
        var sunTimes = [SunTimes]()
        
        func fetchSunTimes(icao: [String], completion: @escaping (Results<AviationSunTimesResponses>) -> Void) {
            completion(.success(.init(result: sunTimes)))
        }
    }
    
    final class MockSunTimesView:SunTimesPageViewProtocol{
        var presenter: SunTimesPagePresenter!
        
        var outputs: [SunTimesPagePresenterOutput] = []
        func handleOutput(_ output: SunTimesPagePresenterOutput) {
            outputs.append(output)
        }
        
        func viewDidLoad(){
            presenter.searchPressed(for: "LTAT")
        }
    }
    
    


