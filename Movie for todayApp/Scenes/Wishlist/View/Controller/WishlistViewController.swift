import UIKit

enum WishListItem: Hashable {
    case favoriteItem(MovieListsCategoryTag)
}

class WishlistViewController: UIViewController {
    enum Section: Hashable, CaseIterable {
        case favoriteFilms
    }
    private lazy var wishlistNavigationBar: CustomNavigationBar = {
        let navbar = CustomNavigationBar(title: "Wishlist")
        navbar.navigationController = self.navigationController
        return navbar
    }()
    let mockData = MovieListsCategoryTag.allCases
    var dataSouce: UICollectionViewDiffableDataSource<Section, WishListItem>!
    private lazy var wishlistCollectionView: UICollectionView = {
        let layout = createLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        return cv
    }()
    private lazy var magicBoxImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "magic-box")
        return image
    }()
    private lazy var emptyFavoritesLabel = UILabel(text: "There Is No Movie Yet!", font: .boldSystemFont(ofSize: 16), textColor: .white)
    private lazy var informationLabel = UILabel(text: "Find your movie by Type title, categories, years, etc", font: .systemFont(ofSize: 12), textColor: .lightGray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .primaryDark
        setupUI()
        setupCollectionView()
        createDataSouce()
        configureDataSouce()
    }
    
    private func setupCollectionView() {
        wishlistCollectionView.register(WishlistCollectionViewCell.self, forCellWithReuseIdentifier: WishlistCollectionViewCell.identifier)
    }
    
    private func checkAndUpdateUI() {
        let items = dataSouce.snapshot().numberOfItems
        wishlistCollectionView.isHidden = items == 0
        if items == 0 {
            magicBoxImage.isHidden = false
            emptyFavoritesLabel.isHidden = false
            informationLabel.isHidden = false
        } else {
            magicBoxImage.isHidden = true
            emptyFavoritesLabel.isHidden = true
            informationLabel.isHidden = true
        }
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { _, _ -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0)
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(125)
            )
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 24, bottom: 60, trailing: 24)
            return section
        }
        return layout
    }
    
    private func createDataSouce() {
        dataSouce = UICollectionViewDiffableDataSource<Section, WishListItem>(collectionView: self.wishlistCollectionView) { collectionView, indexPath, itemIdentifier in
            guard let cell = self.wishlistCollectionView.dequeueReusableCell(withReuseIdentifier: WishlistCollectionViewCell.identifier, for: indexPath) as? WishlistCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
        }
    }
    
    private func configureDataSouce() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, WishListItem>()
        snapshot.appendSections([.favoriteFilms])
        let favoriteFilms = self.mockData.map { WishListItem.favoriteItem($0) }
        snapshot.appendItems(favoriteFilms)
        dataSouce.apply(snapshot)
        checkAndUpdateUI()
    }
    
    private func setupUI() {
        emptyFavoritesLabel.textAlignment = .center
        informationLabel.textAlignment = .center
        informationLabel.numberOfLines = 0
        view.addSubviews(wishlistNavigationBar, wishlistCollectionView, magicBoxImage, emptyFavoritesLabel, informationLabel)
        
        NSLayoutConstraint.activate([
            wishlistNavigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            wishlistNavigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            wishlistNavigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            wishlistNavigationBar.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            wishlistCollectionView.topAnchor.constraint(equalTo: wishlistNavigationBar.bottomAnchor),
            wishlistCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            wishlistCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            wishlistCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            magicBoxImage.heightAnchor.constraint(equalToConstant: 76),
            magicBoxImage.widthAnchor.constraint(equalToConstant: 76),
            magicBoxImage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            magicBoxImage.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            emptyFavoritesLabel.topAnchor.constraint(equalTo: magicBoxImage.bottomAnchor, constant: 16),
            emptyFavoritesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 90),
            emptyFavoritesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -90)
        ])
        
        NSLayoutConstraint.activate([
            informationLabel.topAnchor.constraint(equalTo: emptyFavoritesLabel.bottomAnchor, constant: 8),
            informationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            informationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
        ])
    }
    
}
