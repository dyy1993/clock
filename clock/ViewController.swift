//
//  ViewController.swift
//  clock
//
//  Created by KEKE on 15/12/24.
//  Copyright © 2015年 dyy. All rights reserved.
//

import UIKit
// 每秒秒针转6度
let perSecendA : CGFloat = 6

// 每分钟分针转6度
let perMinuteA : CGFloat = 6

// 每小时时针转30度
let perHourA : CGFloat  = 30

// 每分钟时针转6度
let perMinuteHourA : CGFloat = 0.5

func angle2radian(x : CGFloat) ->CGFloat{
    return (x / 180.0 * CGFloat(M_PI))
}
class ViewController: UIViewController {
    
    
    @IBOutlet weak var clockVIew: UIImageView!
    var second : CALayer?
    var minute : CALayer?
    var hour :CALayer?
    override func viewDidLoad() {
        super.viewDidLoad()

        addSecond()
        addMintue()
        addhour()
        
        // 创建定时器
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "update", userInfo: nil, repeats: true )
        
        update()
        

    }
    //添加时针
    func addhour(){
    
        let imageW : CGFloat = self.clockVIew.bounds.size.width
        let imageH : CGFloat = self.clockVIew.bounds.size.height
        
        let hour : CALayer = CALayer()
        hour.anchorPoint = CGPointMake(0.5, 1)
        hour.position = CGPointMake(imageW * 0.5, imageH * 0.5)
        hour.bounds = CGRectMake(0, 0, 4, imageH * 0.5 - 50);
        hour.backgroundColor = UIColor.blackColor().CGColor
        hour.cornerRadius    = 4
        
        self.clockVIew.layer.addSublayer(hour)
        self.hour = hour
        
    }
    //添加分针
    func addMintue(){
        
        let imageW : CGFloat = self.clockVIew.bounds.size.width
        let imageH : CGFloat = self.clockVIew.bounds.size.height
        let minute : CALayer = CALayer()
        minute.anchorPoint = CGPointMake(0.5, 1)
        minute.position  = CGPointMake(imageW * 0.5,  imageH * 0.5)
        minute.bounds = CGRectMake(0, 0, 2, imageH * 0.5 - 30)
        minute.backgroundColor = UIColor.redColor().CGColor;
        self.clockVIew.layer.addSublayer(minute)
        self.minute = minute
    }
    //添加秒针
    func addSecond(){
    
        let imageW : CGFloat = self.clockVIew.bounds.size.width
        let imageH : CGFloat = self.clockVIew.bounds.size.height
        let second : CALayer = CALayer()
        second.anchorPoint = CGPointMake(0.5, 1)
        second.position  = CGPointMake(imageW * 0.5,  imageH * 0.5)
        second.bounds = CGRectMake(0, 0, 1, imageH * 0.5 - 20)
        second.backgroundColor = UIColor.redColor().CGColor;
        self.clockVIew.layer.addSublayer(second)
        self.second = second
    }
    
    func update(){
    
        // 获取秒数
        // 获取日历对象
        let calendar : NSCalendar = NSCalendar.currentCalendar()
    
        // 获取日期组件
//        let options : NSCalendarUnit =  .Second | .Minute | .Hour
        let compoents : NSDateComponents = calendar.components(NSCalendarUnit(arrayLiteral: .Hour,.Minute,.Second), fromDate: NSDate())
   
        // 获取秒数
        let sec :  Int = compoents.second;
        
        // 获取分钟
        let minute  :Int = compoents.minute;
        
        // 获取小时
        let hour : Int = compoents.hour;
        
        
        // 算出秒针旋转多少°
        let secondA  : CGFloat = CGFloat(sec) * perSecendA;
        
        // 算出分针旋转多少°
  
        let minuteA  : CGFloat = CGFloat(minute) * perMinuteA;
        
        // 算出时针旋转多少°
        
        var hourA  : CGFloat = CGFloat(hour) * perHourA;
        hourA += CGFloat(minute) * perMinuteHourA;
        
        // 旋转秒针
        self.second!.transform = CATransform3DMakeRotation(angle2radian(secondA), 0, 0, 1);
        
        // 旋转分针
        self.minute!.transform = CATransform3DMakeRotation(angle2radian(minuteA), 0, 0, 1);
        
        // 旋转时针
        self.hour!.transform = CATransform3DMakeRotation(angle2radian(hourA), 0, 0, 1);
    }

}


