//
//  MainViewViewModelType.swift
//  HumanAppsTestApp
//
//  Created by Эдгар Кусков on 28.03.24.
//

import Foundation
import RxSwift
import UIKit
import RxRelay

protocol MainViewViewModelType {
    var disposeBag: DisposeBag { get }
    
    func saveImage(_ image: UIImage?)
    func setImageTransformObservable(_ imageConfigObservable: PublishRelay<CGAffineTransform?>)
}
