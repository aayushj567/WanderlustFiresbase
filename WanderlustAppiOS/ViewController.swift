//
//  ViewController.swift
//  WanderlustAppiOS
//
//  Created by Aayush Jaiswal on 3/22/24.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    // an authentication state change listener used to track whether any user is signed in
    var handleAuth: AuthStateDidChangeListenerHandle?
    // variable to keep an instance of the current signed-in Firebase user
    var currentUser:FirebaseAuth.User?

    let loginScreen = LoginView()
    override func loadView() {
        view = loginScreen
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //MARK: handling if the Authentication state is changed (sign in, sign out, register)...
        handleAuth = Auth.auth().addStateDidChangeListener{ auth, user in
            if user == nil{
                //self.showAlert(message: "Please sign in to continue")
                
            }else{
                //MARK: the user is signed in...
                self.onLoginTapped()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
        loginScreen.buttonLogin.addTarget(self, action: #selector(onLoginTapped), for: .touchUpInside)
        loginScreen.buttonRegister.addTarget(self, action: #selector(onRegistrationTapped), for: .touchUpInside)
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handleAuth!)
    }
    
    @objc func onLoginTapped(){
       
//        guard let emailText = loginScreen.textFieldEmail.text, !emailText.isEmpty,
//              let passwordText = loginScreen.textFieldPassword.text, !passwordText.isEmpty
//        else {
//            showAlert(message: "Please fill out all required fields.")
//            return
//        }
//        
//        guard isValidEmail(emailText) else {
//            showAlert(message: "Invalid email. Please enter a valid email address.")
//            return
//        }
        
        //let user = User(id:"", name: "", email: emailText, password: passwordText)
        
        //loginExistingUser(user:user)
        //let mainScreen = NoteViewController()
        //navigationController?.pushViewController(mainScreen, animated: true)
        let mainScreen = CalendarViewController()
//        // hide the navigation bar
//        navigationController?.setNavigationBarHidden(true, animated: true)
        navigationController?.pushViewController(mainScreen, animated: true)
        
    }
    
    @objc func onRegistrationTapped(){
       
        let registrationScreen = RegistrationViewController()
        //Setting up the contact object of display screen.
        //Instead of sending the variables used a struct named Contact to send the details.
        
        navigationController?.pushViewController(registrationScreen, animated: true)
    }

    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}


