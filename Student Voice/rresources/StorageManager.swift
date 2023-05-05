//
//  StorangeManager.swift
//  Student Voice
//
//  Created by 6f on 4/28/23.
//

import Firebase
import FirebaseStorage


public class StorageManager {
    
    static let shared = StorageManager()
    
    private let bucket = Storage.storage().reference()
    
    public enum IGStorageManagerError: Error {
        case failedToDownload
    }
    
    // Mark: - Public
    
    public func uploadUserPost(model: UserPost, completion: (Result<URL, Error>) -> Void) {
        
    }
    
    public func downloadImage(with reference: String, completion: @escaping   (Result<URL, IGStorageManagerError>) -> Void) {
        bucket.child(reference).downloadURL(completion: { url, error in
            guard let url = url, error == nil else {
                completion(.failure(.failedToDownload))
                return
            }
            completion(.success(url))

        })
    }
    
}

public enum UserPostType{
    case photo, video
}

public struct UserPost {
    let postType: UserPostType
}
