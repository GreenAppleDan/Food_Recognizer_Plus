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
        let stringToAppendToRequestAddress = names.map{$0.replacingOccurrences(of: " ", with: "%20")}.joined(separator: ",")
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
                                    completion((response.response, nil, error))
                                    
                                } else if let data = response.data {
                                    do {
                                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any], let rawRecipes = json["results"] as? [[String : Any]]  {
                                            var recipes = [Recipe]()
                                            for rawRecipe in rawRecipes {
                                                guard let recipe = Recipe.deserialize(from: rawRecipe) else { continue }
                                                recipes.append(recipe)
                                            }
                                            completion((response.response, recipes, nil))
                                        }
                                    } catch {
                                        completion((nil, nil, ErrorsFactory.unknownError()))
                                    }
                                } else {
                                    completion((nil, nil, ErrorsFactory.unknownError()))
                                }
        }
    }
}
