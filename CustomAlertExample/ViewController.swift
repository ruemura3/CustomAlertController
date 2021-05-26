//
//  ViewController.swift
//  CustomAlertExample
//
//  Created by Ryo UEMURA on 2021/05/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // タイトル、メッセージ、OKボタン
    // デフォルト
    @IBAction func defaultAlert1(_ sender: Any) {
        let alert = UIAlertController(title: "タイトル", message: "メッセージ", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: {_ in
            print("OK")
        })
        alert.addAction(action)
        present(alert, animated: true)
    }
    // カスタム
    @IBAction func customAlert1(_ sender: Any) {
        let alert = CustomAlertController(title: "タイトル", message: "メッセージ", preferredStyle: .alert)
        let action = CustomAlertAction(title: "OK", style: .default, handler: {_ in
            print("OK")
        })
        alert.addAction(action)
        alert.modalPresentationStyle = .overFullScreen
        alert.modalTransitionStyle = .crossDissolve
        present(alert, animated: true)
    }
    
    // 長いメッセージ、OKボタン、キャンセルボタン
    // デフォルト
    @IBAction func defaultAlert2(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: "メッセージ", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {_ in
            print("OK")
        })
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: {_ in
            print("キャンセル")
        })
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    // カスタム
    @IBAction func customAlert2(_ sender: Any) {
        let alert = CustomAlertController(title: nil, message: "メッセージ", preferredStyle: .alert)
        let okAction = CustomAlertAction(title: "OK", style: .default, handler: {_ in
            print("OK")
        })
        let cancelAction = CustomAlertAction(title: "キャンセル", style: .cancel, handler: {_ in
            print("キャンセル")
        })
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        alert.modalPresentationStyle = .overFullScreen
        alert.modalTransitionStyle = .crossDissolve
        present(alert, animated: true)
    }
    
    // タイトル、OKボタン、削除ボタン、キャンセルボタン
    // デフォルト
    @IBAction func defaultAlert3(_ sender: Any) {
        let alert = UIAlertController(title: "タイトル", message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {_ in
            print("OK")
        })
        let destructiveAction = UIAlertAction(title: "削除", style: .destructive, handler: {_ in
            print("削除")
        })
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: {_ in
            print("キャンセル")
        })
        alert.addAction(okAction)
        alert.addAction(destructiveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    // カスタム
    @IBAction func customAlert3(_ sender: Any) {
        let alert = CustomAlertController(title: "タイトル", message: nil, preferredStyle: .alert)
        let okAction = CustomAlertAction(title: "OK", style: .default, handler: {_ in
            print("OK")
        })
        let destructiveAction = CustomAlertAction(title: "削除", style: .destructive, handler: {_ in
            print("削除")
        })
        let cancelAction = CustomAlertAction(title: "キャンセル", style: .cancel, handler: {_ in
            print("キャンセル")
        })
        alert.addAction(okAction)
        alert.addAction(destructiveAction)
        alert.addAction(cancelAction)
        alert.modalPresentationStyle = .overFullScreen
        alert.modalTransitionStyle = .crossDissolve
        present(alert, animated: true)
    }
    
    // 長いタイトル、長いメッセージ
    // デフォルト
    @IBAction func defaultAlert4(_ sender: Any) {
        let alert = UIAlertController(title: "長いタイトル長いタイトル長いタイトル", message: "長いメッセージ長いメッセージ長いメッセージ長いメッセージ長いメッセージ長いメッセージ長いメッセージ長いメッセージ", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: {_ in })
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    // カスタム
    @IBAction func customAlert4(_ sender: Any) {
        let alert = CustomAlertController(title: "長いタイトル長いタイトル長いタイトル", message: "長いメッセージ長いメッセージ長いメッセージ長いメッセージ長いメッセージ長いメッセージ長いメッセージ長いメッセージ", preferredStyle: .alert)
        let cancelAction = CustomAlertAction(title: "キャンセル", style: .cancel, handler: {_ in })
        alert.addAction(cancelAction)
        alert.modalPresentationStyle = .overFullScreen
        alert.modalTransitionStyle = .crossDissolve
        present(alert, animated: true)
    }
}
