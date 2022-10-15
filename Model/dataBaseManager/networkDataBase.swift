//
//  networkDataBase.swift
//  project
//
//  Created by Maram Waleed on 07/08/2021.
//

import Foundation
import Alamofire

class ApiServiceManager{
                
        func fetchDataFromApiByAlamofire(completion :@escaping ([Result]?,String?)->Void){
       
           let url = URL(string:"https://api.themoviedb.org/3/discover/movie?api_key=fd954e63af4112fbcf10c1b2944a5cf2")
      
        
            
          
            

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
