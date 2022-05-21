//
//  Question.swift
//  trivially
//
//  Created by Amit Levy on 17/05/2022.
//

import Foundation

struct Questions: Codable{
    let allQuestions:[QuestionModel]
    let allAnswers:[String]
}

struct QuestionModel: Codable{
    let imageUrl:String
    let answer: String
}
