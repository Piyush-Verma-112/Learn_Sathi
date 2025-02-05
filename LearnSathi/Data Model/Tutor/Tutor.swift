//
//  Tutor.swift
//  LearnSathi
//
//  Created by Admin on 30/01/25.

import Foundation

//
//struct TutorSearch {
//    var tutorProfile: String
//    var tutorName: String
//    var tutorRating: Float
//    var tutorExperience: String
//    var tutorCharges: Int
//    var tutorSubjects: String
//    var tutorLocation: String
//}

struct TutorId{
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

enum Gender {
    case Male, Female, PreferNotToSay
}
enum BookingStatus {
    case Session
    case Demo
}

