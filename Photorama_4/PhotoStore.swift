//
//  PhotoStore.swift
//  Photorama_4
//
//  Created by Yang Liu on 5/19/17.
//  Copyright © 2017 Yang Liu. All rights reserved.
//

import UIKit

enum ImgaeResult {
    case success(UIImage)
    case failure(Error)
}

enum PhotoError: Error {
    case imageCreatingError
}

enum PhotosResult {
    case success([Photo])
    case failure(Error)
}

class PhotoStore{
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    func fetchInterestingPhotos(completion: @escaping (PhotosResult) -> Void ) {
        let url = FlickrAPI.interestingPhotosURL
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
            let result = self.processPhotosRequest(data: data, error: error)
            completion(result)
        }
        task.resume()
    }
    
    private func processPhotosRequest (data: Data?, error: Error?) -> PhotosResult {
        guard let jsonData = data else {
            return .failure(error!)
        }
        return FlickrAPI.photos(fromJSON: jsonData)
    }
}
