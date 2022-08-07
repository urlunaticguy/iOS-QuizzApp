//
//  ViewController.swift
//  QuizzApp
//
//  Created by Souvik Das on 04/08/22.
//

import UIKit

class ViewController: UIViewController {
    
    var ques = Questions(index: [])
    var timer : Timer?
    var timer1 : Timer?
    var score = 0
    var optionPressed = false
    var delayTime = 0.8
    var counter = 0
    var questionNoPageON = false
    var noOfQuestions = 0
    var optionSelected = false

    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var startStopBut: UIButton!
    @IBOutlet weak var optionOneBut: UIButton!
    @IBOutlet weak var optionTwoBut: UIButton!
    @IBOutlet weak var optionThreeBut: UIButton!
    @IBOutlet weak var optionFourBut: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        appOpen()
    }
    
    @IBAction func startStopButton(_ sender: UIButton) {
        let buttonTitle = sender.currentTitle!
        
        if (buttonTitle == "START") && !optionSelected {
            print("NO OPTION SELECTED")
        } else if (buttonTitle == "RESTART") && !optionSelected {
            questionLabel.font = UIFont.systemFont(ofSize: 45)
            appOpen()
            optionPressed = false
        } else if (buttonTitle == "STOP") {
            gameReachedEnd(identity: true)
            optionPressed = false
        }
    }
    
    @IBAction func optionsPressed(_ sender: UIButton) {
        if questionNoPageON {
            sender.backgroundColor = UIColor(red: 0.00, green: 0.56, blue: 0.70, alpha: 1.00)
            questionNoPageON = false
            questionLabel.text = "Let's START 🙆🏻‍♂️"
            noOfQuestions = ques.questionsCountDict[sender.currentTitle!]!
            ques.randomSeries(nos: noOfQuestions)
            
            var timingVar = 5
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
                timingVar -= 1
                print(timingVar)
                if timingVar <= 3 {
                    self.startStopBut.setTitle("Starting in \(timingVar)", for: .normal)
                }
                if timingVar == 0 {
                    self.timer?.invalidate()
                    self.progressView.backgroundColor = UIColor.red
                    self.optionSelected = false
                    self.questionLabel.backgroundColor = UIColor.darkGray
                    self.questionLabel.font = UIFont.systemFont(ofSize: 40)
                    self.gameStart()
                    self.updateScore()
                }
            }
            
            
        }
        
        if optionPressed { // to prevent any misclicks other than answering questions
            optionPressed = false
            let actualAnswer = ques.throwAnswer()
            if actualAnswer == sender.currentTitle! { //right answer
                sender.backgroundColor = UIColor(red: 0.00, green: 0.50, blue: 0.17, alpha: 1.00) //green
                score += 1
                updateScore()
            } else { //wrong answer
                sender.backgroundColor = UIColor(red: 0.70, green: 0.18, blue: 0.00, alpha: 1.00) //red
                setGreenColActualAnswer(answerTitle: actualAnswer)
                delayTime = 1.0
            }
            timer = Timer.scheduledTimer(withTimeInterval: delayTime, repeats: false) { (Timer) in
                if self.counter < self.noOfQuestions {
                    if self.counter == self.noOfQuestions {
                        self.delayTime = 1.2 //seconds to reach the final screen after last question
                    }
                    self.gameStart()
                }
                else {
                    self.gameReachedEnd(identity: false)
                }
            }
        }
    }
    
    
    func appOpen() {
        startStopBut.setTitle("START", for: .normal)
        questionLabel.text = "Choose your questions 👇🏻"
        scoreLabel.text = ""
        optionOneBut.setTitle("5 questions", for: .normal)
        optionTwoBut.setTitle("10 questions", for: .normal)
        optionThreeBut.setTitle("20 questions", for: .normal)
        optionFourBut.setTitle("40 questions", for: .normal)
        questionLabel.backgroundColor = UIColor.black
        scoreLabel.backgroundColor = UIColor.black
        questionNoPageON = true
        setOptionsBlack()
        progressView.progress = 0
        progressView.backgroundColor = UIColor.blue
        progressView.tintColor = UIColor.green
    }
    
    @objc func gameStart() {
        startStopBut.setTitle("STOP", for: .normal)
        questionLabel.text = ques.throwQuestion()
        let opt = ques.throwOptions()
        optionOneBut.setTitle(opt[0], for: .normal)
        optionTwoBut.setTitle(opt[1], for: .normal)
        optionThreeBut.setTitle(opt[2], for: .normal)
        optionFourBut.setTitle(opt[3], for: .normal)
        setOptionsViolet()
        optionPressed = true
        progressView.progress = Float(counter)/Float(noOfQuestions)
        counter += 1
        delayTime = 0.8
    }
    
    func updateScore() {
        scoreLabel.text = "Score 👉🏼 \(score) / \(noOfQuestions)"
    }
    
    func gameReachedEnd(identity: Bool) {
        progressView.progress = 1
        if identity {
            questionLabel.text = "Game Stopped 😬"
            progressView.tintColor = UIColor.red
        } else {
            questionLabel.text = "Game Ended 👏🏻"
            progressView.tintColor = UIColor.blue
        }
        scoreLabel.text = "Your Score 👉🏼 \(score) / \(noOfQuestions)"
        startStopBut.setTitle("RESTART", for: .normal)
        optionOneBut.setTitle("", for: .normal)
        optionTwoBut.setTitle("", for: .normal)
        optionThreeBut.setTitle("", for: .normal)
        optionFourBut.setTitle("", for: .normal)
        setOptionsDarkGray()
        ques.gameEndedResetValues()
        counter = 0
        delayTime = 0.8
        score = 0
    }
    
    func setOptionsViolet() {
        optionOneBut.backgroundColor = UIColor(red: 0.35, green: 0.00, blue: 0.70, alpha: 1.00)
        optionTwoBut.backgroundColor = UIColor(red: 0.35, green: 0.00, blue: 0.70, alpha: 1.00)
        optionThreeBut.backgroundColor = UIColor(red: 0.35, green: 0.00, blue: 0.70, alpha: 1.00)
        optionFourBut.backgroundColor = UIColor(red: 0.35, green: 0.00, blue: 0.70, alpha: 1.00)
    }
    
    func setOptionsDarkGray() {
        optionOneBut.backgroundColor = UIColor.darkGray
        optionTwoBut.backgroundColor = UIColor.darkGray
        optionThreeBut.backgroundColor = UIColor.darkGray
        optionFourBut.backgroundColor = UIColor.darkGray
    }
    
    func setOptionsBlack() {
        optionOneBut.backgroundColor = UIColor.black
        optionTwoBut.backgroundColor = UIColor.black
        optionThreeBut.backgroundColor = UIColor.black
        optionFourBut.backgroundColor = UIColor.black
    }
    
    func setGreenColActualAnswer(answerTitle: String) {
        if optionOneBut.currentTitle! == answerTitle {
            optionOneBut.backgroundColor = UIColor(red: 0.00, green: 0.50, blue: 0.17, alpha: 1.00)
        } else if optionTwoBut.currentTitle! == answerTitle {
            optionTwoBut.backgroundColor = UIColor(red: 0.00, green: 0.50, blue: 0.17, alpha: 1.00)
        } else if optionThreeBut.currentTitle! == answerTitle {
            optionThreeBut.backgroundColor = UIColor(red: 0.00, green: 0.50, blue: 0.17, alpha: 1.00)
        } else if optionFourBut.currentTitle! == answerTitle {
            optionFourBut.backgroundColor = UIColor(red: 0.00, green: 0.50, blue: 0.17, alpha: 1.00)
        }
    }

}

