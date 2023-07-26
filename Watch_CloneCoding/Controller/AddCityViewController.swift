//
//  AddCityViewController.swift
//  Watch_CloneCoding
//
//  Created by 문인범 on 2023/07/14.
//

import UIKit

class AddCityViewController: UIViewController {
    let colorSet: UIColor = UIColor(red: 28/255, green: 28/255, blue: 30/255, alpha: 1.0)
    
    var filteredList: [WorldClock] = [WorldClock]()
    var wholeCityList:[WorldClock] = [WorldClock]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = colorSet
        self.navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = colorSet
        self.navigationController?.navigationBar.scrollEdgeAppearance?.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.clipsToBounds = true
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationController?.isNavigationBarHidden = false
        setUp()
        tableSetUp()
        setSearchUpdate()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let VC = self.presentingViewController as? UITabBarController else {return}
        guard let VC2 = VC.selectedViewController as? WorldwideClockViewController else {return}
        print("viewSuccess!")
        VC2.viewWillAppear(true)
    }
    
    lazy var searchController: UISearchController = {
        let view = UISearchController(searchResultsController: nil)
        view.searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.searchBar.placeholder = "검색"
        view.searchBar.searchBarStyle = .default
        view.obscuresBackgroundDuringPresentation = false
        view.hidesNavigationBarDuringPresentation = false
        view.automaticallyShowsCancelButton = true
        
        return view
    }()
    
    lazy var cityTableView: UITableView = {
        let view = UITableView(frame: CGRect.zero, style: .grouped)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = colorSet
        return view
    }()
    
    func isFiltered() -> Bool {
        let searchController = self.navigationItem.searchController
        guard let isActive = searchController?.isActive else {return false}
        guard let isSearchBarHasText = searchController?.searchBar.text?.isEmpty else {return false}
        if isActive && !isSearchBarHasText {
            return true
        }
        else {
            return false
        }
    }
}

// MARK: - UI SetUp
extension AddCityViewController {
    private func setUp() {
        
        self.navigationItem.searchController = self.searchController
        self.navigationItem.title = "도시 선택"
        self.searchController.searchBar.backgroundColor = self.colorSet
        self.searchController.searchBar.barTintColor = .white
        self.searchController.searchBar.tintColor = .systemOrange
        self.searchController.searchBar.searchTextField.backgroundColor = UIColor.darkGray
        
        self.view.addSubview(cityTableView)
        self.cityTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        self.cityTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        self.cityTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.cityTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
    }
}

extension AddCityViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func setSearchUpdate() {
        self.searchController.searchBar.delegate = self
        self.searchController.searchResultsUpdater = self
        self.searchController.searchBar.setValue("취소", forKey: "cancelButtonText")
        self.searchController.searchBar.setShowsCancelButton(true, animated: true)
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {return}
        
        print(text)
        self.filteredList = self.wholeCityList.filter{ a in
            a.translatedName.localizedCaseInsensitiveContains(text)
        }
        self.cityTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true)
    }
    
}


extension AddCityViewController: UISearchControllerDelegate {
    
}

extension AddCityViewController: UITableViewDelegate, UITableViewDataSource {
    func tableSetUp() {
        self.cityTableView.dataSource = self
        self.cityTableView.delegate = self
        self.cityTableView.register(CityListCell.self, forCellReuseIdentifier: "cityCell")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = (isFiltered()) ? self.filteredList.count : self.wholeCityList.count
//        print(count)
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.cityTableView.dequeueReusableCell(withIdentifier: "cityCell") as? CityListCell else {return UITableViewCell()}
        let city = (self.isFiltered()) ? self.filteredList[indexPath.row].translatedName : self.wholeCityList[indexPath.row].translatedName
        cell.cityLabel.text = city
        cell.backgroundColor = self.colorSet
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let koreanName = (self.isFiltered()) ? self.filteredList[indexPath.row].translatedName : self.wholeCityList[indexPath.row].translatedName
        let name = (self.isFiltered()) ? self.filteredList[indexPath.row].name : self.wholeCityList[indexPath.row].name

        guard let preVC = self.presentingViewController as? UITabBarController else {return}
        guard let preVC2 = preVC.selectedViewController as? WorldwideClockViewController else {return}
        let selectedCity = WorldClock(translatedName: koreanName, name: name)
        preVC2.selectedCity = selectedCity
        self.presentingViewController?.dismiss(animated: true)
    }
    
}
