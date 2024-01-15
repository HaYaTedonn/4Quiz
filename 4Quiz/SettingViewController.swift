//
//  SettingViewController.swift
//  4Quiz
//
//  Created by はやてどん on 2024/01/11.
//

import UIKit
import AVFoundation

class SettingViewController: UIViewController {
    
    let musicPath = Bundle.main.bundleURL.appendingPathComponent("freebgm.mp3")
    var musicPlayer: AVAudioPlayer?
    var soundEffectPlayer:AVAudioPlayer?
    
    
    @IBOutlet var bgmSwitch: UISwitch!
    
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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UISwitchの初期状態をUserDefaultsから読み込み
                let bgmEnabled = UserDefaults.standard.bool(forKey: "bgmEnabled")
                bgmSwitch.isOn = bgmEnabled
    }
    

    
    @IBAction func toTopButtonAction(_ sender: Any) {
        playSoundEffect(name: "SE")
        self.presentingViewController?.dismiss(animated: true)
    }
    
    
    @IBAction func toSwitchButton(_ sender: UISwitch) {
        
        // UISwitchの状態をUserDefaultsに保存
                UserDefaults.standard.set(sender.isOn, forKey: "bgmEnabled")
                UserDefaults.standard.synchronize()
        
        
    }
    @IBAction func toSwitch1Button(_ sender: UISwitch) {
        
        
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
