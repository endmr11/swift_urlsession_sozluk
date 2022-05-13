//
//  Kelimeler.swift
//  udemy_urlsession_sozluk
//
//  Created by Eren Demir on 13.05.2022.
//

import Foundation


class Kelimeler:Codable {
    var kelimeler: [Kelime]?
}

class Kelime:Codable {
    var kelime_id:String?
    var turkce:String?
    var ingilizce:String?
    
    init() {
        
    }
    init(kelime_id:String,turkce:String,ingilizce:String) {
        self.kelime_id = kelime_id
        self.turkce = turkce
        self.ingilizce = ingilizce
    }
}
