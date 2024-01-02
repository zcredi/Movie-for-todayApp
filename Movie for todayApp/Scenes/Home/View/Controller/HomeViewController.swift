import UIKit

struct PopularCategory: Hashable {
    let id = UUID()
    let popularCategoryFilms: UIImage
}

struct PopularTagCategory: Hashable {
    let id = UUID()
    let popularTagCategory: String
}

struct MostPopular: Hashable {
    let id = UUID()
    let filmTitle: String
}

enum Item: Hashable {
    case popularCategory(PopularCategory)
    case popularTagCategory(PopularTagCategory)
    case mostPopular(MostPopular)
}

class HomeViewController: UIViewController {
    enum Section: Hashable, CaseIterable {
        case popularCategory
        case popularTagCategory
        case mostPopular
    }

    enum SupplementaryViewKing {
        static let header = "header"
    }

    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    var sections = Section.allCases
    let popularCategoryArray: [PopularCategory] = [
        PopularCategory(popularCategoryFilms: UIImage(systemName: "person.fill")!),
        PopularCategory(popularCategoryFilms: UIImage(systemName: "person.fill")!),
        PopularCategory(popularCategoryFilms: UIImage(systemName: "person.fill")!)
    ]
    let popularCategoryTagArray: [PopularTagCategory] = [
        PopularTagCategory(popularTagCategory: "All"),
        PopularTagCategory(popularTagCategory: "Comedy"),
        PopularTagCategory(popularTagCategory: "Animation"),
        PopularTagCategory(popularTagCategory: "Documentation"),
        PopularTagCategory(popularTagCategory: "Documentation")
    ]
    let mostPopularArray: [MostPopular] = [
        MostPopular(filmTitle: "Spider-Man"),
        MostPopular(filmTitle: "Spider-Man"),
        MostPopular(filmTitle: "Spider-Man"),
        MostPopular(filmTitle: "Spider-Man"),
        MostPopular(filmTitle: "Spider-Man")
    ]
    var selectedTagIndexPath: IndexPath?
    private lazy var homeNavigationBar: HomeNavigationBar = {
        let nb = HomeNavigationBar()
        nb.delegate = self
        return nb
    }()

    private lazy var homeCollectionView: UICollectionView = {
        let layout = createLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.allowsMultipleSelection = false
        cv.backgroundColor = .clear
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .primaryDark
        selectedTagIndexPath = IndexPath(row: 0, section: 1)
        setupCollectionView()
        createDataSource()
        createDataSourceSVP()
        configureDataSource()
        setupUI()
        setSelectedCategoriesCell()
    }

    private func setupCollectionView() {
        homeCollectionView.register(HomePopularCategoryCollectionViewCell.self, forCellWithReuseIdentifier: HomePopularCategoryCollectionViewCell.identifier)
        homeCollectionView.register(HomeCategoryTagCollectionViewCell.self, forCellWithReuseIdentifier: HomeCategoryTagCollectionViewCell.identifier)
        homeCollectionView.register(HomeMostPopularCollectionViewCell.self, forCellWithReuseIdentifier: HomeMostPopularCollectionViewCell.identifier)
        homeCollectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: SupplementaryViewKing.header, withReuseIdentifier: SectionHeaderView.identifier)
    }

    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
            let section = self.sections[sectionIndex]
            // Create header for cell
            let headerItemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(44)
            )
            let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerItemSize, elementKind: SupplementaryViewKing.header, alignment: .top)
            headerItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4)

            switch section {
            case .popularCategory:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(160))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 6, bottom: 0, trailing: 6)
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.92),
                    heightDimension: .absolute(160)
                )
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPagingCentered
                section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 20, trailing: 0)
                return section
            case .popularTagCategory:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)

                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 3, bottom: 0, trailing: 3)
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .absolute(100),
                    heightDimension: .absolute(40)
                )
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.boundarySupplementaryItems = [headerItem]
                section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 20, bottom: 20, trailing: 20)
                return section
            case .mostPopular:
                let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(150), heightDimension: .absolute(200))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)

                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .absolute(150),
                    heightDimension: .absolute(200)
                )
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.boundarySupplementaryItems = [headerItem]
                section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 20, bottom: 20, trailing: 20)
                return section
            }
        }
        return layout
    }

    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: homeCollectionView) { _, indexPath, _ -> UICollectionViewCell? in
            let section = self.sections[indexPath.section]
            switch section {
            case .popularCategory:
                guard let cell = self.homeCollectionView.dequeueReusableCell(withReuseIdentifier: HomePopularCategoryCollectionViewCell.identifier, for: indexPath) as? HomePopularCategoryCollectionViewCell else {
                    return UICollectionViewCell()
                }
                return cell
            case .popularTagCategory:
                guard let cell = self.homeCollectionView.dequeueReusableCell(withReuseIdentifier: HomeCategoryTagCollectionViewCell.identifier, for: indexPath) as? HomeCategoryTagCollectionViewCell else {
                    return UICollectionViewCell()
                }
                cell.delegate = self
                cell.configureCell(self.popularCategoryTagArray[indexPath.row].popularTagCategory)
                if indexPath == self.selectedTagIndexPath {
                    cell.toggleButtonState()
                } else {
                    cell.resetButtonState()
                }
                return cell
            case .mostPopular:
                guard let cell = self.homeCollectionView.dequeueReusableCell(withReuseIdentifier: HomeMostPopularCollectionViewCell.identifier, for: indexPath) as?
                    HomeMostPopularCollectionViewCell
                else {
                    return UICollectionViewCell()
                }
                return cell
            }
        }
    }

    private func createDataSourceSVP() {
        dataSource.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath -> UICollectionReusableView? in
            guard let self = self else { return nil }
            let section = self.sections[indexPath.section]

            switch kind {
            case SupplementaryViewKing.header:
                let sectionName: String
                switch section {
                case .popularCategory: return nil
                case .popularTagCategory: sectionName = "Categories"
                case .mostPopular: sectionName = "Most Popular"
                }
                guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: SupplementaryViewKing.header, withReuseIdentifier: SectionHeaderView.identifier, for: indexPath) as? SectionHeaderView else {
                    return nil
                }
                headerView.setTitle(sectionName)
                return headerView
            default:
                return nil
            }
        }
    }

    private func configureDataSource() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.popularCategory, .popularTagCategory, .mostPopular])
        let popularCategoryItems = popularCategoryArray.map { Item.popularCategory($0) }
        snapshot.appendItems(popularCategoryItems, toSection: .popularCategory)
        let popularTagCategoryItems = popularCategoryTagArray.map { Item.popularTagCategory($0) }
        snapshot.appendItems(popularTagCategoryItems, toSection: .popularTagCategory)
        let mostPopularItems = mostPopularArray.map { Item.mostPopular($0) }
        snapshot.appendItems(mostPopularItems, toSection: .mostPopular)
        dataSource?.apply(snapshot)
    }

    private func setSelectedCategoriesCell() {}

    private func setupUI() {
        view.addSubviews(homeNavigationBar, homeCollectionView)
        navigationController?.setNavigationBarHidden(true, animated: false)

        NSLayoutConstraint.activate([
            homeNavigationBar.heightAnchor.constraint(equalToConstant: 100),
            homeNavigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            homeNavigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homeNavigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            homeCollectionView.topAnchor.constraint(equalTo: homeNavigationBar.bottomAnchor, constant: 40),
            homeCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homeCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            homeCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension HomeViewController: HomeCategoryTagPressed {
    func didTapButton(cell: HomeCategoryTagCollectionViewCell) {
        if let previousSelectedIndexPath = selectedTagIndexPath,
           let previousCell = homeCollectionView.cellForItem(at: previousSelectedIndexPath) as? HomeCategoryTagCollectionViewCell
        {
            previousCell.resetButtonState()
        }

        if let currentSelectedIndexPath = homeCollectionView.indexPath(for: cell) {
            selectedTagIndexPath = currentSelectedIndexPath
            cell.toggleButtonState()
        }
    }
}

extension HomeViewController: HomeFavoriteButtonPressed {
    func favoriteButtonPressed() {
        print("Pressed!!!")
    }
}
