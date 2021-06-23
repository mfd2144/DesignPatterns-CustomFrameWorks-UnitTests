//
//  UtilityTests.swift
//  UtilityTests
//
//  Created by Mehmet fatih DOĞAN on 21.06.2021.
//

import XCTest
@testable import Utility

class UtilityTests: XCTestCase {
    private var coreLocater:CoreLocationHelper!
    private var caller:Caller!
    
    override  func setUp() {
        coreLocater = CoreLocationHelper()
        caller = Caller(core: coreLocater)
    }
    
    final func testCore()throws{
        caller.callLocation()
        
        
//TODO
        
    }
    
    
    final class Caller:CoreLocationUpdateProtocol{
        var outputs: [LocationManagerOutputs] = []
        func handleOutputs(_ output: LocationManagerOutputs) {
            outputs.append(output)
        }
        
        let core:CoreLocationHelper!
        
        init(core:CoreLocationHelper){
            self.core = core
            core.delegate = self
        }
        
        func callLocation(){
            core.requestActualPoint()
        }
        
    }
    
}

