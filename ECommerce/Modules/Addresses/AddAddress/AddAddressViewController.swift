//
//  AddAddressViewController.swift
//  ECommerce
//
//  Created by Alex on 2.07.2023.
//

import UIKit

extension Notification.Name {
    static let addUpdateButtonNotification = Notification.Name(rawValue: "AddUpdateButtonNotification")
}

final class AddAddressViewController: UIViewController {
    
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var countryTextField: UITextField!
    @IBOutlet private weak var cityTextField: UITextField!
    @IBOutlet private weak var streetTextField: UITextField!
    @IBOutlet private weak var buildingNoTextField: UITextField!
    @IBOutlet private weak var zipCodeTextField: UITextField!
    @IBOutlet private weak var addUpdateButton: UIButton!
    
    private lazy var pickerView = UIPickerView()
    
    private let service: CountriesServiceProtocol = CountriesService()
    private let userInfoManager: UserInfoManagerProtocol = UserInfoManager()
    
    private var address: AddressModel?
    private var countries: [Country] = []
    
    private let notificationCenter: NotificationCenter = NotificationCenter.default
    
    init(address: AddressModel?) {
        self.address = address
        super.init(nibName: "AddAddressView", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupRequirements()
        getCountries()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupWithModel()
    }
    
    private func setupRequirements() {
        pickerView.delegate = self
        pickerView.dataSource = self
        
        countryTextField.inputView = pickerView
    }
    
    private func setupWithModel() {
        if address != nil {
            nameTextField.text = address?.name
            countryTextField.text = address?.country
            cityTextField.text = address?.city
            streetTextField.text = address?.street
            buildingNoTextField.text = String(address?.buildingNumber ?? 0)
            zipCodeTextField.text = String(address?.zipCode ?? 0)
            addUpdateButton.setTitle("Update", for: .normal)
        }
    }
    
    @IBAction private func addUpdateButtonTapped(_ sender: Any) {
        
        defer {
            self.navigationController?.popViewController(animated: true)
        }
      
        if let name = nameTextField.text,
           let country = countryTextField.text,
           let city = cityTextField.text,
           let street = streetTextField.text,
           let buildingNo = buildingNoTextField.text,
           let zipCode = zipCodeTextField.text,
           !name.isEmpty,
           !country.isEmpty,
           !city.isEmpty,
           !street.isEmpty,
           !buildingNo.isEmpty,
           !zipCode.isEmpty {
            
            let newInfos: [String: AnyHashable] = ["userId": userInfoManager.getUserUid(),
                                                   "uuid": self.address?.uuid ?? UUID(),
                                                   "name": name,
                                                   "country": country,
                                                   "city": city,
                                                   "street": street,
                                                   "buildingNumber": Int(buildingNo),
                                                   "zipCode": Int(zipCode)]
            
            let action = addUpdateButton.titleLabel?.text == "Add" ? "add" : "update"
            let userInfoForNC: [String: Any] = ["address": newInfos, "action": action]
            notificationCenter.post(name: .addUpdateButtonNotification, object: nil, userInfo: userInfoForNC) // magic :D
        } else {
            self.showAlert(title: "", message: GeneralError.addressInfoMissing.localizedDescription)
        }
    }

    private func getCountries() {
        Task {
            try await service.getAllCountries { [weak self] result in
                guard let self else { return }
                
                switch result {
                case .success(let countries):
                    DispatchQueue.main.async { [weak self] in
                        self?.countries = countries.sorted()
                        self?.pickerView.reloadAllComponents()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}

// MARK: - PickerViewDelegate
extension AddAddressViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countries.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countries[row].name.common
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        countryTextField.text = countries[row].name.common
    }
}
