//
//  ViewController.swift
//  NamozVaqtlari_API
//
//  Created by Abdulbosid Jalilov on 03/01/23.
//

import UIKit
import SnapKit
import Kingfisher
import CoreLocation
import Reachability

class ViewController: UIViewController {

    var timelist: TimeList?
    
    let city = String()
    let locationManager = CLLocationManager()
    
    let regions = ["Toshkent", "Andijon", "Navoiy", "Buxoro", "Namangan", "Jizzax", "Samarqand"]
    
    //MARK: - Text Field
    
    let search: UITextField = {
       let search = UITextField()
        search.placeholder = " Search "
        search.layer.cornerRadius = 10
        search.layer.borderWidth = 1
        return search
    }()
    
    //MARK: - Table View
    
    let tableView: UITableView = {
       let tableView = UITableView()
        tableView.rowHeight = 250
        return tableView
    }()
    
    //MARK: - Picker View
    var pickerView = UIPickerView()
    
    //MARK: - Location Button
    
    let locationButton: UIButton = {
       let location = UIButton()
        return location
    }()
    
    let activeIndictor: UIActivityIndicatorView = {
       let active = UIActivityIndicatorView()
        active.style = .large
        return active
    }()
    
    
    let reachability = try! Reachability()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: - Location
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        //MARK: - Picker View
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        //MARK: - Called Functions
        
        initView()
 
    }
    
    func initView(){
        
        //MARK: - Search
        
        view.addSubview(search)
        search.delegate = self
        search.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.snp.centerY).multipliedBy(0.15)
            make.width.equalTo(view.snp.width).multipliedBy(0.8)
            make.height.equalTo(view.snp.height).multipliedBy(0.07)
        }
        
        //MARK: - Table View
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(InfoTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.snp.makeConstraints { make in
            make.top.equalTo(search.snp.bottom).offset(20)
            make.centerX.width.equalToSuperview()
            make.height.equalTo(view.snp.height).multipliedBy(0.4)
            
        }
        //MARK: - PickerView Setting
        
        view.addSubview(pickerView)
        pickerView.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom).offset(10)
            make.width.centerX.bottom.equalToSuperview()
        }
        
        view.addSubview(activeIndictor)
        activeIndictor.isHidden = false
        activeIndictor.startAnimating()
        activeIndictor.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }

    }
    
    //MARK: - Fetching Data
    
    func fetchData(region: String) {
        self.activeIndictor.startAnimating()
        self.activeIndictor.isHidden = false
        //url
        let url = URL(string: "https://www.azamjondev.deect.ru/namozvaqtlari/index.php?region=\(region)")
        
        //dataTask
        let dataTask = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            guard let data = data, error == nil else {
                print("Error is \(error)")
                return
            }
            var dataD: TimeList?
            
            do {
                dataD = try JSONDecoder().decode(TimeList.self, from: data)
            }
            catch let error {
                fatalError("tuya pechenniy\(error)")
               
            }
            guard let result = dataD else {
                print("error ")
                return
            }
            
            let weekDay = result.weekdate
            let date = result.date
            let resultList = result.result
            
            self.timelist = TimeList(date: date, weekdate: weekDay, result: resultList)

            DispatchQueue.main.async {
                self.tableView.reloadData()

                self.activeIndictor.isHidden = true
                self.activeIndictor.stopAnimating()
            }
            
        }
        dataTask.resume()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.reachability.whenReachable = { reachability in
//                self.showAlert(tittle: "Ooops", message: "Something went wrong")

                if reachability.connection == .wifi {
                    print("Reachable via WiFi")
                } else {
                    print("Reachable via Cellular")
                }
                
            }
            self.reachability.whenUnreachable = { _ in
                self.showAlert(tittle: "Ooops", message: "Something went wrong")
                print("Not reachable")
            }

            do {
                try self.reachability.startNotifier()
            } catch {
                print("Unable to start notifier")
            }
        }
    }
    
    deinit {
        reachability.stopNotifier()
    }
    
    
    //MARK: - Alert
    
    func showAlert(tittle: String , message: String) {

        let alert = UIAlertController(title: tittle, message: message, preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default) { make in
            
        }
        let noAction = UIAlertAction(title: "No", style: UIAlertAction.Style.cancel, handler: nil)
        
        alert.addAction(yesAction)
        alert.addAction(noAction)


        DispatchQueue.main.async {
            self.present(alert, animated: true,completion: nil)
        }

    }
    
    
}

    //MARK: - TextField Delegate

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        search.endEditing(true)
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = search.text {
            fetchData(region: city)
        }
        else {
            tableView.reloadData()
        }
        search.text = ""
    }
}

//MARK: - Location
extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
        }
    }
}

    //MARK: - Table View Delegate

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! InfoTableViewCell
        cell.weekDate.text = "\(timelist?.weekdate ?? "0")"
        cell.tong_saxarlik.text = "Tong: \(timelist?.result.tong_saharlik ?? "0")"
        cell.dateLabel.text = "\(timelist?.date ?? "0")"
        cell.quyosh.text = "Quyosh: \(timelist?.result.quyosh ?? "0")"
        cell.peshinLabel.text = "Peshin: \(timelist?.result.peshin ?? "0")"
        cell.asrLabel.text = "Asr: \(timelist?.result.asr ?? "0")"
        cell.shomLabel.text = "Shom: \(timelist?.result.shom_iftor ?? "0")"
        cell.xuftonLabel.text = "Xufton: \(timelist?.result.xufton ?? "0")"
        return cell
    }
}

//MARK: - PickerView Delegate

extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return regions[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        fetchData(region: regions[row])
    }
    
}

//MARK: - PickerView Data Source

extension ViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return regions.count
    }
}
