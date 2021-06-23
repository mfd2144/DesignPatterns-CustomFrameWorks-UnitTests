import Foundation


//Interactor

protocol DecodedPagePresenterProtocol:AnyObject{
    var delegate:DecodedPageViewProtocol? {get set}
    func load()
    
}



//View

protocol DecodedPageViewProtocol:AnyObject{
    func update(_ metar:MetarPresentation)
    
}

