//
//  ViewController.swift
//  4Quiz
//ここも変えた
//  Created by はやてどん on 2024/01/11.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    @IBOutlet var CreatorName: UILabel!
    var soundEffectPlayer:AVAudioPlayer?
    var musicPlayer: AVAudioPlayer?

    override func viewDidLoad() {
            super.viewDidLoad()
        // 例えばボタンをタップした時に効果音を再生する場合
                let button = UIButton(type: .system)
                button.setTitle("Tap me", for: .normal)
                button.addTarget(self, action: #selector(toSettingButtonAction), for: .touchUpInside)
                view.addSubview(button)
                button.center = view.center
        
        // BGMを再生
                playBGM()
        }
    
    func playBGM() {
            guard let bgmURL = Bundle.main.url(forResource: "freebgm", withExtension: "mp3") else {
                print("BGMファイルが見つかりません")
                return
            }

            do {
                musicPlayer = try AVAudioPlayer(contentsOf: bgmURL)
                musicPlayer?.numberOfLoops = -1  // 無限ループ
                musicPlayer?.play()
            } catch {
                print("BGMの再生に失敗しました: \(error.localizedDescription)")
            }
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
    
    

    @IBAction func toSettingButtonAction(_ sender: Any) {
        
        playSoundEffect(name: "SE")
    }
    
   
    @IBAction func toTagButtonAction(_ sender: Any) {
        
        playSoundEffect(name: "SE")
    }
    @IBAction func toCssButtonAction(_ sender: Any) {
        
        playSoundEffect(name: "SE")
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override var shouldAutorotate: Bool {
        return false
    }
}

