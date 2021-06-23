//
//  AviatonMeteorologyAPITests.swift
//  AviatonMeteorologyAPITests
//
//  Created by Mehmet fatih DOĞAN on 18.06.2021.
//

import XCTest
@testable import AviatonMeteorologyAPI


class AviatonMeteorologyAPITests: XCTestCase {

    
    
    func testMetarParsing()throws {
        
        let bundle = Bundle(for: AviatonMeteorologyAPITests.self)
        guard let url = bundle.url(forResource: "metar", withExtension: "json") else {fatalError()}
        let decoder = Decoders.plainDateDecoder
        let data = try Data(contentsOf:url )
        let metar = try decoder.decode(Metar.self, from: data)
        XCTAssertEqual(metar.icao, "LTAT")
        XCTAssertEqual(metar.metarText, "LTAT 172220Z 29005KT 200V360 CAVOK 21/06 Q1016 NOSIG RMK RWY03 15004KT 050V200")
        XCTAssertEqual(metar.elevation.feet, 2789)
            }
    
    
     func testTAFParsing()throws {
         
         let bundle = Bundle(for: AviatonMeteorologyAPITests.self)
         guard let url = bundle.url(forResource: "taf", withExtension: "json") else {fatalError()}
         let decoder = Decoders.plainDateDecoder
         let data = try Data(contentsOf:url )
         let taf = try decoder.decode(TAF.self, from: data)
        
             }
    
    func testAirporParsing()throws {
        
        let bundle = Bundle(for: AviatonMeteorologyAPITests.self)
        guard let url = bundle.url(forResource: "airport", withExtension: "json") else {fatalError()}
        let decoder = Decoders.plainDateDecoder
        let data = try Data(contentsOf:url )
        let airport = try decoder.decode(Airport.self, from: data)

            }
    
    func testSunTimesParsing()throws {
        
        let bundle = Bundle(for: AviatonMeteorologyAPITests.self)
        guard let url = bundle.url(forResource: "sunTimes", withExtension: "json") else {fatalError()}
        let decoder = Decoders.plainDateDecoder
        let data = try Data(contentsOf:url )
        let sunTimes = try decoder.decode(SunTimes.self, from: data)
        
            }
    
    func testMetarResponses()throws{
        let bundle = Bundle(for: AviatonMeteorologyAPITests.self)
        guard let url = bundle.url(forResource: "metars", withExtension: "json") else {fatalError()}
        let decoder = Decoders.plainDateDecoder
        let data = try Data(contentsOf: url)
        let metars = try decoder.decode(AviationMetarResponses.self, from: data)

    }
    
        
}
