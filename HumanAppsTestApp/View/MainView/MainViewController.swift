//
//  MainViewController.swift
//  HumanAppsTestApp
//
//  Created by Эдгар Кусков on 27.03.24.
//

import UIKit
import SnapKit
import RxCocoa

final class MainViewController: BaseViewController {
    
    private let viewModel: MainViewViewModelType = MainViewViewModel()
    
    private let showImagePickerButton: UIButton = {
        let showImagePickerButton = UIButton()
        showImagePickerButton.setImage(Resources.Images.MainViewController.showImagePickerButton?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 100)),
                                       for: .normal)
        showImagePickerButton.setTitle(Resources.Strings.MainViewController.showImagePickerButton,
                                       for: .normal)
        showImagePickerButton.setTitleColor(.gray, for: .normal)
        return showImagePickerButton
    }()
    private let saveBarButton = UIBarButtonItem(systemItem: .save)
    private let imagePicker = UIImagePickerController()
    private let imageView = MainImageView()
    private var image: UIImage?
    
    private func configureImageView(with image: UIImage) {
        imageView.configure(with: image)
        imageView.isHidden = false
        showImagePickerButton.isHidden = true
        self.image = image
    }
    
    private func configureButtons() {
        showImagePickerButton.rx.tap.asDriver()
            .drive(onNext: { [weak self] in
                guard let self else {
                    debugPrint("### Error: MainViewController -> configureButtons() -> showImagePickerButton configuration: Unable to unwrap optional self")
                    return }
                
                present(imagePicker, animated: true)
            })
            .disposed(by: viewModel.disposeBag)
        
        saveBarButton.rx.tap.asDriver().drive(onNext: { [weak self] in
            self?.viewModel.saveImage(self?.image)
        }).disposed(by: viewModel.disposeBag)
        navigationItem.setRightBarButton(saveBarButton, animated: true)
    }
}

extension MainViewController {
    
    override func setConfigurations() {
        super.setConfigurations()
        
        imageView.isHidden = true
        imagePicker.delegate = self
        configureButtons()
        viewModel.setImageTransformObservable(imageView.imageConfigObservable)
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        
        view.addSubviews(showImagePickerButton, imageView)
    }
    
    override func constraintSubviews() {
        super.constraintSubviews()
        
        showImagePickerButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension MainViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            debugPrint("### Error: MainViewController -> imagePickerController() -> didFinishPickingMediaInfo method: Unable to get image")
            return }
        
        configureImageView(with: image)
        picker.dismiss(animated: true)
    }
}



