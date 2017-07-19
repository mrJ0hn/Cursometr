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
    var activityIndicator = UIActivityIndicatorView()
    var currentIndexPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.dataSource = self
        self.view.backgroundColor = UIColor.black
        createActivityIndicator()
        CurrencySubscriptionService.shared.startLoading = startLoading
        CurrencySubscriptionService.shared.finishLoading = updateData
        updateData()
    }
    
    func createActivityIndicator(){
        activityIndicator.frame	= CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        view.addSubview(activityIndicator)
    }
    
    func updateData(){
        startLoading()
        CurrencySubscriptionService.shared.getCurrencySubscription(onSuccess: { [weak self] (currencies) in
            DispatchQueue.main.async {
                self?.currencies = currencies
                self?.updatePageViewController()
                self?.stopLoading()
            }
        })
    }
    
    func updatePageViewController(){
        setViewControllers([getItemController(currentIndexPage)], direction: .forward, animated: false, completion: nil)
    }
    
    func getItemController(_ itemIndex: Int) -> ItemViewController {
        if (itemIndex < currencies.count){
            let pageItemController = self.storyboard?.instantiateViewController(withIdentifier: String(describing: ItemViewController.self)) as! ItemViewController
            pageItemController.itemIndex = itemIndex
            pageItemController.setConfig(currency: currencies[itemIndex])
            print("setConfig")
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
        return currentIndexPage
    }
    
    
    //swipe to left
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let itemController = viewController as! ItemViewController
        if (itemController.itemIndex > 0)
        {
            currentIndexPage = itemController.itemIndex-1
            return getItemController(itemController.itemIndex-1)
        }
        return nil
    }
    
    //swipe to right
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let itemController = viewController as! ItemViewController
        if (itemController.itemIndex + 1 < currencies.count)
        {
            currentIndexPage = itemController.itemIndex+1
            return getItemController(itemController.itemIndex + 1)
        }
        return nil
    }
    
    func startLoading(){
        view.isUserInteractionEnabled = false
        activityIndicator.startAnimating()
    }
    
    func stopLoading(){
        view.isUserInteractionEnabled = true
        activityIndicator.stopAnimating()
    }
    
}
