//
//  TableViewCell.swift
//  MovieBox
//
//  Created by Aslıhan Gürkan on 7.04.2023.
//

import UIKit

protocol TableViewCellDelegate : AnyObject {
    func tableViewCellDidTapCell(_ cell: TableViewCell, viewModel: PreviewViewModel)
}

class TableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private var movies : [Movie] = [Movie]()
    weak var delegate: TableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    public func configure(with movies: [Movie]) {
        self.movies = movies
        
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
}

extension TableViewCell : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
//        cell.images.image = UIImage(named: data[collectionView.tag].Movies[indexPath.row])
        
        guard let model = movies[indexPath.row].poster_path else {
            return UICollectionViewCell()
        }
        cell.configure(with: model)
        return cell
    }
    
   
//  didSelectItemAt -> A function where we specify what a selected cell will do.
//  Whenever tap on any cell(item:movie)
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let title = movies[indexPath.row]
        guard let titleName = title.original_title ?? title.original_name else { return }
        //TODO: [weak self] -> expl.
        APICaller.shared.getMovie(with: titleName + "trailer") { [weak self] result in
            switch result {
            case .success(let videoItem):
                
                guard let titleOverview = title.overview else { return }
//                print(titleOverview + titleName)
                let viewModel = PreviewViewModel(title: titleName, youtubeView: videoItem, overview: titleOverview)
                self?.delegate?.tableViewCellDidTapCell(self!, viewModel: viewModel)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
}
