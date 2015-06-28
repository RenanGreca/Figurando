//
//  LoginViewController.swift
//  Psico-Kids
//
//  Created by Matheus Cassarotti on 6/28/15.
//  Copyright (c) 2015 br.pucpr.bepid. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import LocalAuthentication

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var createInfoLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var touchIDButton: UIButton!

    var managedObjectContext: NSManagedObjectContext? = nil
    let MyKeychainWrapper = KeychainWrapper()
    let createLoginButtonTag = 0
    let loginButtonTag = 1
    var error : NSError?
    var context = LAContext()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Checa se já tem login salvo
        
        let hasLogin = NSUserDefaults.standardUserDefaults().boolForKey("hasLoginKey")
        
        // Muda as labels adequadamente se já tiver login ou for criar
        if hasLogin {
            loginButton.setTitle("Acesso", forState: UIControlState.Normal)
            loginButton.tag = loginButtonTag
            createInfoLabel.hidden = true
        } else {
            loginButton.setTitle("Criar", forState: UIControlState.Normal)
            loginButton.tag = createLoginButtonTag
            createInfoLabel.hidden = false
        }
        
        // Se já tem login, deixa o username já no Text Field por conveniência
        if let storedUsername = NSUserDefaults.standardUserDefaults().valueForKey("username") as? String {
            usernameTextField.text = storedUsername as String
        }
        
        touchIDButton.hidden = true
        
        if context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &error) {
            touchIDButton.hidden = false
        }
        
    }
    
    
    @IBAction func loginAction(sender: AnyObject) {
        
        // Se os campos estiverem em branco, aparece um alerta
        if (usernameTextField.text == "" || passwordTextField.text == "") {
            var alert = UIAlertView()
            alert.title = "Digite um usuário e senha válidos!"
            alert.addButtonWithTitle("Oops!")
            alert.show()
            return;
        }
        
        // Dismiss no Keyboard
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        // Modo de criação de keychain
        if sender.tag == createLoginButtonTag {
            
            // Testa se já não tem usuário salvo, senão salva o que está no text field no keychain
            let hasLoginKey = NSUserDefaults.standardUserDefaults().boolForKey("hasLoginKey")
            if hasLoginKey == false {
                NSUserDefaults.standardUserDefaults().setValue(self.usernameTextField.text, forKey: "username")
            }
            
            // Salva o keychain de forma persistente, muda para modo de login pois já existe cadastro!
            MyKeychainWrapper.mySetObject(passwordTextField.text, forKey:kSecValueData)
            MyKeychainWrapper.writeToKeychain()
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "hasLoginKey")
            NSUserDefaults.standardUserDefaults().synchronize()
            loginButton.tag = loginButtonTag
            
            /* ARRUMAR --->>>>>
            let kidProfile: KidProfileViewController = storyboard!.instantiateViewControllerWithIdentifier("KidProfile") as! KidProfileViewController
            self.presentViewController(kidProfile, animated: true, completion: nil) */
            var alert = UIAlertView()
            alert.title = "Sucesso"
            alert.message = "Funcionando"
            alert.addButtonWithTitle("OK")
            alert.show()
            
        } else if sender.tag == loginButtonTag {
            
            //Verifica se as credenciais digitadas batem com as salvas no keychain
            if checkLogin(usernameTextField.text, password: passwordTextField.text) {
                /* ARRUMAR --->>>>>
                let kidProfile: KidProfileViewController = storyboard!.instantiateViewControllerWithIdentifier("KidProfile") as! KidProfileViewController
                self.presentViewController(kidProfile, animated: true, completion: nil) */
                var alert = UIAlertView()
                alert.title = "Sucesso"
                alert.message = "Funcionando"
                alert.addButtonWithTitle("OK")
                alert.show()
            } else {
                
                //Se falhar, dá um alert ao usuário
                var alert = UIAlertView()
                alert.title = "Problema no Login"
                alert.message = "Usuário ou senha inválidos."
                alert.addButtonWithTitle("Tentar Novamente")
                alert.show()
            }
        }
    }
    
    @IBAction func touchIDLoginAction(sender: AnyObject) {
        
        //Testa se o dispositivo tem botão TouchID
        if context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &error) {
            
            //Caso tenha TouchID, prepara o usuário para a autenticação biométrica
            context.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: "Logging in with Touch ID",
                reply: { (success: Bool, error: NSError! ) -> Void in
                    
                    // Caso de sucesso
                    dispatch_async(dispatch_get_main_queue(), { if success {
                        /* ARRUMAR --->>>>> 
                        let kidProfile: KidProfileViewController = storyboard!.instantiateViewControllerWithIdentifier("KidProfile") as! KidProfileViewController
                        self.presentViewController(kidProfile, animated: true, completion: nil) */
                        var alert = UIAlertView()
                        alert.title = "Sucesso"
                        alert.message = "Funcionando"
                        alert.addButtonWithTitle("OK")
                        alert.show()
                        }
                        
                        if error != nil {
                            
                            var message: String
                            var showAlert: Bool
                            
                            // Caso de Falha
                            switch(error.code) {
                            case LAError.AuthenticationFailed.rawValue:
                                message = "Houve um problema ao checar suas digitais."
                                showAlert = true
                            case LAError.UserCancel.rawValue:
                                message = "Operação cancelada."
                                showAlert = true
                            case LAError.UserFallback.rawValue:
                                message = "Escolha entre sua senha ou utilizar o TouchID."
                                showAlert = true
                            default:
                                showAlert = true
                                message = "Sua digital não pôde ser configurada. Tente novamente."
                            }
                            
                            var alert = UIAlertView()
                            alert.title = "Erro"
                            alert.message = message
                            alert.addButtonWithTitle("Voltar")
                            if showAlert {
                                alert.show()
                            }
                            
                        }
                    })
                    
            })
        } else {
            // Erro genérico. Importante -> LAErrorTouchIDNotEnrolled = Sem impressões digitais salvas!
            var alert = UIAlertView()
            alert.title = "Erro"
            alert.message = "O TouchID de seu dispositivo não está disponível."
            alert.addButtonWithTitle("Voltar")
            alert.show()
        }

    }
    
    func checkLogin(username: String, password: String ) -> Bool {
        if password == MyKeychainWrapper.myObjectForKey("v_Data") as? String &&
            username == NSUserDefaults.standardUserDefaults().valueForKey("username") as? String {
                return true
        } else {
            return false
        }
    }

    
}
