//
//  Array.swift
//  Utility
//
//  Created by Mehmet fatih DOĞAN on 23.06.2021.
//

import Foundation

extension Array{
   public struct IndexOutOfRange:Error { }
    func element(at index:Int)throws->Element{
        if index >= 0 && index < self.count{
            return self[index]
        }else{
            throw IndexOutOfRange()
        }
    }
}
