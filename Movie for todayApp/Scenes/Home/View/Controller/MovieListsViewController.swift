import UIKit

enum MovieListsItem: Hashable {
    case categoryTag(MovieListsCategoryTag)
    case movies(MovieListsCategoryTag)
}

class MovieListsViewController: UIViewController {
    enum Section: Hashable, CaseIterable {
        case categoryTag
        case movies
    }
    
    var sections = Section.allCases
    let categoryTagArray = MovieListsCategoryTag.allCases
    var dataSource: UICollectionViewDiffableDataSource<Section, MovieListsItem>!
    var selectedCategoryTag: IndexPath?
    private lazy var movieNavigationBar: CustomNavigationBar = {
        let navigationBar = CustomNavigationBar(title: "Movie Lists")
        navigationBar.navigationController = self.navigationController
        return navigationBar
    }()
    
    private lazy var movieListsCollectionView: UICollectionView = {
        let layout = createLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        selectedCategoryTag = IndexPath(row: 0, section: 0)
        view.backgroundColor = .primaryDark
        setupUI()
        setupCollectionView()
        createDataSource()
        configureDataSouce()
    }
    
    private func setupCollectionView() {
        movieListsCollectionView.register(HomeCategoryTagCollectionViewCell.self, forCellWithReuseIdentifier: HomeCategoryTagCollectionViewCell.identifier)
        movieListsCollectionView.register(MovieListsCollectionViewCell.self, forCellWithReuseIdentifier: MovieListsCollectionViewCell.identifier)
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {
            sectionIndex,
            _ -> NSCollectionLayoutSection? in
            let section = self.sections[sectionIndex]
            switch section {
            case .categoryTag:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .estimated(100),
                    heightDimension: .estimated(40)
                )
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = NSDirectionalEdgeInsets(top: 24, leading: 24, bottom: 10, trailing: 24)
                return section
            case .movies:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(220)
                )
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets =  NSDirectionalEdgeInsets(top: 24, leading: 24, bottom: 24, trailing: 24)
                return section
            }
        }
        return layout
    }
    
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section,MovieListsItem>(collectionView: movieListsCollectionView) { collectionView, indexPath, itemIdentifier -> UICollectionViewCell? in
            let section = self.sections[indexPath.section]
            switch section {
            case .categoryTag:
                guard let cell = self.movieListsCollectionView.dequeueReusableCell(withReuseIdentifier: HomeCategoryTagCollectionViewCell.identifier, for: indexPath) as? HomeCategoryTagCollectionViewCell else {
                    return UICollectionViewCell()
                }
                cell.configureCell(self.categoryTagArray[indexPath.row].rawValue)
                cell.delegate = self
                if indexPath == self.selectedCategoryTag {
                    cell.toggleButtonState()
                } else {
                    cell.resetButtonState()
                }
                return cell
            case .movies:
                guard let cell = self.movieListsCollectionView.dequeueReusableCell(withReuseIdentifier: MovieListsCollectionViewCell.identifier, for: indexPath) as? MovieListsCollectionViewCell else {
                    return UICollectionViewCell()
                }
                return cell
            }
        }
    }
    
    private func configureDataSouce() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, MovieListsItem>()
        snapshot.appendSections([.categoryTag, .movies])
        let movieListsCategoryTag = categoryTagArray.map { MovieListsItem.categoryTag($0) }
        snapshot.appendItems(movieListsCategoryTag, toSection: .categoryTag)
        let movieListsFilm = categoryTagArray.map { MovieListsItem.movies($0) }
        snapshot.appendItems(movieListsFilm, toSection: .movies)
        dataSource.apply(snapshot)
    }

    private func setupUI() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.addSubviews(movieNavigationBar, movieListsCollectionView)

        NSLayoutConstraint.activate([
            movieNavigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            movieNavigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieNavigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            movieNavigationBar.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            movieListsCollectionView.topAnchor.constraint(equalTo: movieNavigationBar.bottomAnchor),
            movieListsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieListsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            movieListsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension MovieListsViewController: HomeCategoryTagPressed {
    func didTapButton(cell: HomeCategoryTagCollectionViewCell) {
        guard let currentSelectedIndexPath = movieListsCollectionView.indexPath(for: cell) else {
            return
        }
        
        if currentSelectedIndexPath == self.selectedCategoryTag {
            return
        }
        
        if let previousSelectedIndexPath = self.selectedCategoryTag,
           let previousCell = movieListsCollectionView.cellForItem(at: previousSelectedIndexPath) as? HomeCategoryTagCollectionViewCell {
            previousCell.resetButtonState()
        }
        
        self.selectedCategoryTag = currentSelectedIndexPath
        cell.toggleButtonState()
        
    }
    
    
}
