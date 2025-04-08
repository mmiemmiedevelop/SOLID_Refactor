//
//  ViewController.swift
//  SOLID
//
//  Created by Mac on 3/31/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchTextField: UITextField!
    var viewModel: ViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ActivityIndicatorHelper.shared.setUp(in: self.view)
        bindViewModel()
        viewModel.fetchPictureList()
        setCollectionView()
        setSearch()
    }
    
    private func setCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func bindViewModel() {
        viewModel.onDataUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        
        viewModel.onLoading = { [weak self] isLoading in
            DispatchQueue.main.async {
                if let view = self?.view {
                    isLoading ? ActivityIndicatorHelper.shared.show() : ActivityIndicatorHelper.shared.hide()
                }
            }
        }
        
        viewModel.onError = { [weak self] errorMsg in
            guard let self = self else { return }
            ErrorAlert.show(in: self, message: errorMsg)
        }
    }
    
    // MARK: - 검색기능
    func setSearch() {
        searchTextField.addTarget(self, action: #selector(searchTextChanged(_:)), for: .editingChanged)
    }
    
    @objc func searchTextChanged(_ textField: UITextField) {
        viewModel.searchText = textField.text ?? ""
        viewModel.filterPictures()
    }
    
}

// MARK: - CollectionView Delegate
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.pitures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! collectionCell
        let picture = viewModel.pitures[indexPath.item]
        cell.configure(with: picture, searchText: viewModel.searchText)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedPicture = viewModel.pitures[indexPath.item]
        let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailVC.passedPiture = selectedPicture
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 5
        let totalWidth = collectionView.frame.width - (padding * 3)
        let width = totalWidth
        return CGSize(width: width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
