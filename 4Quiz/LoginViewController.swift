//
//  LoginViewController.swift
//  4択クイズ！
//
//  Created by はやてどん on 2024/01/15.
//

import UIKit
import AVFoundation


class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var soundEffectPlayer:AVAudioPlayer?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
    
    @IBAction func toLoginButton(_ sender: Any) {
        
        playSoundEffect(name: "SE")
    }
    @IBAction func toNewRegistrationButton(_ sender: Any) {
        
        playSoundEffect(name: "SE")
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
