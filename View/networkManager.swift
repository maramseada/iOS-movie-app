//
//  networkManager.swift
//  project
//
//  Created by Maram Waleed on 18/08/2021.
//

import Foundation
import  Alamofire
class NetwtorkManager{
    
    static let shared = NetwtorkManager()
    private init(){}
    var manager = NetworkReachabilityManager(host: "https://api.themoviedb.org/3/discover/movie?api_key=fd954e63af4112fbcf10c1b2944a5cf2")
    var isReachable = false
    
    
    func startMonitoring(){
        
        self.manager?.startListening(onQueue: DispatchQueue.main, onUpdatePerforming: {
          (networkStatus) in
            if networkStatus == .reachable(.cellular) || networkStatus == .reachable(.ethernetOrWiFi){
                
                self.isReachable = true
                
                
            }else{
                self.isReachable = false
                
                
            }
            
            
            
            
        })
        
        
    }
    func isconnected()->Bool{
        
        return self.isReachable
        
        
    }
}





