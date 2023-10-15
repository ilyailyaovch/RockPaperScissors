import Foundation
import UIKit

class CardView: UIButton {

    var index: Int = 0

    override init(frame: CGRect){
        super.init(frame: frame)
        setupCard()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupCard() {
        setTitleColor(.white, for: .normal)
        backgroundColor = .lightGray.withAlphaComponent(0.1)
        titleLabel?.font = UIFont(name: "HelveticaNeue", size: 28)
        layer.cornerRadius = 10
    }

}
