//
//  RecipePuppyService.swift
//  Food Recognizer+
//
//  Created by Денис Жукоборский on 09.03.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import Foundation
import Alamofire
class RecipePuppyService {
    
    private var manager: Session = Alamofire.Session.default
    
    public func getRecipesWithIngridientNames(names: [String], completion: @escaping (((HTTPURLResponse?, [Recipe]?, Error?)) -> ()))  {
        let stringToAppendToRequestAddress = names.joined(separator: ",")
        let initialAdress = "http://www.recipepuppy.com/api/?i="
        
        guard let urlAddress = URL(string: initialAdress + stringToAppendToRequestAddress) else { return }
        
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        config.httpCookieStorage = nil
        config.timeoutIntervalForResource = TimeInterval(10)
        
        manager = Session(configuration: config)
        
        _ = manager.request(urlAddress,
                            method: HTTPMethod.get).responseJSON { (response) in
                                if let error = response.error {
                                    main { completion((response.response, nil, error))}
                                } else if let processedData = (response.data as Any) as? RecipePuppyRequestResponse {
                                    main { completion((response.response, processedData.recipes, nil))}
                                }
                                
        }
    }
}
