//
//  CustomAlertController.swift
//  CustomAlertExample
//
//  Created by Ryo UEMURA on 2021/05/24.
//

import UIKit

// スクリーンの幅と高さ
let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

/* ↓ ポップアップの設定はここをいじる ↓ */
// アラート背景の色
let BACKGROUND_COLOR = UIColor.label.withAlphaComponent(0.3)
// アラートの幅
let ALERT_VIEW_WIDTH = 0.85 * SCREEN_WIDTH
// アラートの色
let ALERT_VIEW_COLOR = UIColor.systemBackground
// アラートビューの角丸（0だと丸くならない）
let ALERT_VIEW_CORNER_RADIUS = CGFloat(10.0)
// ラベルの幅
let LABEL_WIDTH = 0.9 * ALERT_VIEW_WIDTH
// ラベルのX軸位置
let LABEL_X = (ALERT_VIEW_WIDTH - LABEL_WIDTH) / 2
// アラートタイトルのフォントサイズ
let ALERT_TITLE_FONT_SIZE = CGFloat(25.0)
// アラートタイトルの文字色
let ALERT_TITLE_COLOR = UIColor.label
// アラートメッセージのフォントサイズ
let ALERT_MESSAGE_FONT_SIZE = CGFloat(20.0)
// アラートメッセージの文字色
let ALERT_MESSAGE_COLOR = UIColor.label
// ボタンのフォントサイズ
let BUTTON_FONT_SIZE = CGFloat(21.0)
// ボタンの高さ
let BUTTON_HEIGHT = 2.5 * BUTTON_FONT_SIZE
// ボタンの幅
let BUTTON_WIDTH = 0.85 * ALERT_VIEW_WIDTH
// ボタンのX軸位置
let BUTTON_X = (ALERT_VIEW_WIDTH - BUTTON_WIDTH) / 2
// ボタンの枠線の太さ
let BUTTON_BORDER_WIDTH = CGFloat(2.0)
// ボタンの角丸（0だと丸くならない）
let BUTTON_CONER_RADIUS = CGFloat(5.0)
// デフォルトボタンの色
let DEFAULT_BUTTON_COLOR = UIColor(red: 105/255, green: 189/255, blue: 131/255, alpha: 1)
// デフォルトボタンのボーダー色
let DEFAULT_BUTTON_BORDER_COLOR = DEFAULT_BUTTON_COLOR.cgColor
// デフォルトボタンの文字色
let DEFAULT_BUTTON_TITLE_COLOR = UIColor.white
// キャンセルボタンの色
let CANCEL_BUTTON_COLOR = ALERT_VIEW_COLOR
// キャンセルボタンのボーダー色
let CANCEL_BUTTON_BORDER_COLOR = UIColor.systemGray5.cgColor
// キャンセルボタンの文字色
let CANCEL_BUTTON_TITLE_COLOR = UIColor.label
// デストラクティブボタンの色
let DESTRUCTIVE_BUTTON_COLOR = UIColor(red: 189/255, green: 106/255, blue: 162/255, alpha: 1)
// デストラクティブボタンのボーダー色
let DESTRUCTIVE_BUTTON_BORDER_COLOR = DESTRUCTIVE_BUTTON_COLOR.cgColor
// デストラクティブボタンの文字色
let DESTRUCTIVE_BUTTON_TITLE_COLOR = UIColor.white
// 各パーツの間隔
let INTERVAL = 0.022 * SCREEN_HEIGHT
/* ↑ ポップアップの設定はここをいじる ↑ */

/// カスタムアラートアクションの種類
enum CustomAlertControllerAction {
    case cancel
    case `default`
    case destructive
}

/// カスタムアラートアクションクラス
class CustomAlertAction : NSObject {
    /// タイトル
    var title:String
    /// スタイル
    var style:CustomAlertControllerAction
    /// ハンドラ
    var handler: ((_ action: CustomAlertAction)->())?
    
    /// 初期化
    init(title: String, style: CustomAlertControllerAction, handler: ((_ action: CustomAlertAction) -> ())?){
        self.title = title
        self.style = style
        self.handler = handler
    }
}

/// カスタムアラートコントローラの種類（.actionSheetは現段階では非対応）
enum CustomAlertControlerStyle {
    case alert
}

/// カスタムアラートコントローラクラス
class CustomAlertController: UIViewController, UIViewControllerTransitioningDelegate {
    /// アラートタイトル
    var alertTitle: String?
    
    /// アラートメッセージ
    var alertMessage: String?
    
    /// 初期化
    internal convenience init(title: String?, message: String?, preferredStyle: CustomAlertControlerStyle) {
        self.init()
        self.alertTitle = title
        self.alertMessage = message
    }
    
    // タイトルラベル
    var titleLabel = UILabel()
    
    // メッセージラベル
    var messageLabel = UILabel()
    
    // アラート背景
    var alertBackground = UIView()
    
    /// アラートビュー
    var alertView = UIView()
    
    /// 1つ目のボタン
    var firstButton = UIButton()
    
    /// 2つ目のボタン
    var secondButton = UIButton()
    
    /// 3つ目のボタン
    var thirdButton = UIButton()
    
    /// アクション格納配列
    var actions = [CustomAlertAction]()
    
    /// アクション追加
    func addAction(_ action:CustomAlertAction){
        // 現段階ではアクションは3つまで追加可能
        if actions.count >= 3 {
            abort()
        }
        actions.append(action)
    }
    
    /// 1つ目のボタンタップ時挙動
    @objc private func firstButtonTapped() {
        dismiss(animated: true, completion: {
            let action = self.actions[0]
            if let handler = action.handler{
                handler(action)
            }
        })
    }
    
    /// 2つ目のボタンタップ時挙動
    @objc private func secondButtonTapped() {
        dismiss(animated: true, completion: {
            let action = self.actions[1]
            if let handler = action.handler{
                handler(action)
            }
        })
    }
    
    /// 3つ目のボタンタップ時挙動
    @objc private func thirdButtonTapped() {
        dismiss(animated: true, completion: {
            let action = self.actions[2]
            if let handler = action.handler{
                handler(action)
            }
        })
    }
    
    /// ビューが読み込まれたときに呼ばれる処理
    override func viewDidLoad() {
        // 自身でサイズを決めているためリサイズを切る
        alertView.autoresizesSubviews = false
    }
    
    /// サブビューをレイアウトした際に呼ばれる処理
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        _ = initViewLayout
    }
    
    /// viewDidLayoutSubview()は複数回呼び出されるため最初の1度だけ呼び出されるようにlazyを利用
    private lazy var initViewLayout : Void = {
        setUIParts()
    }()
    
    /// UI部品をセットする
    private func setUIParts() {
        // 現在のY軸位置（作業用）
        var tmpY = 2 * INTERVAL
        
        // タイトル文言がある場合はタイトルラベルを作成
        if self.alertTitle != nil {
            // タイトルラベルの作成
            setUpTitle(tmpY: tmpY)
            // tmpYの更新
            tmpY += titleLabel.frame.size.height + INTERVAL
        }
        
        // メッセージ文言がある場合はメッセージラベルを作成
        if self.alertMessage != nil {
            // メッセージラベルの作成
            setUpMessage(tmpY: tmpY)
            // tmpYの更新
            tmpY += messageLabel.frame.size.height + INTERVAL
        }
        
        // 1つ目のアクションがある場合は1つ目のボタンを作成
        if actions.count >= 1 {
            // 1つ目のボタンの作成
            setUpButtons(button: firstButton, action: actions[0], tmpY: tmpY)
            // tmpYの更新
            tmpY += BUTTON_HEIGHT + INTERVAL
            
            // 2つ目のアクションがある場合は2つ目のボタンを作成
            if actions.count >= 2 {
                // 2つ目のボタンの作成
                setUpButtons(button: secondButton, action: actions[1], tmpY: tmpY)
                // tmpYの更新
                tmpY += BUTTON_HEIGHT + INTERVAL
                
                // 3つ目のアクションがある場合は3つ目のボタンを作成
                if actions.count >= 3 {
                    // 3つ目のボタンの作成
                    setUpButtons(button: thirdButton, action: actions[2], tmpY: tmpY)
                    // tmpYの更新
                    tmpY += BUTTON_HEIGHT + INTERVAL
                }
            }
        }
        
        // アラートビューの作成
        setUpAlertView(tmpY: tmpY)
        
        // アラート背景に追加
        alertBackground.backgroundColor = BACKGROUND_COLOR
        alertBackground.addSubview(alertView)
        
        self.view = alertBackground
    }
    
    /// アラートタイトルを作成する
    private func setUpTitle(tmpY: CGFloat) {
        titleLabel.numberOfLines = 0
        titleLabel.text = alertTitle
        titleLabel.textColor = ALERT_TITLE_COLOR
        titleLabel.font = UIFont.boldSystemFont(ofSize: ALERT_TITLE_FONT_SIZE)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.frame = CGRect(x: LABEL_X, y: tmpY, width: LABEL_WIDTH, height: 0)
        titleLabel.sizeToFit()
        titleLabel.center = CGPoint(x: ALERT_VIEW_WIDTH/2, y: titleLabel.center.y)
    }
    
    /// アラートメッセージを作成する
    private func setUpMessage(tmpY: CGFloat) {
        messageLabel.numberOfLines = 0
        messageLabel.text = alertMessage
        messageLabel.textColor = ALERT_MESSAGE_COLOR
        messageLabel.font = UIFont.systemFont(ofSize: ALERT_MESSAGE_FONT_SIZE)
        messageLabel.textAlignment = NSTextAlignment.center
        messageLabel.frame = CGRect(x: LABEL_X, y: tmpY, width: LABEL_WIDTH, height: 0)
        messageLabel.sizeToFit()
        messageLabel.center = CGPoint(x: ALERT_VIEW_WIDTH/2, y: messageLabel.center.y)
    }
    
    /// アラートボタンを作成する
    private func setUpButtons(button: UIButton, action: CustomAlertAction, tmpY: CGFloat) {
        button.setTitle(action.title, for: .normal)
        switch action.style {
        case .default:
            button.backgroundColor = DEFAULT_BUTTON_COLOR
            button.setTitleColor(DEFAULT_BUTTON_TITLE_COLOR, for: .normal)
            button.layer.borderWidth = BUTTON_BORDER_WIDTH
            button.layer.borderColor = DEFAULT_BUTTON_BORDER_COLOR
        case .cancel:
            button.backgroundColor = CANCEL_BUTTON_COLOR
            button.setTitleColor(CANCEL_BUTTON_TITLE_COLOR, for: .normal)
            button.layer.borderWidth = BUTTON_BORDER_WIDTH
            button.layer.borderColor = CANCEL_BUTTON_BORDER_COLOR
        case .destructive:
            button.backgroundColor = DESTRUCTIVE_BUTTON_COLOR
            button.setTitleColor(DESTRUCTIVE_BUTTON_TITLE_COLOR, for: .normal)
            button.layer.borderWidth = BUTTON_BORDER_WIDTH
            button.layer.borderColor = DESTRUCTIVE_BUTTON_BORDER_COLOR
        }
        button.titleLabel?.font = UIFont.systemFont(ofSize: BUTTON_FONT_SIZE)
        button.layer.cornerRadius = BUTTON_CONER_RADIUS
        button.frame = CGRect(x: BUTTON_X, y: tmpY, width: BUTTON_WIDTH, height: BUTTON_HEIGHT)
        button.addTarget(self, action: getSelector(button: button)!, for: .touchUpInside)
    }
    
    /// アラートビューを作成する
    private func setUpAlertView(tmpY: CGFloat) {
        alertView.backgroundColor = ALERT_VIEW_COLOR
        alertView.layer.cornerRadius = ALERT_VIEW_CORNER_RADIUS
        alertView.frame.size = CGSize(width: ALERT_VIEW_WIDTH, height: tmpY)
        alertView.center = CGPoint(x: SCREEN_WIDTH/2, y: SCREEN_HEIGHT/2)
        // アラートビューに各パーツを追加
        alertView.addSubview(titleLabel)
        alertView.addSubview(messageLabel)
        if actions.count >= 1 {
            alertView.addSubview(firstButton)
            if actions.count >= 2 {
                alertView.addSubview(secondButton)
                if actions.count >= 3 {
                    alertView.addSubview(thirdButton)
                }
            }
        }
    }
    
    /// ボタンのセレクタを取得する
    private func getSelector(button: UIButton) -> Selector? {
        switch button {
        case firstButton:
            return #selector(firstButtonTapped)
        case secondButton:
            return #selector(secondButtonTapped)
        case thirdButton:
            return #selector(thirdButtonTapped)
        default:
            return nil
        }
    }
}
