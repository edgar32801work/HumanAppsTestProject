//
//  MainImageView.swift
//  HumanAppsTestApp
//
//  Created by Эдгар Кусков on 28.03.24.
//

import UIKit
import RxRelay

final class MainImageView: UIView {
    
    let imageConfigObservable = PublishRelay<CGAffineTransform?>()
    private let imageVerticalInset: CGFloat = 13
    
    private var imageViewTransform: CGAffineTransform!
    private var imageViewCenter: CGPoint!
    
    private var imageViewWrapper = UIControl()
    private var imageView: UIImageView!
    private var imageScaleAspectFitScale: CGFloat!
    
    func configure(with image: UIImage) {
        imageView = .init(image: image)
        imageScaleAspectFitScale = image.size.width / (bounds.width - imageVerticalInset * 2)
        
        setConfigurations()
        configureAppearance()
        setupSubviews()
        constraintSubviews()
    }
}

extension MainImageView {
    func setConfigurations() {
        imageView?.contentMode = .scaleAspectFit
        imageViewWrapper.clipsToBounds = true
        imageViewWrapper.isUserInteractionEnabled = true
        
        imageViewWrapper.addGestureRecognizer(
            UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(_:)))
        )
        imageViewWrapper.addGestureRecognizer(
            UIPinchGestureRecognizer(target: self, action: #selector(pinchGestureAction(_:)))
        )
    }
    
    func configureAppearance() {
        imageViewWrapper.layer.borderColor = UIColor.yellow.cgColor
        imageViewWrapper.layer.borderWidth = 2
    }
    
    func setupSubviews() {
        imageView?.removeFromSuperview()
        imageViewWrapper.removeFromSuperview()
        imageViewWrapper.addSubviews(imageView)
        addSubviews(imageViewWrapper)
    }
    
    func constraintSubviews() {
        guard let imageHeight = imageView.image?.size.height else {
            debugPrint("### Error: MainImageView -> constraintSubviews(): Unable to calculate imageHeight")
            return }
        
        imageViewWrapper.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().inset(imageVerticalInset)
            make.height.equalTo(imageHeight / imageScaleAspectFitScale)
        }
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

@objc extension MainImageView {
    
    private func panGestureAction(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: imageViewWrapper)
        if gesture.state == .began {
            imageViewTransform = imageView.transform
        }
        if gesture.state != .cancelled {
            imageView.transform = imageViewTransform.translatedBy(x: translation.x, y: translation.y)
        }
        if gesture.state == .ended {
            imageConfigObservable.accept(imageViewTransform.translatedBy(x: translation.x * imageScaleAspectFitScale,
                                                                         y: translation.y * imageScaleAspectFitScale))
        }
    }
    
    private func pinchGestureAction(_ gesture: UIPinchGestureRecognizer) {
        if gesture.state == .began {
            imageViewTransform = imageView.transform
        }
        if gesture.state != .cancelled {
            imageView.transform = imageViewTransform.scaledBy(x: gesture.scale, y: gesture.scale)
        }
        if gesture.state == .ended {
            imageConfigObservable.accept(imageView.transform)
        }
    }
}
