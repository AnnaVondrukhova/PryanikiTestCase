//
//  JSONDataStruct.swift
//  PryanikiTestCase
//
//  Created by Anya on 16.07.2020.
//  Copyright © 2020 Anna Vondrukhova. All rights reserved.
//

import Foundation

struct PryanikiJSON: Decodable {
    let data: [JSONObject]?
    let view: [String]?
}

struct JSONObject: Decodable {
    let name: String?
    let data: JSONObjectData?
}

struct JSONObjectData: Decodable {
    let url: String?
    let text: String?
    let selectedId: Int?
    let variants: [Variant]?
}

struct Variant: Decodable {
    let id: Int?
    let text: String?
}
