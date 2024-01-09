import UIKit

enum PopularMovieItem: Hashable {
    case popularMovies(MovieListsCategoryTag)
}

class PopularMovieViewController: UIViewController {
    enum Section: Hashable, CaseIterable {
        case popolarMovie
    }
    
    let mockPopularMovies = MovieListsCategoryTag.allCases
    
    private lazy var popularMovieNavigationBar: CustomNavigationBar = {
        let navigationBar = CustomNavigationBar(title: "Popular Movie")
        navigationBar.navigationController = self.navigationController
        return navigationBar
    }()
    
    private lazy var popularMovieCollectionView: UICollectionView = {
        let layout = createLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        return cv
    }()

    var dataSouce: UICollectionViewDiffableDataSource<Section, PopularMovieItem>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .primaryDark
        setupUI()
        setupCollectionView()
        createDataSouce()
        configureDataSouce()
    }
    
    private func setupCollectionView() {
        popularMovieCollectionView.register(PopularMovieCollectionViewCell.self, forCellWithReuseIdentifier: PopularMovieCollectionViewCell.identifier)
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { _, _ -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(160)
            )
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 24, bottom: 60, trailing: 24)
            return section
        }
        return layout
    }
    
    private func createDataSouce() {
        dataSouce = UICollectionViewDiffableDataSource<Section, PopularMovieItem>(collectionView: popularMovieCollectionView) { _, indexPath, _ -> UICollectionViewCell? in
            guard let cell = self.popularMovieCollectionView.dequeueReusableCell(withReuseIdentifier: PopularMovieCollectionViewCell.identifier, for: indexPath) as? PopularMovieCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configureCell()
            return cell
        }
    }
    
    private func configureDataSouce() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, PopularMovieItem>()
        snapshot.appendSections([.popolarMovie])
        let popularMovie = mockPopularMovies.map { PopularMovieItem.popularMovies($0) }
        snapshot.appendItems(popularMovie)
        dataSouce.apply(snapshot)
    }
    
    private func setupUI() {
        view.addSubviews(popularMovieNavigationBar, popularMovieCollectionView)
        
        NSLayoutConstraint.activate([
            popularMovieNavigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            popularMovieNavigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            popularMovieNavigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            popularMovieNavigationBar.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            popularMovieCollectionView.topAnchor.constraint(equalTo: popularMovieNavigationBar.bottomAnchor),
            popularMovieCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            popularMovieCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            popularMovieCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
