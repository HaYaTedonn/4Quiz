//
//  Score1ViewController.swift
//  4Quiz
//
//  Created by はやてどん on 2024/01/11.
//

import UIKit
import AVFoundation

class Score1ViewController: UIViewController {
    
    var soundEffectPlayer: AVAudioPlayer?
    
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var ScoreMessage: UILabel!
    @IBOutlet var AnswerText: UILabel!
    
    var correct = 0

    override func viewDidLoad() {
        super.viewDidLoad()
       
        updateScoreMessage()
        updateScoreLabel()
        playSoundEffectForScore()
        // Do any additional setup after loading the view.
    }
    
    
    func updateScoreMessage() {
        var scoreMessage: String = "" // スコアに応じたメッセージを格納する変数

        switch correct {
        case 1...3:
            scoreMessage = "全然ダメです！"
        case 4...7:
            scoreMessage = "もう少し頑張りましょう！"
        case 8...9:
            scoreMessage = "いい感じですね！"
        case 10:
            scoreMessage = "満点！素晴らしい！！"
        default:
            scoreMessage = "え...逆に凄い..."
        }

        // これをラベルなどに表示する場合、該当する UI 要素が必要です。
        // 例えば、scoreLabel が UILabel だと仮定しています。
        // あなたの実際の UI 要素に合わせて変更してください。
        ScoreMessage.text = scoreMessage
    }
    
    func updateScoreLabel() {
            scoreLabel.text = "10問中\(correct)問正解！"
        }
    
    func playSoundEffectForScore() {
            var soundEffectName: String

            switch correct {
            case 1...3:
                soundEffectName = "dame"
            case 4...7:
                soundEffectName = "iine"
            case 8...9:
                soundEffectName = "maamaa"
            case 10:
                soundEffectName = "manntenn"
            default:
                soundEffectName = "zako"
            }

            if !soundEffectName.isEmpty {
                playSoundEffect(name: soundEffectName)
            }
        }
    
    
    
    @IBAction func toTopButtonAction(_ sender: Any) {
        playSoundEffect(name: "SE")
        self.presentingViewController?.presentingViewController?.dismiss(animated: true)
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
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override var shouldAutorotate: Bool {
        return false
    }
    
//    問題の最初に戻りたい(未実装)
//    @IBAction func toProblemAction(_ sender: Any) {
//        
//        self.presentingViewController?.dismiss(animated: true)
//    }
    
    /*  
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

