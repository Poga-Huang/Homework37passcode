//
//  ViewController.swift
//  Homework37passcode
//
//  Created by 黃柏嘉 on 2021/12/9.
//

import UIKit
enum RestartMode{
    case all
    case part
}

class ViewController: UIViewController {
    
    @IBOutlet weak var stateImage: UIImageView!
    @IBOutlet weak var passwordImage0: UIImageView!
    @IBOutlet weak var passwordImage1: UIImageView!
    @IBOutlet weak var passwordImage2: UIImageView!
    @IBOutlet weak var passwordImage3: UIImageView!
    @IBOutlet var passwordImageArray: [UIImageView]!
    
    var currentPasswordCount = 0
    var wrong = 0
    var password = "1020"
    var input = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    //輸入密碼
    @IBAction func inputPassword(_ sender: UIButton) {
        //輸入show出圖片
        if currentPasswordCount >= 0 && currentPasswordCount < 4{
            currentPasswordCount += 1
            showPasswordImage(currentCount: currentPasswordCount)
        }else if currentPasswordCount == 4{
            showPasswordImage(currentCount: currentPasswordCount)
        }
        //增加密碼及辨別密碼
        if input.count < 4{
            input.append(contentsOf: sender.currentTitle!)
        }
        if input.count == 4{
            //辨認密碼
            if input == password{
                //登入成功
                stateImage.image = UIImage(named: "LogInImage")
                alert(title: "登入成功", message: "嗨你好", result: true)
            }else{
                //登入失敗
                if wrong < 5{
                    wrong += 1
                    showStateImage(wrong: wrong)
                    alert(title: "登入失敗", message: "剩餘次數\(5-wrong)", result: false)
                }
            }
        }
    }
    //警示器
    func alert(title:String,message:String,result:Bool){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "Close", style: .default) { closeAction in
            alert.dismiss(animated: true, completion: nil)
            if result == true{
                self.restart(mode: .all)
            }else{
                if self.wrong == 5{
                    self.restart(mode: .all)
                }else{
                    self.restart(mode: .part)
                }
            }
        }
        alert.addAction(closeAction)
        present(alert, animated: true, completion: nil)
    }
    //刪除密碼
    @IBAction func deletePassword(_ sender: UIButton) {
        if currentPasswordCount > 0{
            currentPasswordCount -= 1
            showPasswordImage(currentCount: currentPasswordCount)
            input.removeLast()
        }
    }
    //清除全部
    @IBAction func clearAll(_ sender: UIButton) {
        restart(mode: .all)
    }
    //按下密碼顯示圖片
    func showPasswordImage(currentCount:Int){
        for i in 0..<currentCount{
            passwordImageArray[i].image = UIImage(named: "passwordImage\(i)")
        }
        if currentCount < 4{
            for i in currentCount...3{
                passwordImageArray[i].image = UIImage(named: "passwordBackImage\(i)")
            }
        }
    }
    //狀態圖片
    func showStateImage(wrong:Int){
        switch wrong{
        case 0:
            stateImage.image = UIImage(named: "initView")
        case 1:
            stateImage.image = UIImage(named: "wrongPassword0")
        case 2:
            stateImage.image = UIImage(named: "wrongPassword1")
        case 3:
            stateImage.image = UIImage(named: "wrongPassword2")
        case 4:
            stateImage.image = UIImage(named: "wrongPassword3")
        case 5:
            stateImage.image = UIImage(named: "wrongPassword4")
        default:
            return
        }
    }
    
    //重設
    func restart(mode:RestartMode){
        if mode == .all{
            input = ""
            currentPasswordCount = 0
            showPasswordImage(currentCount: currentPasswordCount)
            wrong = 0
            showStateImage(wrong: wrong)
        }else if mode == .part{
            input = ""
            currentPasswordCount = 0
            showPasswordImage(currentCount: currentPasswordCount)
        }
    }
}

