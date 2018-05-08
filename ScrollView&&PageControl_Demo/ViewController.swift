//
//  ViewController.swift
//  ScrollView&&PageControl_Demo
//
//  Created by apple on 2018/5/8.
//  Copyright © 2018年 Liberate. All rights reserved.
//

import UIKit

//extension UIImage {
//    /**
//     *  重设图片大小
//     */
//    func reSizeImage(reSize:CGSize)->UIImage {
//        UIGraphicsBeginImageContextWithOptions(reSize,false,1);
//        self.draw(in: CGRect(x: 0, y: 0, width: reSize.width, height: reSize.height));
//        let reSizeImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!;
//        UIGraphicsEndImageContext();
//        return reSizeImage;
//    }
//}

class ViewController: UIViewController,UIScrollViewDelegate {

    var courses = [["title":"《1Q84》",         "content":"《傲慢与偏见》是简·奥斯汀的代表作。小说讲述了乡绅之女伊丽莎白·班内特的爱情故事。",    "pic":"1Q84.png"],
                   ["title":"《傲慢与偏见》",     "content":"《傲慢与偏见》是简·奥斯汀的代表作。小说讲述了乡绅之女伊丽莎白·班内特的爱情故事。",    "pic":"傲慢与偏见.png"],
                   ["title":"《霍乱时期的爱情》",  "content":"《霍乱时期的爱情》是加西亚·马尔克斯获得诺贝尔文学奖后出版的第一部小说，讲述了一段跨越半个多世纪的爱情史诗，穷尽了所有爱情的可能性：忠贞的、隐秘的、粗暴的、羞怯的、柏拉图式的、放荡的、转瞬即逝的、生死相依的……再现了时光的无情流逝，被誉为“人类有史以来最伟大的爱情小说”，是20世纪最重要的经典文学巨著之一。",  "pic":"霍乱时期的爱情.png"]]
    
    
    let scrollView = UIScrollView(frame: CGRect(x:0, y:0, width:UIScreen.main.bounds.width,height: 230))
    var colors:[UIColor] = [UIColor.red, UIColor.blue, UIColor.green, UIColor.yellow]
    var frame: CGRect = CGRect(x:0, y:0, width:0, height:0)
    var pageControl : UIPageControl = UIPageControl(frame: CGRect(x:0,y: 180, width:UIScreen.main.bounds.width, height:50))

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        scrollView.delegate = self

        // scrollView 不回弹
        scrollView.bounces = false
        
        // 滚动时只能停留到某一页
        scrollView.isPagingEnabled = true
        
        // 关闭滚动显示条
        scrollView.showsHorizontalScrollIndicator = false
        
        self.view.addSubview(scrollView)
        
        
        for (seq,course) in courses.enumerated() {
            
            frame.origin.x = self.scrollView.frame.size.width * CGFloat(seq)
            frame.size = self.scrollView.frame.size
            
            let subView = UIImageView(frame: frame)
            //subView.backgroundColor = colors[index]
            subView.image = UIImage(named: course["pic"]!)
            //!.reSizeImage(reSize: reSize)
            self.scrollView .addSubview(subView)
        }
        
        self.scrollView.contentSize = CGSize(width:self.scrollView.frame.size.width * CGFloat(self.courses.count),height: self.scrollView.frame.size.height)
        pageControl.addTarget(self, action: #selector(self.changePage(sender:)), for: UIControlEvents.valueChanged)
        
        // 设置pageControl
        configurePageControl()
        
        // 设置页控件点击事件
        
    }
    
    func configurePageControl() {
        // The total number of pages that are available is based on how many available colors we have.
        self.pageControl.numberOfPages = courses.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.red
        self.pageControl.pageIndicatorTintColor = UIColor.black
        self.pageControl.currentPageIndicatorTintColor = UIColor.green
        self.view.addSubview(pageControl)
    }
    
    // MARK : TO CHANGE WHILE CLICKING ON PAGE CONTROL
    @objc func changePage(sender: AnyObject) -> () {
        let x = CGFloat(pageControl.currentPage) * scrollView.frame.size.width
        scrollView.setContentOffset(CGPoint(x:x, y:0), animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
    
    //颜色渐变
    func turquoiseColor() -> CAGradientLayer {
        let topColor = UIColor.clear
        let bottomColor = UIColor.black.withAlphaComponent(0.7)
        
        //let gradientColors: Array <AnyObject> = [topColor.cgColor, bottomColor.cgColor]
        let gradientColors = [topColor.cgColor, bottomColor.cgColor]
        
        //let gradientLocations: Array <AnyObject> = [0.0 as AnyObject, 1.0 as AnyObject]
        let gradientLocations:[NSNumber] = [0.0, 1.0]
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations as? [NSNumber]
        
        return gradientLayer
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

