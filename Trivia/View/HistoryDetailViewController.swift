//
//  HistoryDetailViewController.swift
//  Trivia
//
//  Created by Rashmi on 08/08/20.
//  Copyright © 2020 Team. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class HistoryDetailViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    private var viewModel: HisoryDetailViewModel!
    private var preferenceManager: PreferenceManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchHistory()
        collectionView.delegate = self
        //Register in the Xib cell to collectionViewCell
        collectionView.register(UINib.init(nibName: "HistoryDetailCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HistoryDetailCollectionViewCell")
        
        viewModel.user.asObservable().bind(to: self.collectionView.rx.items(cellIdentifier: "HistoryDetailCollectionViewCell")) { index, model, cell in
            let cell = cell as! HistoryDetailCollectionViewCell
            cell.configure(model:model, index: index)
        }.disposed(by: disposeBag)
    }
    
    @IBAction func backButtnTap(_ sender: Any) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    override func inject() {
        viewModel = DependencyInjector.defaultInjector.getContainer().resolve(HisoryDetailViewModel.self)
        preferenceManager = DependencyInjector.defaultInjector.getContainer().resolve(PreferenceManager.self)
    }
}

extension HistoryDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height: 235) // Set the specific height and width for collectionViewCell
    }
}
