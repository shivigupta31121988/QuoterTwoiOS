//
//  Quotes.swift
//  Quoter2
//
//  Created by Shivi Gupta on 23/06/19.
//  Copyright © 2019 Shivi Gupta. All rights reserved.
//

import Foundation
class Quotes{
    var keyid: String = ""
    var speaker: String = ""
    var category: String = ""
    var quote: String = ""
    
    
    init(keyid: String, speaker: String, category: String, quote: String) {
        self.keyid = keyid
        self.speaker = speaker
        self.category = category
        self.quote = quote
        
    }
}
