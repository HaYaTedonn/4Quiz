//
//  NewRegistrationViewController.swift
//  4択クイズ！
//  新規登録画面
//  Created by はやてどん on 2024/01/15.
//

import UIKit
import AVFoundation
import CoreData

class NewRegistrationViewController: UIViewController {
    
    var soundEffectPlayer:AVAudioPlayer?
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

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
    
    //登録するボタン
    @IBAction func toRegistrationButton(_ sender: Any) {
        playSoundEffect(name: "SE")
        saveUserData()
    }
    
    // Core Dataにユーザー情報を保存するメソッド
        func saveUserData() {
            guard let username = usernameTextField.text, let password = passwordTextField.text else {
                return
            }

            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }

            let managedContext = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)!
            let user = NSManagedObject(entity: entity, insertInto: managedContext)

            user.setValue(username, forKey: "username")
            user.setValue(password, forKey: "password")

            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
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
