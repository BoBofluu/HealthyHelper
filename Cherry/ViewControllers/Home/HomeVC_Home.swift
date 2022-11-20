//
//  HomeVC_Home.swift
//  Cherry
//
//  Created by 李旻峰 on 2022/10/2.
//

import UIKit

class HomeVC_Home: BaseVC {
    
    private var m_scrollView: UIScrollView = UIScrollView()
    private var circleCount: Int = 4
    @IBOutlet weak var asd: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        initView()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // 重新配置
        m_scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
    }
    
    private func initView() {
        m_scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        // 主圈
        let outSideCircle: UIView = createMainCircle()
        // 小圈
        for i in 0..<circleCount {
            createSubCircle(seq: i, circle: outSideCircle)
        }
        // 計算滑動
        let mainCircleWidth = kSize_Screen.width - kMargin
        let subCircleWidth = kSize_Screen.width*0.25+kMargin
        m_scrollView.contentSize = CGSize(width: 0, height: mainCircleWidth + subCircleWidth*CGFloat(circleCount) + tabBarHeight)
        // 添加配置
        view.addSubview(m_scrollView)
    }
    
    /**
     製作最上面的圈圈
     */
    private func createMainCircle() -> UIView {

        // 外圈
        let outSideCircle = UIView()
        outSideCircle.frame = CGRect(x: 0.0, y: 0.0, width: kSize_Screen.width - kMargin*2, height: kSize_Screen.width - kMargin*2)
        outSideCircle.layer.cornerRadius = outSideCircle.frame.width / 2
        outSideCircle.alpha = 0.3
        outSideCircle.backgroundColor = .pink
        m_scrollView.addSubview(outSideCircle)

        outSideCircle.translatesAutoresizingMaskIntoConstraints = false
        outSideCircle.widthAnchor.constraint(equalToConstant: outSideCircle.frame.width).isActive = true
        outSideCircle.heightAnchor.constraint(equalToConstant: outSideCircle.frame.height).isActive = true
        outSideCircle.leadingAnchor.constraint(equalTo: m_scrollView.leadingAnchor, constant: kMargin).isActive = true
        outSideCircle.topAnchor.constraint(equalTo: m_scrollView.topAnchor, constant: kMargin).isActive = true

        // 內圈
        let inSideCircle = UIView()

        inSideCircle.frame = CGRect(x: 0, y: 0, width: kSize_Screen.width - kMargin*3, height: kSize_Screen.width - kMargin*3)
        inSideCircle.layer.cornerRadius = inSideCircle.frame.width / 2
        inSideCircle.backgroundColor = .white
        m_scrollView.addSubview(inSideCircle)

        inSideCircle.translatesAutoresizingMaskIntoConstraints = false
        inSideCircle.widthAnchor.constraint(equalToConstant: inSideCircle.frame.width).isActive = true
        inSideCircle.heightAnchor.constraint(equalToConstant: inSideCircle.frame.height).isActive = true
        inSideCircle.leadingAnchor.constraint(equalTo: outSideCircle.leadingAnchor, constant: kMargin*0.5).isActive = true
        inSideCircle.topAnchor.constraint(equalTo: outSideCircle.topAnchor, constant: kMargin*0.5).isActive = true
        
        return outSideCircle
    }
    /**
     製作第二個圈圈
     */
    private func createSubCircle(seq: Int, circle: UIView) {

        // 外圈
        let outSideCircle = UIView()
        outSideCircle.frame = CGRect(x: 0.0, y: 0.0, width: circle.frame.width*0.5, height: circle.frame.height*0.5)
        outSideCircle.layer.cornerRadius = outSideCircle.frame.width / 2
        outSideCircle.alpha = 0.3
        outSideCircle.backgroundColor = .pink
        m_scrollView.addSubview(outSideCircle)

        outSideCircle.translatesAutoresizingMaskIntoConstraints = false
        outSideCircle.widthAnchor.constraint(equalToConstant: outSideCircle.frame.width).isActive = true
        outSideCircle.heightAnchor.constraint(equalToConstant: outSideCircle.frame.height).isActive = true
        
        let width = circle.frame.width*0.25 + kMargin
        
        if seq == 0 {
            outSideCircle.leadingAnchor.constraint(equalTo: m_scrollView.leadingAnchor, constant: kMargin).isActive = true
            outSideCircle.topAnchor.constraint(equalTo: circle.bottomAnchor, constant: 0).isActive = true
        } else {
            if seq % 2 == 0 {
                outSideCircle.leadingAnchor.constraint(equalTo: m_scrollView.leadingAnchor, constant: kMargin).isActive = true
            } else {
                outSideCircle.trailingAnchor.constraint(equalTo: circle.trailingAnchor, constant: 0).isActive = true
            }
            outSideCircle.topAnchor.constraint(equalTo: circle.bottomAnchor, constant: width*(1+CGFloat(seq-1))).isActive = true
        }
        // 內圈
        let inSideCircle = UIView()

        inSideCircle.frame = CGRect(x: 0, y: 0, width: circle.frame.width*0.5 - kMargin, height: circle.frame.width*0.5 - kMargin)
        inSideCircle.layer.cornerRadius = inSideCircle.frame.width / 2
        inSideCircle.backgroundColor = .white
        m_scrollView.addSubview(inSideCircle)

        inSideCircle.translatesAutoresizingMaskIntoConstraints = false
        inSideCircle.widthAnchor.constraint(equalToConstant: inSideCircle.frame.width).isActive = true
        inSideCircle.heightAnchor.constraint(equalToConstant: inSideCircle.frame.height).isActive = true
        inSideCircle.leadingAnchor.constraint(equalTo: outSideCircle.leadingAnchor, constant: kMargin*0.5).isActive = true
        inSideCircle.topAnchor.constraint(equalTo: outSideCircle.topAnchor, constant: kMargin*0.5).isActive = true
        
    }
}
