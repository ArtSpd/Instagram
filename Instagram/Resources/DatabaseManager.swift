//
//  DatabaseManager.swift
//  Instagram
//
//  Created by Артем Волков on 19.09.2021.
//

import Foundation
import FirebaseDatabase

public class DatabaseManager{
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    //MARK: - Public
    //Check if username and email is available
    public func canCreateNewUser(with email: String, username: String, complition: (Bool) -> Void){
        complition(true)
    }
    
    public func insertNewUser(with email: String, username: String, complition: @escaping (Bool)-> Void){
        database.child(email.saveDataBaseKey()).setValue(["username": username]){ error, _ in
            if error == nil {
                //success
                complition(true)
                return
            } else {
                //error
                complition(false)
                return
            }
            
        }
    }
}
