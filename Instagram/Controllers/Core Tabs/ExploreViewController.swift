//
//  ExploreViewController.swift
//  Instagram
//
//  Created by Артем Волков on 19.09.2021.
//

import UIKit

class ExploreViewController: UIViewController {
    
    private let dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.isHidden = true
        view.alpha = 0
        return view
    }()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.backgroundColor = .systemBackground
        return searchBar
    }()
    
    private var collectionView: UICollectionView?
    private var tabbSearchView: UICollectionView?
    
    private var models = [UserPost]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configSearchBar()
        configExploreCollection()
        configDimmedView()
        configTabbedSearch()
    }
    @objc private func didCancelSearch(){
        
    }
    private func configTabbedSearch(){
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.width / 3, height: 52)
        layout.scrollDirection = .horizontal
        tabbSearchView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        tabbSearchView?.isHidden = true
        tabbSearchView?.backgroundColor = .brown
        guard let tabbSearchView = tabbSearchView else { return }
        tabbSearchView.delegate = self
        tabbSearchView.dataSource = self
        view.addSubview(tabbSearchView)
    }
    
    private func configDimmedView(){
        //gesture
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didCancelSearch))
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTapsRequired = 1
        dimmedView.addGestureRecognizer(gesture)
        view.addSubview(dimmedView)
    }
    
    private func configSearchBar(){
        navigationController?.navigationBar.topItem?.titleView = searchBar
        searchBar.delegate = self
    }
    
    private func configExploreCollection(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: (view.width - 5) / 3.0, height: (view.width - 5) / 3.0)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        guard let collectionView = collectionView else { return }
        view.addSubview(collectionView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
        dimmedView.frame = view.bounds
        tabbSearchView?.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.width, height: 72)
    }
    
}
extension ExploreViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        didTapCancel()
        guard let text = searchBar.text, !text.isEmpty else { return }
        quare(text)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didTapCancel))
        dimmedView.isHidden = false
        UIView.animate(withDuration: 0.2, animations: {
            self.dimmedView.alpha = 0.4
        }) { _ in
            self.tabbSearchView?.isHidden = false
        }
    }
    
    @objc private func didTapCancel(){
        searchBar.resignFirstResponder()
        navigationItem.rightBarButtonItem = nil
        tabbSearchView?.isHidden = true
        UIView.animate(withDuration: 0.2, animations: {
            self.dimmedView.alpha = 0
        }){ _ in
            self.dimmedView.isHidden = true
        }
    }
}



private func quare(_ text: String){
    //perform search at the backend
    
}


extension ExploreViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == tabbSearchView{
            return 0
        }
        return 100
    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == tabbSearchView{
            return UICollectionViewCell()
        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as? PhotoCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        //        cell.configure(with: <#T##UserPost#>)
        cell.configure(debug: "test")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        if collectionView == tabbSearchView{
            //change searchContext
            return 
        }
        
        
        // let model = models[indexPath]
        
        let user = User(userName: "joe", bio: "", name: (first: "", second: ""), birthDate: Date(), gender: .female, counts: UserCount(followers: 12, following: 32, post: 321), joinDate: Date(), profilePhoto: URL(string: "https://www.google.com")!)
        let post = UserPost(identifier: "", postType: .photo, thumbnailImage: URL(string: "https://www.google.com")!, postURL: URL(string: "https://www.google.com")!, caption: nil, likeCount: [], comments: [], postedDate: Date(), taggedUsers: [],
                            owner: user)
        let vc = PostViewController(model: post)
        vc.title = post.postType.rawValue
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
}
