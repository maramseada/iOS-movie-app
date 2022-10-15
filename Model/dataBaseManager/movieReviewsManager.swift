//
//  movieReviewsManager.swift
//  project
//
//  Created by Maram Waleed on 09/08/2021.
//

import Foundation
import Alamofire
class ApiServiceReviewsManager :ObservableObject{

    
    func fetchDataFromApiByAlamofire(id : Int?, completion :@escaping ([Reviews]?,String?)->Void){
          
            let url = URL(string:"https://api.themoviedb.org/3/movie/\(id ?? 0)/reviews?api_key=fd954e63af4112fbcf10c1b2944a5cf2")
      
        
            
          
            

                  var request = AF.request(url as! URLConvertible,method: .get,encoding: JSONEncoding.default)
                  
            
                  request.responseJSON { (dataResponse) in
                guard let data = dataResponse.data else {return}
                  
              do{
                  
              let decodedObj = try?JSONDecoder().decode(ReviewsResponse.self, from: data)
                completion(decodedObj?.results, nil)
             } catch {  print(error)
                  
                                  }
                  
                  
                  }
            
        }
                  
    }
