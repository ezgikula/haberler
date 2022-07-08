//
//  WebService.swift
//  HaberlerProjesi
//
//  Created by Ezgi  on 18.05.2022.
//

import Foundation

class WebService {
    
    func haberleriIndir(url : URL, completion: @escaping  ( [News]?) -> () ) {
        
        
        // eğer asenkron bir işlem yapıyorsak @escaping closure işimize yarar.
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                
                print(error.localizedDescription)
                completion(nil)
                
            }else if let data = data {
                
                let haberlerDizisi =  try? JSONDecoder().decode([News].self, from: data)
                
                if let haberlerDizisi = haberlerDizisi {
                    completion(haberlerDizisi)
                    
                    
                }
            }
        }.resume()  // url session ı başlatmak için kullanıyoruz
    
    }
    
}

