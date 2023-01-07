//
//  PrayingTimes.swift
//  NamozVaqtlari_API
//
//  Created by Abdulbosid Jalilov on 04/01/23.
//

import Foundation

struct TimeList : Codable {
    
    let date    : String
    let weekdate: String
    var result  : ResultList
}

struct ResultList: Codable {
    let tong_saharlik  : String
    let quyosh         : String
    let peshin         : String
    let asr            : String
    let shom_iftor     : String
    let xufton         : String
}
