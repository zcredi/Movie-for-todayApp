import UIKit

class VisualBlurEffect: UIVisualEffectView {
    init(style: UIBlurEffect.Style = .light) {
        let effect = UIBlurEffect(style: style)
        super.init(effect: effect)
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
