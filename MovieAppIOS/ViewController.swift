//
//  ViewController.swift
//  MovieAppIOS
//
//  Created by hungdt on 21/02/2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var homeView: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var viewCollection: UICollectionView!
    @IBOutlet weak var upcomingCollectionView: UICollectionView!
    
    //data
    var popularMovies: [MovieEntity] = []
    var upcomingMovies: [MovieEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getListMovie { popularMovies in
            self.popularMovies = popularMovies
            DispatchQueue.main.async{ [weak self] in
                self?.viewCollection.reloadData()
                self?.viewCollection.scrollToItem(at: IndexPath(row: 1, section: 0), at: .centeredHorizontally, animated: false)
                //self?.showIndicatorView()
            }
        }
        setupUI()
    }
    
    func setupUI(){
        //Home Gradient Color
        let leftColor = UIColor(red: 0.17, green: 0.35, blue: 0.46, alpha: 1.00).cgColor
        let rightColor = UIColor(red: 0.31, green: 0.26, blue: 0.46, alpha: 1.00).cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.homeView.bounds
        gradientLayer.colors = [leftColor, rightColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        self.homeView.layer.insertSublayer(gradientLayer, at: 0)
        
        //search view
        let gradientLayerSearch = CAGradientLayer()
        let leftColorSearch = UIColor(red: 0.42, green: 0.40, blue: 0.65, alpha: 0.30).cgColor
        let rightColorSearch = UIColor(red: 0.46, green: 0.82, blue: 0.87, alpha: 0.30).cgColor
        gradientLayerSearch.frame = self.searchView.bounds
        gradientLayerSearch.colors = [leftColorSearch, rightColorSearch]
        gradientLayerSearch.startPoint = CGPoint(x: 0, y: 0)
        gradientLayerSearch.endPoint = CGPoint(x: 1, y: 0)
        self.searchView.layer.insertSublayer(gradientLayerSearch, at: 0)
        searchView.layer.borderWidth = 1
        searchView.layer.borderColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.30).cgColor
        searchView.layer.cornerRadius = 15;
        searchView.layer.masksToBounds = true;
        
        //Most Popular
        viewCollection.delegate = self
        viewCollection.dataSource = self
        if let flowLayout = viewCollection.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.estimatedItemSize = .zero
            viewCollection.showsHorizontalScrollIndicator = false
        }
        
        ///UpComing Releases
        upcomingCollectionView.delegate = self
        upcomingCollectionView.dataSource = self
        if let flowLayout = upcomingCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.estimatedItemSize = .zero
            upcomingCollectionView.showsHorizontalScrollIndicator = false
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    //số item
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.viewCollection {
            return popularMovies.count
        }else if collectionView == self.upcomingCollectionView{
            return 20
        }
        return 0
    }
    
    //item của list
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //MostPuPular
        if collectionView == self.viewCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
            cell.layer.cornerRadius = 30
            cell.image.load(url: URL(string: "\(NetWorkBase.baseImageUrl)\(self.popularMovies[indexPath.row].posterPath ?? "")")!)
            cell.movieName.text =              self.popularMovies[indexPath.row].title ?? ""
            return cell
        } else {
            //Upcoming
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemUpComingRelease", for: indexPath) as! ItemUpComingRelease
            cell.layer.cornerRadius = 30
            cell.imageView.load(url: URL(string: "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg")!)
            
            return cell
        }
        
    }
    
    //thuộc tính của item
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.viewCollection {
            let height = collectionView.frame.size.height
            let width = collectionView.frame.size.width * 0.8
            return CGSize(width: width, height: height)
        } else{
            let height = collectionView.frame.size.height
            let width = collectionView.frame.size.width * 0.36
            return CGSize(width: width, height: height)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.viewCollection {
            return 10
        } else {
            return 20
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
