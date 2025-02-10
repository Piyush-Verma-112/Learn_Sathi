//
//  Tutor.swift
//  LearnSathi
//
//  Created by Admin on 30/01/25.

import Foundation

struct TutorId: Decodable{
    var id: UUID = UUID()
    var fullName: String
    var gender: Gender
    var profileImage: String
    var bio: String
    var experience: String // in years like 5yr, 4yr
    var charges : Int
    var subjects: [String]
    var Standard: [Int]
    var gradInstitute: String // graduated or mastered from
    var address: String
    var ratings: Float
}

enum Gender: String, Codable {
    case Male, Female, PreferNotToSay
}
enum BookingStatus: Codable {
    case Session
    case Demo
}

