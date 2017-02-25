//
//  LoginViewController.swift
//  syousetutoukou kairyou
//
//  Created by リボルバー　オセロット on 2017/02/11.
//  Copyright © 2017年 ocelot. All rights reserved.
//
import UIKit
import Firebase //Firebaseをインポート


class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var emailTextField: UITextField! // Emailを打つためのTextField
    
    @IBOutlet var passwordTextField: UITextField! //Passwordを打つためのTextField
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self //デリゲートをセット
        passwordTextField.delegate = self //デリゲートをセット
        passwordTextField.isSecureTextEntry  = true // 文字を非表示に
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //ログインボタン
    @IBAction func didRegisterUser() {
        //ログインのためのメソッド
        login()
    }
    //Returnキーを押すと、キーボードを隠す
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //ログイン完了後に、ListViewControllerへの遷移のためのメソッド
    func transitionToView()  {
        self.performSegue(withIdentifier: "toVC", sender: self)
    }
    
    //ログインのためのメソッド
    func login() {
        //EmailとPasswordのTextFieldに文字がなければ、その後の処理をしない
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        //signInWithEmailでログイン
        //第一引数にEmail、第二引数にパスワードを取ります
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            //エラーがないことを確認
            if error == nil {
                if let loginUser = user {
                    // バリデーションが完了しているか確認。完了ならそのままログイン
                    if self.checkUserValidate(user: loginUser) {
                        // 完了済みなら、ListViewControllerに遷移
                        print(FIRAuth.auth()?.currentUser)
                        self.transitionToView()
                    }else {
                        // 完了していない場合は、アラートを表示
                        self.presentValidateAlert()
                    }
                }
            }else {
                print("error...\(error?.localizedDescription)")
            }
        })
    }
    
    // ログインした際に、バリデーションが完了しているか返す
    func checkUserValidate(user: FIRUser)  -> Bool {
        return user.isEmailVerified
    }
    // メールのバリデーションが完了していない場合のアラートを表示
    func presentValidateAlert() {
        let alert = UIAlertController(title: "メール認証", message: "メール認証を行ってください", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    /*
     //ログインのためのメソッド
     func login() {
     //EmailとPasswordのTextFieldに文字がなければ、その後の処理をしない
     guard let email = emailTextField.text else { return }
     guard let password = passwordTextField.text else { return }
     
     //signInWithEmailでログイン
     //第一引数にEmail、第二引数にパスワードを取ります
     FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
     //エラーがないことを確認
     if error == nil {
     if user != nil {
     self.transitionToView()
     }
     }else {
     print("error...\(error?.localizedDescription)")}}
     
     )
     }
     */
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
