//
//  MainViewViewModel.swift
//  HumanAppsTestApp
//
//  Created by Эдгар Кусков on 28.03.24.
//

import Foundation
import RxRelay
import RxSwift
import UIKit

final class MainViewViewModel: MainViewViewModelType {
    
    let disposeBag: DisposeBag = DisposeBag()
    private var imageTransform: CGAffineTransform?
    
    private func cropImage(image: UIImage, transform: CGAffineTransform) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(image.size, false, 0.0)
        
        let newX = (image.size.width / 2) - (image.size.width * transform.d / 2) + transform.tx
        let newY = ((image.size.height / 2) - (image.size.height * transform.d / 2)) + transform.ty
        let newWidth = image.size.width * transform.d
        let newHeight = image.size.height * transform.d
        image.draw(in: CGRect(x: newX, y: newY, width: newWidth, height: newHeight))
        
        let transformedImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        return transformedImage
    }
    
    func saveImage(_ image: UIImage?) {
        guard let imageTransform else {
            debugPrint("### Error: MainViewViewModel -> saveImage(): Unable to unwrap imageConfig")
            return }
        guard let image,
              let imageToSave = cropImage(image: image, transform: imageTransform)
        else {
            debugPrint("### Error: MainViewViewModel -> saveImage(): Unable to unwrap image")
            return }
        
        UIImageWriteToSavedPhotosAlbum(imageToSave, nil, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)        //TODO: алерт если нет разрешения
    }
    
    func setImageTransformObservable(_ imageConfigObservable: RxRelay.PublishRelay<CGAffineTransform?>) {
        imageConfigObservable.asDriver(onErrorJustReturn: nil).drive(onNext: { [weak self] in
            self?.imageTransform = $0
        }).disposed(by: disposeBag)
    }
    
}

@objc extension MainViewViewModel {
    func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error {
            debugPrint("### Error: MainViewViewModel -> image(): Saving to gallery \(error)")
        }
    }
}
