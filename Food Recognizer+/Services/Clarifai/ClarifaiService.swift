//
//  ClarifaiService.swift
//  Food Recognizer+
//
//  Created by Денис Жукоборский on 09.03.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import Clarifai

class ClarifaiService {
    var app: ClarifaiApp
    
    init(apiKey: String) {
        self.app = ClarifaiApp(apiKey: apiKey)
    }
    
    
    func getFoodPredictions(from image: UIImage, completion: @escaping ((([ClarifaiFoodPrediction]?, Error?)) -> ())) {
        let image: ClarifaiImage = ClarifaiImage(image: image)
        let queue = DispatchQueue(label: "clarifai")
        
        queue.async {
            self.app.getModelByName("food-items-v1.0") { (model, error) in
                if let error = error {
                    main { completion((nil, error)) }
                } else if let model = model {
                    model.predict(on: [image]) { (output, error) in
                        if let error = error {
                            main { completion((nil, error)) }
                        } else if let output = output {
                            var arrayOfPredictions = [ClarifaiFoodPrediction]()
                            for concept in output[0].concepts {
                                arrayOfPredictions.append(ClarifaiFoodPrediction(name: concept.conceptName , score: concept.score))
                            }
                            
                            main { completion((arrayOfPredictions, nil))}
                        } else {
                            main { completion ((nil, ErrorsFactory.unknownError()))}
                        }
                    }
                } else {
                    main { completion ((nil, ErrorsFactory.unknownError()))}
                }
            }
        }
    }
}
