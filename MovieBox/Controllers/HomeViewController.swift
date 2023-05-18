//
//  HomeViewController.swift
//  MovieBox
//
//  Created by Aslıhan Gürkan on 7.04.2023.
//

import UIKit

enum Sections : Int {
    case TrendingMovies = 0
    case TrendingTv = 1
    case Popular = 2
    case Upcoming = 3
    case TopRated = 4
}

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let sectionTitles: [String] = ["Trending Movies", "Trending Series", "Popular", "Upcoming Movies", "Top Rated"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section].uppercased()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        //TODO: expl. tag & indexPath.section
        cell.collectionView.tag = indexPath.section
        
        cell.delegate = self
        
        switch indexPath.section {
            case Sections.TrendingMovies.rawValue :
                APICaller.shared.getTrendingMovies { result in
                    switch result {
                    case .success(let movies):
                        cell.configure(with: movies)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            case Sections.TrendingTv.rawValue:
                APICaller.shared.getTrendingTv { result in
                    switch result {
                    case .success(let titles):
                        cell.configure(with: titles)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            case Sections.Popular.rawValue:
                APICaller.shared.getPopular { result in
                    switch result {
                    case .success(let titles):
                        cell.configure(with: titles)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                case Sections.Upcoming.rawValue:
                    APICaller.shared.getUpcomingMovies { result in
                        switch result {
                        case .success(let titles):
                            cell.configure(with: titles)
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                    
                case Sections.TopRated.rawValue:
                    APICaller.shared.getTopRated { result in
                        switch result {
                        case .success(let titles):
                            cell.configure(with: titles)
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
            default:
                return UITableViewCell()
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 200, height: header.bounds.height)
//        header.textLabel?.textColor = .white
//        header.tintColor = .gray
        header.textLabel?.text = header.textLabel?.text?.capitalized
        
    }

}

extension HomeViewController : TableViewCellDelegate {
    func tableViewCellDidTapCell(_ cell: TableViewCell, viewModel: PreviewViewModel) {
        
        DispatchQueue.main.async { [weak self] in
            let vc =  self?.storyboard?.instantiateViewController(withIdentifier: "PreviewViewController") as? PreviewViewController //PreviewViewController()
            vc?.movieTitle = viewModel.title
            vc?.movieOverview = viewModel.overview
            vc?.videoId = viewModel.youtubeView.id.videoId
            
            
//            vc!.configure(with: viewModel)
            self?.navigationController?.pushViewController(vc!, animated: true)
        }
    }
}
