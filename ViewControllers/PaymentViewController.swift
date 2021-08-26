//
//  PaymentViewController.swift
//  TolkApp
//
//  Created by sanganan on 7/2/20.
//  Copyright © 2020 sanganan. All rights reserved.
//

import UIKit
import AnimatedCardInput

class PaymentViewController: UIViewController {
    

    
    private let cardView: CardView = {
           let view = CardView(
               cardNumberDigitsLimit: 16,
               cardNumberChunkLengths: [4, 4, 4, 4],
               CVVNumberDigitsLimit: 3
           )

           view.frontSideCardColor = #colorLiteral(red: 0.2156862745, green: 0.2156862745, blue: 0.2156862745, alpha: 1)
           view.backSideCardColor = #colorLiteral(red: 0.2156862745, green: 0.2156862745, blue: 0.2156862745, alpha: 1)
           view.selectionIndicatorColor = .orange
           view.frontSideTextColor = .white
           view.CVVBackgroundColor = .white
           view.backSideTextColor = .black
           view.isSecureInput = true

           view.numberInputFont = UIFont.systemFont(ofSize: 20, weight: .semibold)
           view.nameInputFont = UIFont.systemFont(ofSize: 14, weight: .regular)
           view.validityInputFont = UIFont.systemFont(ofSize: 14, weight: .regular)
           view.CVVInputFont = UIFont.systemFont(ofSize: 16, weight: .semibold)

           return view
       }()

       private let inputsView: CardInputsView = {
           let view = CardInputsView(cardNumberDigitLimit: 16)
           view.inputFont = UIFont.systemFont(ofSize: 16)
           view.translatesAutoresizingMaskIntoConstraints = false
           view.isSecureInput = true
           return view
       }()

       private let retrieveButton: UIButton = {
           let button = UIButton(type: .custom)
        button.setTitle("addYrCrdKey".localizableString(loc: Constant.lang), for: .normal)
           button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.undrC
           button.layer.cornerRadius = 25
           button.translatesAutoresizingMaskIntoConstraints = false
           button.addTarget(self, action: #selector(retrieveTapped), for: .touchUpInside)
           return button
       }()

//       private let previewTextView: UITextView = {
//           let textView = UITextView(frame: .zero)
//           textView.isUserInteractionEnabled = false
//           textView.layer.cornerRadius = 5
//           textView.layer.borderWidth = 1
//           textView.layer.borderColor = UIColor.black.cgColor
//           textView.translatesAutoresizingMaskIntoConstraints = false
//           return textView
//       }()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonNavigationBar(title: Constant.navTitles.payVCT, controller: Constant.Controllers.payment)
        
        cardView.creditCardDataDelegate = inputsView
        inputsView.creditCardDataDelegate = cardView

        [
            cardView,
            inputsView,
            retrieveButton,
      //      previewTextView,
        ].forEach(view.addSubview)

        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            cardView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),

            inputsView.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 24),
            inputsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            inputsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),

            retrieveButton.heightAnchor.constraint(equalToConstant: 50),
            retrieveButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            retrieveButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            retrieveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            retrieveButton.topAnchor.constraint(equalTo: inputsView.bottomAnchor, constant: 50),
            
            
            
            
//            previewTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            previewTextView.topAnchor.constraint(equalTo: retrieveButton.bottomAnchor, constant: 32),
//            previewTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32),
//            previewTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
//            previewTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
        ])
       

      
    }
    override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(animated)
           cardView.currentInput = .cardNumber
       }
    

    @objc private func retrieveTapped() {
        let data = cardView.creditCardData
        if data.cardholderName == "" || data.cardNumber == "" || data.validityDate == "" || data.CVVNumber == ""
        {
            AppUtils.showToast(message: Constant.Msg.allFldsManMsg)
            return
        }
        if self.expDateValidation(dateStr: data.validityDate) == false {
            AppUtils.showToast(message: "invalidDK".localizableString(loc: Constant.lang))
                       return
        }
        
//        let date = data.validityDate
//        let componentsArr = date.components(separatedBy: "/")
//        let month    = componentsArr[0]
//        let year = componentsArr[1]
//        if Int(month)! > 12 || Int(month)! == 0
//        {
//
//        }
//        if Int(year)! < 20
//        {
//          AppUtils.showToast(message: "Invalid date.")
//            return
//        }
       
        addCreditCardApi()
           
    //        previewTextView.text = "\(data.cardNumber)\n\(data.cardholderName)\n\(data.validityDate)\n\(data.CVVNumber)"
        }
    }
    
 

extension PaymentViewController
{
    
    //Add Credit Card Post Api
    func addCreditCardApi()
    {
         let data = cardView.creditCardData
        
    let date = data.validityDate
        let componentsArr = date.components(separatedBy: "/")

        let month    = componentsArr[0]
        let year = componentsArr[1]

        Utils.startLoading(self.view)
        
        var payProfileId = ""
               if let profile = AppUtils.getStringForKey(key: Constant.userData.paymentProfileId)
               {
                   payProfileId = profile
               }
        let request:[String:Any] = ["userId" : Constant.appDel.userId,
                                    "number" : data.cardNumber,
                                    "exp_month": month,
                                    "exp_year": year,
                                    "cvc": data.CVVNumber,
                                    "profileId": payProfileId,
                                    ]

        Service.sharedInstance.postRequest(Url:Constant.APIs.addcreditcard,modalName: approvedDocModal.self , parameter: request as [String:Any]) { (response, error) in
            DispatchQueue.main.async {
                Utils.stopLoading()
                if let res = response?.Success{
                    if res == 1{
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue:"cardadd"), object: nil)
                        
                        self.navigationController?.popViewController(animated: true)
                        

                        AppUtils.showToast(message: "cardAddedKey".localizableString(loc: Constant.lang))

                    }else{
                        AppUtils.showToast(message: (response?.Message)!)
                    }
                }
            }}

   }
    
    
    func expDateValidation(dateStr:String) -> Bool {

        let currentYear = Calendar.current.component(.year, from: Date()) % 100   // This will give you current year (i.e. if 2019 then it will be 19)
        let currentMonth = Calendar.current.component(.month, from: Date()) // This will give you current month (i.e if June then it will be 6)

        let enteredYear = Int(dateStr.suffix(2)) ?? 0 // get last two digit from entered string as year
        let enteredMonth = Int(dateStr.prefix(2)) ?? 0 // get first two digit from entered string as month
        print(dateStr) // This is MM/YY Entered by user

        if enteredYear > currentYear {
            if (1 ... 12).contains(enteredMonth) {
                print("Entered Date Is Right")
                return true
            } else {
                print("Entered Date Is Wrong")
                return false
            }
        } else if currentYear == enteredYear {
            if enteredMonth >= currentMonth {
                if (1 ... 12).contains(enteredMonth) {
                   print("Entered Date Is Right")
                    return true

                } else {
                   print("Entered Date Is Wrong")
                    return false

                }
            } else {
                print("Entered Date Is Wrong")
                return false

            }
        } else {
           print("Entered Date Is Wrong")
            return false
        }

    }
    
}
