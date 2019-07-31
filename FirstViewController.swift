//
//  FirstViewController.swift
//  Quoter2
//
//  Created by Shivi Gupta on 09/06/19.
//  Copyright © 2019 Shivi Gupta. All rights reserved.
//

import UIKit
import GoogleMobileAds

class FirstViewController: UIViewController {

    
    @IBOutlet weak var quoteText: UILabel!
     var searchResults: [Quotes] = []
    var filteredListQuotes : [Quotes] = []
     let titleLabel = UILabel()
    
    var categorySelected:String! = ""
    
/*     func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if (segue.identifier == "Category") {
            let secondViewController = segue.destination as! FirstViewController
            let category = sender as! String
            secondViewController.category = category
        }
    }*/
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      
        self.categorySelected = "All"
        
            self.quoteText.text = "Swipe left or right for quotes or select a category!"
        //self.quoteText.font
        titleLabel.text = "welcome patrons, howdy!!"
        let stackView =  UIStackView(arrangedSubviews: [titleLabel])
        stackView.axis = .vertical
        
        self.view.addSubview(stackView)
        
        stackView.frame = CGRect(x:0 , y:0, width: 400, height: 800)
        //enables autolayout
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -100).isActive = true
        
        
        // animation
        UIView.animate(withDuration: 1.5,delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations :{
            self.titleLabel.transform = CGAffineTransform(translationX: -30, y: 0)
        }) { (_)  in
            
            UIView.animate(withDuration: 1.5,delay: 1, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations :{
                self.titleLabel.alpha = 0
                self.titleLabel.transform = self.quoteText.transform.translatedBy(x: 0, y: -200)
            })
        }
        
     
        
            DispatchQueue.main.async {
                self.retrieveMoviesByTerm(searchTerm: "test")
            
            }
        
       // self.quoteText.text = self.searchResults[category] as! String
       // let swipeRight = UISwipeGestureRecognizer(target: self, action: Selector(("respondToSwipeGesture:")))
        //self.view.addGestureRecognizer(swipeRight)
        //swipeRight.direction = [UISwipeGestureRecognizer.Direction.left, UISwipeGestureRecognizer.Direction.right]
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(sender:)))
        leftSwipe.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(leftSwipe)
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(sender:)))
        rightSwipe.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(rightSwipe)
    }

    func retrieveMoviesByTerm(searchTerm: String) {
        //let url = "https://www.omdbapi.com/?apikey=PlzBanMe&s=\(searchTerm)&type=movie&r=json"
        let url = "https://spreadsheets.google.com/feeds/list/1omT0mse1YMgIChm2rwsKEoP-_upuzZ0GGQ-25a-wG_E/od6/public/values?alt=json"
        DispatchQueue.main.async{
            HTTPHandler.getJson(urlString: url, completionHandler: self.parseDataIntoMovies)
        }
        
    }
    @objc func handleSwipes(sender: UISwipeGestureRecognizer) {
        let swipeGesture = sender
      
        if self.categorySelected != "All" {
            self.filteredListQuotes = self.searchResults.filter { $0.category.contains(self.categorySelected) || $0.speaker.contains(self.categorySelected) }
        }else{
            self.filteredListQuotes = self.searchResults
        }
          let number = Int.random(in: 0 ... self.filteredListQuotes.count-1)
        switch swipeGesture.direction {
        case UISwipeGestureRecognizer.Direction.right:
            
            
            
           
              
                self.quoteText.text = self.filteredListQuotes[number].quote + "\n\n-" + self.filteredListQuotes[number].speaker
            
            
        case UISwipeGestureRecognizer.Direction.left:
            
            self.quoteText.text = self.filteredListQuotes[number].quote + "\n\n-" + self.filteredListQuotes[number].speaker
            
        default:
            break
        }
    }
    func parseDataIntoMovies(data: Data?) -> Void {
        if let data = data {
            let object = JSONParser.parse(data: data)
            //let feed=JSONParser.parse(data: object!["feed"]! as! Data)
            //let entry=JSONParser.parse(data: feed!["entry"]! as! Data)
            //print(entry)
          
            if let dictResponse = object {
                // This will get entire dictionary from your JSON.
                if let root = dictResponse["feed"] as? [String:AnyObject]{
                if let results = root["entry"] as? [[String:AnyObject]]{
                    for objQuotes in results.enumerated(){
                        if let quote = objQuotes.element["gsx$quote"] as? [String:AnyObject], let keyid = objQuotes.element["gsx$keyid"] as? [String:AnyObject], let speaker = objQuotes.element["gsx$speaker"] as? [String:AnyObject], let category = objQuotes.element["gsx$category"] as? [String:AnyObject]{
                            
                            let movieClass = Quotes(keyid: keyid["$t"] as! String, speaker: speaker["$t"] as! String, category: category["$t"] as! String, quote: quote["$t"] as! String)
                            
                            self.searchResults.append(movieClass)
                            // self.searchResults = QuotesProcessor.mapJsonToMovies(object: pageData, moviesKey: "Search")
                        }
                    }
                    
                    
                   
                        
                    
                    }
                }
                }
            
         
            let number = Int.random(in: 0 ... self.searchResults.count-1)
            self.quoteText.text = self.searchResults[number].quote + "\n\n-" + self.searchResults[number].speaker
            
           self.filteredListQuotes = self.searchResults
            
            
            
        }
    }
    

}


