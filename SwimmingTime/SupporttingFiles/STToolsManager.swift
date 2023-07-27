//
//  STToolsManager.swift
//  SwimmingTime
//
//  Created by 龚梦洋 on 2023/7/27.
//

import Foundation
import UIKit

class STToolsManager: NSObject {
    static func getWindows() -> [UIWindow] {
        var windows: [UIWindow] = []
        if #available(iOS 15.0, *) {
            windows = UIApplication.shared.connectedScenes.flatMap({ ($0 as? UIWindowScene)?.windows ?? []
            })
        } else {
            windows = UIApplication.shared.windows
        }
        return windows
    }
    
    static func getKeyWindow() -> UIWindow? {
        return STToolsManager.getWindows().filter { window in
            return window.isKeyWindow
        }.first
    }
    
    static func showMessage(_ message: String, vc: UIViewController) {
        let alertView = UIAlertController(title: "", message: message, preferredStyle: .alert)
        vc.present(alertView, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            alertView.dismiss(animated: true)
        }
    }
}
