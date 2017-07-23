//
//  PageViewContoller.swift
//  Cursometr
//
//  Created by iMacAir on 17.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import UIKit

class PageViewContoller: UIPageViewController, UIPageViewControllerDataSource{
    var currencies : [Currency] = []
    var activityIndicator : UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.view.backgroundColor = Constatns.Color.viewFlipsideBackgroundColor
        
        activityIndicator = CustomActivityIndicator().get()
        view.addSubview(activityIndicator)
        
        NotificationCenter.default.addObserver(self, selector: #selector(startLoading), name: .StartLoadingCurrencySubscription, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateData), name: .FinishLoadingCurrencySubscription, object: nil)
        
        updateData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func updateData(){
        startLoading()
        CurrencySubscriptionService.shared.obtainCurrencySubscription(onSuccess: { [weak self] (currencies) in
            DispatchQueue.main.async {
                self?.currencies = currencies
                self?.updatePageViewController()
                self?.stopLoading()
            }
            }, onError: { [weak self] (error) in
                DispatchQueue.main.async {
                    self?.showError(error: error)
                    self?.updatePageViewController()
                    self?.stopLoading()
                }
        })
    }
    
    func updatePageViewController(){
        setViewControllers([getItemController(0)], direction: .forward, animated: false, completion: nil)
    }
    
    func getItemController(_ itemIndex: Int) -> ItemViewController {
        if (itemIndex < currencies.count){
            let pageItemController = self.storyboard?.instantiateViewController(withIdentifier: String(describing: ItemViewController.self)) as! ItemViewController
            pageItemController.itemIndex = itemIndex
            pageItemController.setConfig(currency: currencies[itemIndex])
            return pageItemController
        }
        else{
            let pageItemController = self.storyboard?.instantiateViewController(withIdentifier: String(describing: ItemViewController.self)) as! ItemViewController
            pageItemController.itemIndex = itemIndex
            pageItemController.setConfig(title: "No currency")
            return pageItemController
        }
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return currencies.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    //swipe to left
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let itemController = viewController as! ItemViewController
        if (itemController.itemIndex > 0)
        {
            return getItemController(itemController.itemIndex-1)
        }
        return nil
    }
    
    //swipe to right
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let itemController = viewController as! ItemViewController
        if (itemController.itemIndex + 1 < currencies.count)
        {
            return getItemController(itemController.itemIndex + 1)
        }
        return nil
    }
    
    func startLoading(){
        view.isUserInteractionEnabled = false
        if (viewControllers?.count)!>0{
            viewControllers?[0].view.isHidden = true
        }
        activityIndicator.startAnimating()
    }
    
    func stopLoading(){
        view.isUserInteractionEnabled = true
        //if (viewControllers?.count)!>0{
            viewControllers?[0].view.isHidden = false
        //}
        activityIndicator.stopAnimating()
    }
    
}
