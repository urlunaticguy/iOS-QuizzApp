//
//  Questions.swift
//  QuizzApp
//
//  Created by Souvik Das on 04/08/22.
//

import Foundation

// question file

struct Questions {
    
    //total questions = 12
    //python = 10 - java = 2
    
    let questions = ["Python first version was released in the year","Who developed Python language?","The Python logo contains ___ number of snakes?","The name PYTHON was adopted from which TV show?","Python is a ___ level programming language.","Python is a ____ language.","Python 3.0 was released in the year ____.","Which is the default compiler for Python Language?","CPython compiler is written in ___ programming language.","Which are the popular sponsors of Python Software Foundation (PSF)?","Java was designed by ___","Earlier name of Java Programming language was"]
    
    let options = [["1981","1991","1995","2000"],["Dennis Ritchie","James Gosling","Guido Van Rossum","Graham Bell"],["2","3","4","6"],["F.R.I.E.N.D.S","Craig Robinson's Killing It","Monty Python's Flying Circus","Snake City"],["Low level","Medium level","High level","None"],["Object Oriented","Portable","Secure","All of the mentioned"],["2008","2015","2018","2020"],["CPython","PyPy","IronPython","Jython"],["C","C++","Java","PHP"],["Google, Bloomberg, Meta","AWS, NVIDIA","Microsoft, Salesfore, CapitalOne, Corning","All of the mentioned"],["Microsoft","Mozilla Corporation","Sun Microsystems","Amazon Inc."],["Eclipse","Oak","Netbeans","D"]]
    
    let answer = [1,2,0,2,2,3,0,0,0,3,2,1]
    
    var index : [Int]
    var i = -1
    
    let questionsCountDict = ["5 questions":5, "10 questions":10, "20 questions":20, "40 questions":40]
    
    init(index: [Int]) {
        self.index = index
    }
    
    mutating func randomSeries(nos: Int) {
        // sequence of questions to be asked in random order // call this once
        while (index.count != nos) {
            let randomNum = Int.random(in: 0..<questions.count)
            if !(index.contains(randomNum)) {
                index.append(randomNum)
            }
        }
    }
    
    mutating func throwQuestion() -> String {
        i += 1
        return questions[index[i]]
    }
    
    mutating func throwOptions() -> [String] {
        var optionsArray = options[index[i]]
        optionsArray.shuffle()
        return optionsArray
    }
    
    func throwAnswer() -> String {
//        return options[index[i]][answer[index[i]]]
        return options[index[i]][answer[index[i]]]
    }
    
    mutating func gameEndedResetValues() {
        i = -1
        index = []
    }
    
}
