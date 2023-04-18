//
//  IntroPage.swift
//  
//
//  Created by Christian Leyva on 17/04/23.
//

import Foundation

struct IntroPage: Identifiable, Equatable {
    let id = UUID()
    var name: String
    var description: String
    var imageUrl: String
    var imageAttrib: String = ""
    var tag: Int
}
