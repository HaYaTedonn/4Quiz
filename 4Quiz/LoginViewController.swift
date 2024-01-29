//
//  LoginViewController.swift
//  4択クイズ！
//ログイン画面
//  Created by はやてどん on 2024/01/15.
//

import UIKit
import AVFoundation
import CoreData


class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var soundEffectPlayer:AVAudioPlayer?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // テキストフィールドのデリゲートを設定
            usernameTextField.delegate = self
            passwordTextField.delegate = self
    }
    
    // UITextFieldDelegateのメソッド: リターンキーが押されたときに呼ばれる
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            // キーボードを閉じる
            textField.resignFirstResponder()
            return true
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
    
    func authenticateUser() {
            guard let username = usernameTextField.text, let password = passwordTextField.text else {
                return
            }

            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }

            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
            fetchRequest.predicate = NSPredicate(format: "username == %@ AND password == %@", username, password)

        do {
                    let result = try managedContext.fetch(fetchRequest)
                    if result.count > 0 {
                        // 認証成功の処理
                        print("認証成功")
                        performSegue(withIdentifier: "toMainViewController", sender: self)
                        
                        // キーボードを閉じる
                        view.endEditing(true)
                    } else {
                        // 認証失敗の処理
                        print("認証失敗")
                    }
                } catch {
                    print("認証エラー: \(error.localizedDescription)")
                }
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
