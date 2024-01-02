import UIKit

extension UIButton {
    convenience init(title: String, font: UIFont?, titleColor: UIColor?) {
        self.init(type: .system)
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.titleLabel?.font = font
    }
}
