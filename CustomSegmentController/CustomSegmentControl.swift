//
//  CustomSegmentControl.swift
//
//  Created by Raju Kumar on 18/12/23.
//

import UIKit

class CustomSegmentControl: UIControl {
    var buttons: [UIButton] = []
    var selector: UIView!
    var selectedSegmentIndex = 0
    private var isViewUpdated = false
    
    @IBInspectable
    var border_width: CGFloat = 0 {
        didSet {
            layer.borderWidth = border_width
        }
    }
    
    @IBInspectable
    var border_color: UIColor = .clear {
        didSet {
            layer.borderColor = border_color.cgColor
        }
    }
    
    @IBInspectable
    var commaSeparatedButtonTitles: String = "" {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    var textColor: UIColor = .gray {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    var selectorColor: UIColor = .darkGray {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    var selectorTextColor: UIColor = .white {
        didSet {
            updateView()
        }
    }
    override func layoutSubviews() {
            super.layoutSubviews()

            if !isViewUpdated {
                updateView()
                isViewUpdated = true
            }
        }
 
    func updateView() {
        buttons.removeAll()
        
        subviews.forEach { $0.removeFromSuperview() }
        
        let buttonTitles = commaSeparatedButtonTitles.components(separatedBy: ",")
        
        for buttonTitle in buttonTitles {
            let button = UIButton(type: .system)
            button.setTitle(buttonTitle, for: .normal)
            button.setTitleColor(textColor, for: .normal)
            button.addTarget(self, action: #selector(buttonTapped(button:)), for: .touchUpInside)
            buttons.append(button)
        }
        
        buttons[selectedSegmentIndex].setTitleColor(selectorTextColor, for: .normal)
        
        let selectorWidth = frame.width / CGFloat(buttons.count)
        let selectorStartPosition = frame.width / CGFloat(buttons.count) * CGFloat(selectedSegmentIndex)
        selector = UIView(frame: CGRect(x: selectorStartPosition, y: 0, width: selectorWidth, height: frame.height))
        selector.layer.cornerRadius = frame.height / 2
        selector.layer.masksToBounds = true
        self.setGradientToView()
        addSubview(selector)
        
        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    @objc func buttonTapped(button: UIButton) {
        for (btnIndex, btn) in buttons.enumerated() {
            btn.setTitleColor(textColor, for: .normal)
            
            if btn == button {
                selectedSegmentIndex = btnIndex
                let selectorStartPosition = frame.width / CGFloat(buttons.count) * CGFloat(btnIndex)
                UIView.animate(withDuration: 0.3) {
                    self.selector.frame.origin.x = selectorStartPosition
                    self.selector.frame.size.width = self.frame.width / CGFloat(self.buttons.count)
                    self.selector.layer.cornerRadius = self.frame.height / 2
                    self.setGradientToView()
                }
                btn.setTitleColor(selectorTextColor, for: .normal)
            }
        }
        
        sendActions(for: .valueChanged)
    }
    
    func setGradientToView() {
            let color1 = UIColor(red: 127/255, green: 31/255, blue: 243/255, alpha: 1).cgColor
            let color2 = UIColor(red: 173/255, green: 68/255, blue: 249/255, alpha: 1).cgColor
            selector.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
            selector.addGradientLayer(color1: color1, color2: color2)
        }
    
    override func draw(_ rect: CGRect) {
        layer.cornerRadius = frame.height/2
        clipsToBounds = true
    }

}


extension UIView {
    func addGradientLayer(color1: CGColor, color2: CGColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [color1, color2]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        layer.insertSublayer(gradientLayer, at: 0)
    }
}


class CustomSegmentControl2: UIControl {
    var buttons: [UIButton] = []
    var selector: UIView!
    var selectedSegmentIndex = 0
    private var isViewUpdated = false
    
    @IBInspectable
    var commaSeparatedButtonTitles: String = "" {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
        var fontSize: CGFloat = 12.0 {
            didSet {
                updateView()
            }
        }

        @IBInspectable
        var fontName: String = "Druk Wide Medium" {
            didSet {
                updateView()
            }
        }

        var textFont: UIFont {
            return UIFont(name: fontName, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
        }
    
//    @IBInspectable
//    var textFont: UIFont = .systemFont(ofSize: 12.0) {
//        didSet {
//            updateView()
//        }
//    }
    
    @IBInspectable
    var textColor: UIColor = .gray {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    var selectorColor: UIColor = .darkGray {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    var selectorTextColor: UIColor = .white {
        didSet {
            updateView()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if !isViewUpdated {
            updateView()
            isViewUpdated = true
        }
    }
 
    func updateView() {
        buttons.removeAll()
        
        subviews.forEach { $0.removeFromSuperview() }
        
        let buttonTitles = commaSeparatedButtonTitles.components(separatedBy: ",")
        
        for buttonTitle in buttonTitles {
            let button = UIButton(type: .system)
            button.titleLabel?.font = textFont
            button.setTitle(buttonTitle, for: .normal)
            button.setTitleColor(textColor, for: .normal)
            button.addTarget(self, action: #selector(buttonTapped(button:)), for: .touchUpInside)
            button.contentVerticalAlignment = .bottom
            buttons.append(button)
        }
        
        buttons[selectedSegmentIndex].setTitleColor(selectorTextColor, for: .normal)
        
        let selectorWidth = frame.width / CGFloat(buttons.count)
        let selectorStartPosition: CGFloat
        // Check for language direction
            if UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft {
                // For RTL, start from the right for selector position
                selectorStartPosition = frame.width - selectorWidth - (selectorWidth * CGFloat(selectedSegmentIndex))
            } else {
                // For LTR, start from the left for selector position
                selectorStartPosition = selectorWidth * CGFloat(selectedSegmentIndex)
            }
        selector = UIView(frame: CGRect(x: selectorStartPosition, y: frame.height - 2, width: selectorWidth, height: 2))
        selector.layer.cornerRadius = frame.height / 2
        selector.layer.masksToBounds = true
        self.setGradientToView()
        addSubview(selector)
        
        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    @objc func buttonTapped(button: UIButton) {
        for (btnIndex, btn) in buttons.enumerated() {
            btn.setTitleColor(textColor, for: .normal)
            
            if btn == button {
                selectedSegmentIndex = btnIndex
                let selectorWidth = self.frame.width / CGFloat(self.buttons.count)
                let selectorStartPosition: CGFloat
                if UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft {
                    // For Arabic language (right-to-left), adjust the position
                    selectorStartPosition = self.frame.width - selectorWidth - (selectorWidth * CGFloat(btnIndex))
                } else {
                    // For non-Arabic languages (left-to-right)
                    selectorStartPosition = selectorWidth * CGFloat(btnIndex)
                }
                UIView.animate(withDuration: 0.3) {
                    self.selector.frame.origin.x = selectorStartPosition
                    self.selector.frame.size.width = self.frame.width / CGFloat(self.buttons.count)
                    self.selector.layer.cornerRadius = self.frame.height / 2
                }
                btn.setTitleColor(selectorTextColor, for: .normal)
            }
        }
        
        sendActions(for: .valueChanged)
    }

    
    func setGradientToView() {
            let color1 = UIColor(red: 127/255, green: 31/255, blue: 243/255, alpha: 1).cgColor
            let color2 = UIColor(red: 173/255, green: 68/255, blue: 249/255, alpha: 1).cgColor
            selector.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
            selector.addGradientLayer(color1: color1, color2: color2)
        }
    
    override func draw(_ rect: CGRect) {
        layer.cornerRadius = frame.height/2
        clipsToBounds = true
    }

}



class CustomSegmentControl3: UIControl {
    var buttons: [UIButton] = []
    var selector: UIView!
    var selectedSegmentIndex = 0
    private var isViewUpdated = false
    
    @IBInspectable
    var border_width: CGFloat = 0 {
        didSet {
            layer.borderWidth = border_width
        }
    }
    
    @IBInspectable
    var border_color: UIColor = .clear {
        didSet {
            layer.borderColor = border_color.cgColor
        }
    }
    
    @IBInspectable
    var commaSeparatedButtonTitles: String = "" {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    var textColor: UIColor = .gray {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    var selectorColor: UIColor = .darkGray {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    var selectorTextColor: UIColor = .white {
        didSet {
            updateView()
        }
    }
    override func layoutSubviews() {
            super.layoutSubviews()

            if !isViewUpdated {
                updateView()
                isViewUpdated = true
            }
        }
 
    func updateView() {
        buttons.removeAll()
        
        subviews.forEach { $0.removeFromSuperview() }
        
        let buttonTitles = commaSeparatedButtonTitles.components(separatedBy: ",")
        
        for buttonTitle in buttonTitles {
            let button = UIButton(type: .system)
            button.setTitle(buttonTitle, for: .normal)
            button.setTitleColor(textColor, for: .normal)
            button.addTarget(self, action: #selector(buttonTapped(button:)), for: .touchUpInside)
            buttons.append(button)
        }
        
        buttons[selectedSegmentIndex].setTitleColor(selectorTextColor, for: .normal)
        
        let selectorWidth = frame.width / CGFloat(buttons.count)
        let selectorStartPosition = frame.width / CGFloat(buttons.count) * CGFloat(selectedSegmentIndex)
        selector = UIView(frame: CGRect(x: selectorStartPosition + 4, y: 4, width: selectorWidth - 8, height: frame.height - 8))
        selector.layer.cornerRadius = selector.frame.height / 2
        selector.layer.masksToBounds = true
        self.selector.backgroundColor = self.selectorColor
        addSubview(selector)
        
        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    @objc func buttonTapped(button: UIButton) {
        for (btnIndex, btn) in buttons.enumerated() {
            btn.setTitleColor(textColor, for: .normal)
            
            if btn == button {
                selectedSegmentIndex = btnIndex
                let selectorStartPosition = frame.width / CGFloat(buttons.count) * CGFloat(btnIndex)
                UIView.animate(withDuration: 0.3) {
                    self.selector.frame.origin.x = selectorStartPosition + 4
                    self.selector.frame.size.width = (self.frame.width / CGFloat(self.buttons.count)) - 8
                    self.selector.layer.cornerRadius = self.selector.frame.height / 2
                    self.selector.backgroundColor = self.selectorColor
                }
                btn.setTitleColor(selectorTextColor, for: .normal)
            }
        }
        
        sendActions(for: .valueChanged)
    }
    
    override func draw(_ rect: CGRect) {
        layer.cornerRadius = frame.height/2
        clipsToBounds = true
    }

}


class CustomSegmentControl4: UIControl, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var collectionView: UICollectionView!
    var selectedSegmentIndex = 0
    var buttonTitles: [String] = []
    private var isViewUpdated = false

    @IBInspectable
    var border_width: CGFloat = 0 {
        didSet {
            layer.borderWidth = border_width
        }
    }

    @IBInspectable
    var border_color: UIColor = .clear {
        didSet {
            layer.borderColor = border_color.cgColor
        }
    }

    @IBInspectable
    var commaSeparatedButtonTitles: String = "" {
        didSet {
            updateView()
        }
    }

    @IBInspectable
    var textColor: UIColor = .white {
        didSet {
            updateView()
        }
    }

    @IBInspectable
    var selectorColor: UIColor = .systemPink {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    var selectedTextColor: UIColor = .black {
        didSet {
            updateView()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        if !isViewUpdated {
            updateView()
            isViewUpdated = true
        }
    }

    func updateView() {
        self.buttonTitles.removeAll()
        subviews.forEach { $0.removeFromSuperview() }
        
         buttonTitles = commaSeparatedButtonTitles.components(separatedBy: ",")

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        collectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(ButtonCell.self, forCellWithReuseIdentifier: ButtonCell.identifier)
        addSubview(collectionView)
       

        setupConstraints()
    }

    func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
        ])
    }

    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return buttonTitles.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonCell.identifier, for: indexPath) as! ButtonCell
        cell.titleLabel.text = buttonTitles[indexPath.item]
        cell.titleLabel.textColor = (indexPath.item == selectedSegmentIndex) ? selectedTextColor : textColor
        cell.contentView.backgroundColor = indexPath.item == self.selectedSegmentIndex ? self.selectorColor : .clear
        cell.contentView.layer.cornerRadius = (frame.height - 8) / 2
        return cell
    }

    // MARK: - UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedSegmentIndex = indexPath.item
        collectionView.reloadData()
        collectionView.scrollToItem(at: IndexPath(item: indexPath.item , section: indexPath.section), at: .centeredHorizontally, animated: true)
        sendActions(for: .valueChanged)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }

    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = buttonTitles[indexPath.item]
        let cellWidth = text.size(withAttributes: [.font: UIFont.systemFont(ofSize: 15.0)]).width + 20.0
        return CGSize(width: max(cellWidth, 50.0), height: collectionView.bounds.height)
    }
}

class ButtonCell: UICollectionViewCell {
    static let identifier = "ButtonCellIdentifier"

    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15.0)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(titleLabel)
        contentView.backgroundColor = .clear
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
