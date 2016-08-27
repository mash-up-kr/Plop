//
//  Status.swift
//  Plop
//
//  Created by 김혜원 on 2016. 8. 28..
//  Copyright © 2016년 seolheelee. All rights reserved.
//

import Foundation
import ObjectMapper

class ShitListResponse: Mappable {
    
    var data: [Status]?
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        data <- map["data"]
    }

}

class Status: Mappable {
    var shitColor: String?
    var shitType: String?
    var score: String?
    var shitAmount: String?
    var shitSec: Int?
    var shitThick: String?
    var shitDate: String?

    var shitColorText: String {
        return ShitColor(rawValue: shitColor ?? "A")?.text ?? ShitColor.Black.text
    }
    
    var shitTypeText: String {
        switch shitType ?? "A" {
        case "A":
            return "토끼똥"
        case "B":
            return "딱딱하고 건조한"
        case "C":
            return "소세지"
        case "D":
            return "묽고 퍼진"
        default:
            return "토끼똥"
        }
    }
    
    var shitAmountText: String {
        switch shitAmount ?? "A" {
        case "A":
            return "적음"
        case "B":
            return "보통"
        case "C":
            return "많음"
        default:
            return "적음"
        }
    }

    var shitThickText: String {
        switch shitThick ?? "A" {
        case "A":
            return "가느다란"
        case "B":
            return "보통"
        case "C":
            return "굵은"
        case "D":
            return "없음"
        default:
            return "가느다란"
        }
    }
    
    var scoreImage: UIImage {
        switch score ?? "bad" {
        case "bad":
            return UIImage(named: "Emotion_bad")!
        case "normal":
            return UIImage(named: "Emotion_regular")!
        case "good":
            return UIImage(named: "Emotion_good")!
        default:
            return UIImage(named: "Emotion_bad")!
        }
        
    }
    
    var scoreImageText: String {
        switch score ?? "bad" {
        case "bad":
            return "나쁨"
        case "normal":
            return "보통"
        case "good":
            return "좋음"
        default:
            return "나쁨"
        }

    }
    
    var dateStrings: [String] {
        return shitDate?.componentsSeparatedByString("-") ?? ["", "", ""]
    }
    
    init(shitColor: String, shitType: String, score: String, shitAmount: String, shitSec: Int, shitThick: String, shitDate: String) {
        self.shitColor = shitColor
        self.shitType = shitType
        self.score = score
        self.shitAmount = shitAmount
        self.shitSec = shitSec
        self.shitThick = shitThick
        self.shitDate = shitDate
    }
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        shitColor <- map["shitColor"]
        shitType <- map["shitType"]
        score <- map["score"]
        shitAmount <- map["shitAmount"]
        shitSec <- map["shitSec"]
        shitThick <- map["shitThick"]
        shitDate <- map["shitDate"]
    }
  
    
    
    
}


enum ShitColor: String {
    case Black = "A"
    case Red = "B"
    case RedBrown = "C"
    case Brown = "D"
    case Yellow = "E"
    case Green = "F"
    
    var text: String {
        switch self {
        case .Black:
            return "검정색"
        case .Red:
            return "빨강색"
        case .RedBrown:
            return "붉은갈색"
        case .Brown:
            return "황토색"
        case .Yellow:
            return "노랑색"
        case .Green:
            return "초록색"
        }
    }
}
