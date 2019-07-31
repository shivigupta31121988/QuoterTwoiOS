//
//  QuotesProcessor.swift
//  Quoter2
//
//  Created by Shivi Gupta on 23/06/19.
//  Copyright © 2019 Shivi Gupta. All rights reserved.
//

import Foundation
class QuotesProcessor{
    static func mapJsonToMovies(object: [String: AnyObject], moviesKey: String) -> [Quotes] {
        var mappedMovies: [Quotes] = []
        
        guard let movies = object[moviesKey] as? [[String: AnyObject]] else { return mappedMovies }
        
        for movie in movies {
            guard let id = movie["gsx$keyid"] as? String,
                let speaker = movie["gsx$speaker"] as? String,
                let quote = movie["gsx$quote"] as? String,
                let category = movie["gsx$category"] as? String else { continue }
            
            let movieClass = Quotes(keyid: id, speaker: speaker, category: category, quote: quote)
            mappedMovies.append(movieClass)
        }
        return mappedMovies
    }
    
    static func write(movies: [Quotes]) {
        // TODO: Implement :)
    }
}
