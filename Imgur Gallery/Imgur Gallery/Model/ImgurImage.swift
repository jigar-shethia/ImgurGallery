//
//  ImgurImage.swift
//  Imgur Gallery
//
//  Created by Jigar Shethia on 06/01/24.
//

import Foundation

struct ImgurImage: Identifiable, Codable {
    var title: String
    var date: Date
    var numImages: Int
    var imageURL: URL?
    var id = UUID()
    
    init?(json: [String: Any]) {
        guard let title = json["title"] as? String,
              let dateInt = json["datetime"] as? TimeInterval,
              let numImages = json["images_count"] as? Int,
              let images = json["images"] as? [[String: Any]],
              let firstImage = images.first,
              let link = firstImage["link"] as? String else {
            return nil
        }
        
        self.title = title
        self.date = Date(timeIntervalSince1970: dateInt)
        self.numImages = numImages
        self.imageURL = filterUrlforVideoURL(link: link)
        
        
    }
    
// Converting date to String
    func getDateString() -> String{
       
        print("Date 12 \(self.date)")
        let df = DateFormatter()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yy"
        return dateFormatter.string(from: self.date)
    }
    
    /* This methed as added because api call is not
            filtering for image formats.*/
    func filterUrlforVideoURL(link:String) -> URL?
    {
        var imageURL: URL?
        if link.contains(".jpg") || link.contains(".png") ||  link.contains(".jpeg") {
            if let url = URL(string: link)
            {
                imageURL = url
            }
        }
        return imageURL
    }
}
