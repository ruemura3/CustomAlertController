# CustomAlertController

## 概要
SwiftデフォルトのUIAlertControlerとほぼ同じように使えるCustomAlertControllerです。

## 使い方
最も詳しい使い方は作者ブログを御覧ください[準備中](https://ruemura3.com)  


- すべてがCustomAlertControllerに記述されていますので、CustomAlertController.swiftを自分のプロジェクトに追加していただき、以下のように使用することができます。
- CustomAlertController.swift上部の定数をいじることでアラートの見た目を変えられます。

### SwiftデフォルトのUIAlertControllerの使い方
```
// アラートコントローラの作成
let alert = UIAlertController(title: "タイトル", message: "メッセージ", preferredStyle: .alert)

// アラートアクションの作成
let action = UIAlertAction(title: "OK", style: .default, handler: {_ in
    print("キャンセル")
})

// アラートにアクションを追加
alert.addAction(action)

// 表示
present(alert, animated: true)
```

### CustomAlertControllerの使い方
- UIAlertControllerをCustomAlertControllerに変更
- presentの前にmodalPresentationStyleとmodalTransitionStyleを設定
```
// カスタムアラートコントローラの作成
let alert = CustomAlertController(title: "タイトル", message: "メッセージ", preferredStyle: .alert)

// カスタムアラートアクションの作成
let action = CustomAlertAction(title: "OK", style: .default, handler: {_ in
    print("キャンセル")
})

// アラートにアクションを追加
alert.addAction(action)

// modalPresentationStyleを.overFullScreenに設定
alert.modalPresentationStyle = .overFullScreen

// modalTransitionStyleを.crossDissolveに設定
alert.modalTransitionStyle = .crossDissolve

// 表示
present(alert, animated: true)
```

## 注意
- UIAlertControllerのstyleには.alertと.actionSheetがありますが、現段階では.actionSheetには未対応です。
- アクションを追加（addAction()）した順にボタンが上から表示されます。
- ボタンの数は現段階では3つまでです。

## 利用について
利用、改造についていかなる場合もOKです。  
お役に立てましたらぜひTwitterまで
[@ruemura3](http://twitter.com/ruemura3)