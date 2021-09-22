//
//  AuthManager.swift
//  Instagram
//
//  Created by Артем Волков on 19.09.2021.
//


import FirebaseAuth

public class AuthManager{
    static let shared = AuthManager()
    
    //MARK: - Public
    public func regusterNewUser(userName: String, email: String, password: String, complition: @escaping (Bool)-> Void){
        /*
         - Check username is available
         - Check email is available
         - Create account
         - Insert account to database
         */
        
        DatabaseManager.shared.canCreateNewUser(with: email, username: userName) { success in
            if success{
                // Create account
                // Insert account to database
                Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                    guard error == nil, result != nil else {
                        //firebase auth could not create account
                        complition(false)
                        return
                    }
                    
                    // insert into database
                    DatabaseManager.shared.insertNewUser(with: email, username: userName) { success in
                        if success{
                            complition(true)
                            return
                        } else {
                            complition(false)
                            return
                        }
                    }
                }
            }
            else {
                //username or email does not exist
                complition(false)
            }
        }
    }
    
    public func loginUser(userName: String?, email: String?, password: String, completion: @escaping ((Bool) -> Void)){
        if let email = email{
            //email login
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                guard authResult != nil, error == nil else {
                    completion(false)
                    return
                    
                }
                completion(true)
            }
        } else if let username = userName {
            //username login
            print(userName)
        }
    }
    
    public func logOut(complition: (Bool)-> Void){
        do {
            try Auth.auth().signOut()
            complition(true)
            return
        } catch{
            print(error)
            complition(false)
            return
        }
    }
}
