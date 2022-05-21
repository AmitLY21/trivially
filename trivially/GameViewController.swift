//
//  GameViewController.swift
//  trivially
//
//  Created by Amit Levy on 14/05/2022.
//

import UIKit
import Kingfisher

class GameViewController: UIViewController{
    
    @IBOutlet weak var btnAnswer4: UIButton!
    @IBOutlet weak var btnAnswer3: UIButton!
    @IBOutlet weak var btnAnswer2: UIButton!
    @IBOutlet weak var btnAnswer1: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var lblWinCounter: UILabel!
    
    let URL_ = "https://pastebin.com/raw/i7rJY4Lq"
    var questions: [QuestionModel] = []
    var answers: [String] = []
    var counter:Int = 0
    var score:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseJson()
        while questions.isEmpty{}
        nextQuestion()
        progressBar.progress = 0.0
        
    }
    
    @IBAction func btnAns1(_ sender: Any) {
        gameFlow(currentAnswer: btnAnswer1.currentTitle!)
    }
    
    @IBAction func btnAns2(_ sender: Any) {
        gameFlow(currentAnswer: btnAnswer2.currentTitle!)
    }
    
    @IBAction func btnAns3(_ sender: Any) {
        gameFlow(currentAnswer: btnAnswer3.currentTitle!)
    }
    
    @IBAction func btnAns4(_ sender: Any) {
        gameFlow(currentAnswer: btnAnswer4.currentTitle!)
    }
    
    func gameFlow(currentAnswer:String) {
        if checkAnswer(currAnswer: currentAnswer){
            score += 1
            lblWinCounter.text = "Score: \(score)"
        }
        if counter < 15 {
            nextQuestion()
            progressBar.progress = Float(counter)/Float(questions.count)
            lblScore.text = "Round: \(counter-1)/15"
        }else{
            returnToHomeView();
        }
    }
    
    func returnToHomeView(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "home") as! HomeViewController
        vc.score = score
        present(vc, animated: true)
    }
    
    func checkAnswer(currAnswer:String) -> Bool{
        if questions[counter-1].answer == currAnswer{
            return true
        }
        return false
    }
    
    func nextQuestion(){
        let url = URL(string: questions[counter].imageUrl)
        let processor = RoundCornerImageProcessor(cornerRadius: 40)
        imageView.kf.setImage(with: url, placeholder: nil, options: [.processor(processor)])
        
        var tempArr:[String] = [questions[counter].answer]
        while tempArr.count < 4{
            let tempAnswer:String = answers.randomElement()!
            if !tempArr.contains(tempAnswer){
                tempArr.append(tempAnswer)
            }
        }
        
        tempArr.shuffle()
        btnAnswer1.setTitle(tempArr[0], for: .normal)
        btnAnswer2.setTitle(tempArr[1], for: .normal)
        btnAnswer3.setTitle(tempArr[2], for: .normal)
        btnAnswer4.setTitle(tempArr[3], for: .normal)
        counter += 1
    }
    
    func parseJson(){
        if let url = URL(string: URL_) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    let jsonDecoder = JSONDecoder()
                    do {
                        let parsedJSON = try jsonDecoder.decode(Questions.self, from: data)
                        for q in parsedJSON.allQuestions {
                            self.questions.append(QuestionModel(imageUrl: q.imageUrl, answer: q.answer))
                        }
                        for a in parsedJSON.allAnswers{
                            self.answers.append(a)
                        }
                    } catch {
                        print(error)
                    }
                }
            }.resume()
        }
    }
}
