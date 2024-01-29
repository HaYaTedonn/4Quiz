//
//  Quiz2ViewController.swift
//  4択クイズ！
//
//  Created by はやてどん on 2024/01/24.
//

import UIKit
import AVFoundation

class Quiz2ViewController: UIViewController {

    @IBOutlet var quizNumberLabel: UILabel!
    
    @IBOutlet var quizTextView: UITextView!
    
    @IBOutlet var answerButton1: UIButton!
    
    @IBOutlet var answerButton2: UIButton!
    
    @IBOutlet var answerButton3: UIButton!
    
    @IBOutlet var answerButton4: UIButton!
    
    @IBOutlet var judgeImageView: UIImageView!
    
    var csvArray: [String] = []
    var quizArray: [String] = []
    var quizCount = 0
    var correctCount = 0
    var shuffledQuizIndices: [Int] = []
    var totalQuizCount = 10 // 出題する総数
    var currentQuizIndex = 0 // 現在の問題のインデックス
    var soundEffectPlayer: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        csvArray = loadCSV(fileName: "quiz2")
        //print(csvArray)
        quizTextView.isEditable = false
        
        // インデックスをシャッフル
        shuffledQuizIndices = Array(0..<csvArray.count)
        shuffledQuizIndices.shuffle()
            
            // 最初の問題を表示
            showNextQuiz()
        
        // ユーザーのタップに反応しないようにする
        quizTextView.isUserInteractionEnabled = false
        // Do any additional setup after loading the view.
    }

    
    func showNextQuiz() {
            if currentQuizIndex < totalQuizCount {
                let shuffledIndex = shuffledQuizIndices[currentQuizIndex]
                quizArray = csvArray[shuffledIndex].components(separatedBy: ",")
                quizNumberLabel.text = "第\(currentQuizIndex + 1)問"
                quizTextView.text = quizArray[0]
                answerButton1.setTitle(quizArray[2], for: .normal)
                answerButton2.setTitle(quizArray[3], for: .normal)
                answerButton3.setTitle(quizArray[4], for: .normal)
                answerButton4.setTitle(quizArray[5], for: .normal)
            } else {
                performSegue(withIdentifier: "toScoreVC", sender: nil)
            }
        }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let scoreVC = segue.destination as! Score1ViewController
            scoreVC.correct = correctCount
        }
    
    func playSoundEffect(name: String) {
            guard let path = Bundle.main.path(forResource: name, ofType: "mp3") else {
                print("効果音ファイルが見つかりません")
                return
            }

            let url = URL(fileURLWithPath: path)

            do {
                soundEffectPlayer = try AVAudioPlayer(contentsOf: url)
                soundEffectPlayer?.play()
            } catch {
                print("効果音の再生に失敗しました")
            }
        }
    
    @IBAction func btnAction(sender: UIButton){
        
        playSoundEffect(name: "SE")
        
        let selectedTag = sender.tag
        let correctTag = Int(quizArray[1]) ?? 0
        
        if selectedTag == correctTag {
            print("正解")
            correctCount += 1
            judgeImageView.image = UIImage(named: "correct")
            playSoundEffect(name: "maru")
            // 正解のボタンの色を変える
            sender.backgroundColor = UIColor.green
        }else{
            print("不正解")
            judgeImageView.image = UIImage(named: "incorrect")
            playSoundEffect(name: "batu")
            
            // 正解のボタンの色を変える
            if let correctButton = view.viewWithTag(correctTag) as? UIButton {
                correctButton.backgroundColor = UIColor.green
            }
        }
//        print("スコア：\(correctCount)")
        judgeImageView.isHidden = false
        answerButton1.isEnabled = false
        answerButton2.isEnabled = false
        answerButton3.isEnabled = false
        answerButton4.isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            self.judgeImageView.isHidden = true
            self.answerButton1.isEnabled = true
            self.answerButton2.isEnabled = true
            self.answerButton3.isEnabled = true
            self.answerButton4.isEnabled = true
            
            self.currentQuizIndex += 1
            self.resetButtonColors() // 新しい問題が表示されたらボタンの色を元に戻す
            self.showNextQuiz()
        }
    }
    
    func resetButtonColors() {
        answerButton1.backgroundColor = UIColor(red: 255/255, green: 64/255, blue: 255/255, alpha: 0.85)
        answerButton2.backgroundColor = UIColor(red: 255/255, green: 64/255, blue: 255/255, alpha: 0.85)
        answerButton3.backgroundColor = UIColor(red: 255/255, green: 64/255, blue: 255/255, alpha: 0.85)
        answerButton4.backgroundColor = UIColor(red: 255/255, green: 64/255, blue: 255/255, alpha: 0.85)
    }
    
    func nextQuiz(){
        quizCount += 1
        if quizCount < csvArray.count {
            
            quizArray = csvArray[quizCount].components(separatedBy: ",")
            quizNumberLabel.text = "第\(quizCount + 1)問"
            quizTextView.text = quizArray[0]
            answerButton1.setTitle(quizArray[2], for: .normal)
            answerButton2.setTitle(quizArray[3], for: .normal)
            answerButton3.setTitle(quizArray[4], for: .normal)
            answerButton4.setTitle(quizArray[5], for: .normal)
            
        }else{
            
            performSegue(withIdentifier: "toScoreVC", sender: nil)
        }
    }
    
    func loadCSV(fileName: String) -> [String] {
        let csvBundle = Bundle.main.path(forResource: fileName, ofType: "csv")!
        do{
            let csvData = try String(contentsOfFile: csvBundle, encoding: String.Encoding.utf8)
            let lineChange = csvData.replacingOccurrences(of: "\r", with: "\n")
            csvArray = lineChange.components(separatedBy: "\n")
            csvArray.removeLast()
        }catch{
            print("エラー")
        }
        return csvArray
    }
    @IBAction func toBackButton(_ sender: UIButton) {
        playSoundEffect(name: "SE")
        self.presentingViewController?.dismiss(animated: true)
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override var shouldAutorotate: Bool {
        return false
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
