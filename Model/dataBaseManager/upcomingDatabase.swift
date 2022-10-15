//
//  upcomingDatabase.swift
//  project
//
//  Created by Maram Waleed on 22/08/2021.
//

import Foundation
import Alamofire

class ApiUpComingServiceManager{
                
        func fetchDataFromApiByAlamofire(completion :@escaping ([Result]?,String?)->Void){
       
           let url = URL(string:"https://api.themoviedb.org/3/movie/upcoming?api_key=fd954e63af4112fbcf10c1b2944a5cf2&language=en-US&page=1")
      
        
            
          
            

                  var request = AF.request(url as! URLConvertible,method: .get,encoding: JSONEncoding.default)
                  
            
                  request.responseJSON { (dataResponse) in
                guard let data = dataResponse.data else {return}
                  
              do{
                  
              let decodedObj = try?JSONDecoder().decode(Movies.self, from: data)

                completion(decodedObj?.results , nil)
           
              }
              catch {  print(error)
                  
                                  }
                  
                  
                  }
            
        }
}
           
