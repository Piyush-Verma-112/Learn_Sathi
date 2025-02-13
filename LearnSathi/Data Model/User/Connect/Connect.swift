//
//  Connect.swift
//  LearnSathi
//
//  Created by Batch - 2 on 15/01/25.
//

import Foundation
import UIKit

struct Tutor {
    let id: UUID
    let tutorName: String
    let tutorProfileImage: String
    let subject: [String]
    let subjectIcon: String
}

struct Doubts {
    let subjectName: String
    let lessonName: String
    let status: String
    let date: String
    let question: String
    let solution: String
    let solutionImages: [UIImage]
}

