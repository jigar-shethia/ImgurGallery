//
//  ApiClient.swift
//  Imgur Gallery
//
//  Created by Jigar Shethia on 06/01/24.
//

import Alamofire
import Foundation
class ApiClient {
    
    // API call for fetching data from server.
    func getTopImagesFromImgur(completion: @escaping ([ImgurImage]?) -> Void) {

        let headers: HTTPHeaders = ["Authorization": "Client-ID \(UserDetails.clientID)"]
        
        AF.request(URLManager.topWeek(), headers: headers)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    if let json = value as? [String: Any], let data = json["data"] as? [[String: Any]] {
                        let images = data.compactMap { ImgurImage(json: $0) }
                        completion(images)
                    } else {
                        completion(nil)
                    }
                case .failure(let error):
                    print("Error: \(error)")
                    completion(nil)
                }
            }
    }
    


}
