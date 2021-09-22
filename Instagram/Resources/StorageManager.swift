//
//  StorageManager.swift
//  Instagram
//
//  Created by Артем Волков on 19.09.2021.
//

import FirebaseStorage

public class StorageManager{
    static let shared = StorageManager()
    
    private let bucket = Storage.storage().reference()
    
    public enum StoregeManagerError: Error {
        case failedToDownload
    }
    
    //MARK: - Public
    public func uploadUserPhotoPost(model: UserPost, complition: (Result<URL, Error>) -> Void) {
        
    }
    
    public func downloadImage(with reference: String, complition: @escaping (Result<URL, StoregeManagerError>) -> Void){
        bucket.child(reference).downloadURL { url, error in
            guard let url = url, error == nil else {
                complition(.failure(.failedToDownload))
                return
            }
            
            complition(.success(url))
            
        }
    }
    

    
}
