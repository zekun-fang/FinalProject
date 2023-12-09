import UIKit

class ProgressRingView: UIView {

    var ringWidth: CGFloat = 20.0
    var progress1: CGFloat = 0.4 // first segment percentage
    var progress2: CGFloat = 0.35 // second segment percentage
    var progress3: CGFloat { // third segment percentage
        return 1.0 - progress1 - progress2
    }

    // Define colors for each segment
    var color1: UIColor = .orange
    var color2: UIColor = .blue
    var color3: UIColor = .red

    // Create a label for the amount
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.text = "₹ 9400.0"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    private func commonInit() {
        isOpaque = false // Ensure that the view is not opaque
        backgroundColor = .clear // Explicitly set background color to clear
        addSubview(amountLabel)
        setupAmountLabelConstraints()
    }

    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func setupAmountLabelConstraints() {
        NSLayoutConstraint.activate([
            amountLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            amountLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 10) // Adjust the constant to move the label vertically within the ring
        ])
    }

    override func draw(_ rect: CGRect) {
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let radius = min(rect.width, rect.height) / 2 - ringWidth / 2
        let startAngle: CGFloat = -.pi / 2
        
        // Draw segments
        let endAngle1 = startAngle + 2 * .pi * progress1
        let endAngle2 = endAngle1 + 2 * .pi * progress2
        let endAngle3 = startAngle + 2 * .pi
        
        // Segment 1
        drawSegment(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle1, color: color1)
        
        // Segment 2
        drawSegment(center: center, radius: radius, startAngle: endAngle1, endAngle: endAngle2, color: color2)
        
        // Segment 3
        drawSegment(center: center, radius: radius, startAngle: endAngle2, endAngle: endAngle3, color: color3)
    }
    
    private func drawSegment(center: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat, color: UIColor) {
        let path = UIBezierPath()
        path.addArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        path.lineWidth = ringWidth
        color.setStroke()
        path.stroke()
    }
    
    // Call this method to update the amount text if needed
    func setAmount(_ amount: String) {
        amountLabel.text = amount
    }
}
