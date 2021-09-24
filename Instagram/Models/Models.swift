//
//  Models.swift
//  Instagram
//
//  Created by Артем Волков on 22.09.2021.
//

import UIKit

public enum UserPostType: String {
    case photo = "Photo"
    case video = "Video"
}

public struct UserPost {
    let identifier: String
    let postType: UserPostType
    let thumbnailImage: URL
    let postURL: URL
    let caption: String?
    let likeCount: [PostLike]
    let comments: [PostComment]
    let postedDate: Date
    let taggedUsers: [String]
    let owner: User
}

enum Gender {
    case male, female, other
}

struct UserCount {
    let followers: Int
    let following: Int
    let post: Int
}
public struct User{
    let userName: String
    let bio: String
    let name: (first: String, second: String)
    let birthDate: Date
    let gender: Gender
    let counts: UserCount
    let joinDate: Date
    let profilePhoto: URL
}

struct PostComment {
    let userName: String
    let commentIdentifier: String
}

struct PostLike {
    let identifier: String
    let userName: String
    let text: String
    let createdDate: Date
    let postlike: [PostComment]
}
