//
//  ListVC_Home.swift
//  Cherry
//
//  Created by 李旻峰 on 2022/10/2.
//

import UIKit
import FSCalendar
import SwiftDate
import SwifterSwift
import Then
import SnapKit

class ListVC_Home: BaseVC {
    
    /// 年份
    @IBOutlet weak var lYear: UILabel!
    
    /// 月份
    @IBOutlet weak var lMonth: UILabel!
    
    /// 行事曆
    @IBOutlet weak var vCalendar: UIView!
    private let gregorian = Calendar(identifier: .gregorian)
    /// 行事曆
    private lazy var calendar = FSCalendar().then {
        $0.delegate = self
        $0.dataSource = self
        $0.today = nil
        $0.scope = .month
        $0.headerHeight = 0
        $0.placeholderType = .none
        $0.locale = Locale(identifier: Locale.preferredLanguages[0])
        $0.appearance.selectionColor = .pink
        $0.appearance.weekdayTextColor = .pink
        $0.appearance.titleFont = UIFont(name: "Hannotate TC Bold", size: 16)!
        $0.appearance.weekdayFont = UIFont(name: "Hannotate TC Bold", size: 16)!
//        $0.appearance.eventOffset = CGPoint(x: 0, y: -5)
        $0.appearance.eventDefaultColor = .pink
        $0.appearance.eventSelectionColor = .clear
        $0.appearance.borderRadius = 15
    }
    
    /// 記帳紀錄
    @IBOutlet weak var tvTableView: UITableView!
    private let cellIdentifier = "ListTVCell"
    private let headerIdentifier = "ListTVHeader"
    private var tapDate: String = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initCalendarView()
        initTableView()
    }
    
    /// 設定行事曆
    private func initCalendarView() {
        calendar.select(Date())
        lYear.text = calendar.currentPage.year.string
        lMonth.text = calendar.currentPage.month.string
        
        vCalendar.addSubview(calendar)
        calendar.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(260)
        }
    }
    
    /// 設定紀錄TableView
    private func initTableView() {
        tvTableView.delegate = self
        tvTableView.dataSource = self
        tvTableView.clipsToBounds = true
        tvTableView.register(ListTVHeader.loadFromNib(),forHeaderFooterViewReuseIdentifier: headerIdentifier)
        tvTableView.register(ListTVCell.loadFromNib(),forCellReuseIdentifier: cellIdentifier)
    }
    
    // MARK: 點擊方法
    
    /// 點擊上個月
    @IBAction func doClickLast(_ sender: Any) {
        if let next = gregorian.date(byAdding: .month, value: -1, to: calendar.currentPage) {
            calendar.setCurrentPage(next, animated: true)
        }
    }
    
    /// 點擊下個月
    @IBAction func doClickNext(_ sender: Any) {
        if let next = gregorian.date(byAdding: .month, value: 1, to: calendar.currentPage) {
            calendar.setCurrentPage(next, animated: true)
        }
    }
    
}

extension ListVC_Home: FSCalendarDelegate, FSCalendarDataSource {
    /**
     更改行事曆的高度
     */
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendar.height = bounds.height
        self.view.layoutIfNeeded()
    }
    /**
     行事曆換月份的時候
     */
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {

        lYear.text = calendar.currentPage.year.string
        lMonth.text = calendar.currentPage.month.string
    }
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        print(date.stringValue(dDateFormatSimple))
        return 1
    }
    /**
     點選日期的時候
     */
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        Dprint("選擇: \(date.stringValue(dDateFormatSimple))")
        tapDate = date.stringValue(dDateFormatSimple)
        tvTableView.reloadData()
    }
}

extension ListVC_Home: UITableViewDelegate, UITableViewDataSource {
    /**
     總共幾個Header
     */
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    /**
     Header的高
     */
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 90
    }
    /**
     Header的視窗
     */
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerIdentifier) as! ListTVHeader
        header.lIncome.text = tapDate.numberFormatUnit()
        header.lPay.text = tapDate.numberFormatUnit()
        
        if true {
            header.lTotal.textColor = .systemGreen
        } else {
            header.lTotal.textColor = .systemRed
        }
        header.lTotal.text = "48763".numberFormatUnit()
        
        return header
    }
    /**
     Footer的高
     */
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    /**
     Footer的視窗
     */
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    /**
     設置Row個數
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    /**
     設置Row的高
     */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    /**
     繪製cell的線
     */
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cell.selectionStyle = .none
    }
    /**
     繪製cell
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! ListTVCell
//        cell.configureCell(indexPath: indexPath, rsp: m_aryInvoice)
        return cell
    }
    /**
     點擊Cell
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Dprint("Cell: \(indexPath.row)")
        pushVC(vc: ListUpdateMoneyVC())
    }
}
