//
//  EditTypeVC.swift
//  Cherry
//
//  Created by systex systex on 2023/1/13.
//

import UIKit
import CoreData

class EditTypeVC: BasePushVC, NSFetchedResultsControllerDelegate {
    /// 種類 支出 or 收入
    internal var recordType: RecordType = RecordType.pay
    
    /// 類型選單
    @IBOutlet weak var tvType: UITableView!
    /// 類型的cell ID
    private var cellIdentifier = "PlusTypeTVCell"
    
    /// Table的資料陣列
    private var aryData: [String] = []
    /// 搜尋後結果
    private var muaryData: NSMutableArray = []

    /// Core Data
    private let context = AppDelegate.shared!.persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationTitle = LString("EditTypeVC:Title")
        
        initTableView()
        
        switch recordType {
        case .pay:
            initPayData()
        case .income:
            initIncomeData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Dprint("viewWillAppear")
    }

    /// 初始化TableView
    private func initTableView() {
        tvType.delegate = self
        tvType.dataSource = self
        tvType.register(EditTypeTVCell.loadFromNib(),forCellReuseIdentifier: cellIdentifier)
        tvType.rowHeight = 60
        tvType.isEditing = true
    }
    
    /// 初始化支出資料
    private func initPayData() {
        let payRequest: NSFetchRequest<PAY_TYPE_CUS> = PAY_TYPE_CUS.fetchRequest()
        let sort = NSSortDescriptor(key: "order_seq", ascending: true)
        payRequest.sortDescriptors = [sort]
        
        let FETCH_PAY_TYPE_CUS = NSFetchedResultsController(fetchRequest: payRequest,
                                                            managedObjectContext: context,
                                                            sectionNameKeyPath: nil,
                                                            cacheName: nil)
        FETCH_PAY_TYPE_CUS.delegate = self
        
        do{
            try FETCH_PAY_TYPE_CUS.performFetch()
            if let objs = FETCH_PAY_TYPE_CUS.fetchedObjects {
                for obj in objs {
                    aryData.append(obj.type_name ?? "")
                }
                muaryData.addObjects(from: aryData)
                tvType.reloadData()
                print("支出 \(aryData)")
            }
        } catch let fetchError{
            print("Failed \(fetchError)")
        }
    }
    
    /// 初始化收入資料
    private func initIncomeData() {
        let incomeRequest: NSFetchRequest<INCOME_TYPE_CUS> = INCOME_TYPE_CUS.fetchRequest()
        let sort = NSSortDescriptor(key: "order_seq", ascending: true)
        incomeRequest.sortDescriptors = [sort]
        
        let FETCH_INCOME_TYPE_CUS = NSFetchedResultsController(fetchRequest: incomeRequest,
                                                               managedObjectContext: context,
                                                               sectionNameKeyPath: nil,
                                                               cacheName: nil)
        FETCH_INCOME_TYPE_CUS.delegate = self
        
        do{
            try FETCH_INCOME_TYPE_CUS.performFetch()
            if let objs = FETCH_INCOME_TYPE_CUS.fetchedObjects {
                for obj in objs {
                    aryData.append(obj.type_name ?? "")
                }
                muaryData.addObjects(from: aryData)
                print("收入 \(aryData)")
            }
        } catch let fetchError{
            print("Failed \(fetchError)")
        }
    }
    
    /// 更新資料 - 原來的位置, 後來的位置
    private func updateData(sourceIndex: Int, destinationIndex: Int) {
        muaryData.exchangeObject(at: sourceIndex, withObjectAt: destinationIndex)

        switch recordType {
        case .pay:
            fetchUpdate(request: PAY_TYPE_CUS.fetchRequest(), sourceIndex: sourceIndex, destinationIndex: destinationIndex)
        case .income:
            fetchUpdate(request: INCOME_TYPE_CUS.fetchRequest(), sourceIndex: sourceIndex, destinationIndex: destinationIndex)
        }
    }
    
    /// 更新資料
    private func fetchUpdate<T: NSManagedObject>(request: NSFetchRequest<T>, sourceIndex: Int, destinationIndex: Int) {
        let sort = NSSortDescriptor(key: "order_seq", ascending: true)
        request.sortDescriptors = [sort]
        let sourcePredicate = NSPredicate(format: "order_seq == %i", sourceIndex+1)
        let destinationPredicate = NSPredicate(format: "order_seq == %i", destinationIndex+1)
        request.predicate = NSCompoundPredicate(type: .or, subpredicates: [sourcePredicate, destinationPredicate])
        
        let FETCH_UPDATE = NSFetchedResultsController(fetchRequest: request,
                                                      managedObjectContext: context,
                                                      sectionNameKeyPath: nil,
                                                      cacheName: nil)
        do {
            try FETCH_UPDATE.performFetch()
            if let objs = FETCH_UPDATE.fetchedObjects {
                for obj in objs {
                    switch recordType {
                    case .pay:
                        if (obj as! PAY_TYPE_CUS).order_seq == sourceIndex+1 {
                            (obj as! PAY_TYPE_CUS).order_seq = Int16(destinationIndex+1)
                        } else if (obj as! PAY_TYPE_CUS).order_seq == destinationIndex+1 {
                            (obj as! PAY_TYPE_CUS).order_seq = Int16(sourceIndex+1)
                        } else {
                            Dprint("No Match Data")
                        }
                    case .income:
                        if (obj as! INCOME_TYPE_CUS).order_seq == sourceIndex+1 {
                            (obj as! INCOME_TYPE_CUS).order_seq = Int16(destinationIndex+1)
                        } else if (obj as! INCOME_TYPE_CUS).order_seq == destinationIndex+1 {
                            (obj as! INCOME_TYPE_CUS).order_seq = Int16(sourceIndex+1)
                        } else {
                            Dprint("No Match Data")
                        }
                    }
                }
            }
            try context.save()
        } catch let error {
            print("Failed to 更新 \(error)")
        }
    }
    
    /// 刪除資料
    private func deleteData(tableView: UITableView, indexPath: IndexPath) {
        self.aryData.remove(at: indexPath.row)
        self.muaryData.removeObject(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
        
        switch recordType {
        case .pay:
            fetchDelete(request: PAY_TYPE_CUS.fetchRequest(), indexPath: indexPath)
        case .income:
            fetchDelete(request: INCOME_TYPE_CUS.fetchRequest(), indexPath: indexPath)
        }
    }
    
    /// 刪除方法 - 共用
    private func fetchDelete<T: NSManagedObject>(request: NSFetchRequest<T>, indexPath: IndexPath) {
        let sort = NSSortDescriptor(key: "order_seq", ascending: true)
        request.sortDescriptors = [sort]
        request.predicate = NSPredicate(format: "order_seq == %i", indexPath.row+1)
        
        let FETCH_DALETE = NSFetchedResultsController(fetchRequest: request,
                                                  managedObjectContext: context,
                                                  sectionNameKeyPath: nil,
                                                  cacheName: nil)
        
        do {
            try FETCH_DALETE.performFetch()
            if let objs = FETCH_DALETE.fetchedObjects {
                context.delete(objs[0])
                Dprint(objs)
            }
            try context.save()
        } catch let error {
            print("Failed to 刪除 \(error)")
        }
        
        let updateSort = NSSortDescriptor(key: "order_seq", ascending: true)
        request.sortDescriptors = [updateSort]
        request.predicate = NSPredicate(format: "order_seq > %i", indexPath.row+1)
        let FETCH_UPDATE = NSFetchedResultsController(fetchRequest: request,
                                                      managedObjectContext: context,
                                                      sectionNameKeyPath: nil,
                                                      cacheName: nil)
        do {
            try FETCH_UPDATE.performFetch()
            if let objs = FETCH_UPDATE.fetchedObjects {
                for obj in objs {
                    switch recordType {
                    case .pay:
                        (obj as! PAY_TYPE_CUS).order_seq = (obj as! PAY_TYPE_CUS).order_seq - 1
                    case .income:
                        (obj as! INCOME_TYPE_CUS).order_seq = (obj as! INCOME_TYPE_CUS).order_seq - 1
                    }
                }
            }
            try context.save()
        } catch let error {
            print("Failed to 刪除 \(error)")
        }
    }
    
    /// 點擊 新增類型
    @IBAction func doClickPlus(_ sender: Any) {
        pushVC(vc: PlusTypeVC())
    }
}

// MARK: ‼️
extension EditTypeVC: UITableViewDataSource , UITableViewDelegate {
    // MARK: 以下為設置cell的資訊
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return muaryData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! EditTypeTVCell
        cell.configureCell(indexPath: indexPath, aryData: aryData)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    // MARK: 以下為拖曳方法
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        Dprint("arr: \(muaryData)")
        updateData(sourceIndex: (sourceIndexPath as NSIndexPath).row,
                   destinationIndex: (destinationIndexPath as NSIndexPath).row)
        Dprint("arr: \(muaryData)")
    }
    // MARK: 以下為刪除方法
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return LString("EditTypeVC:Delete")
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = UIAlertController(title: LString("EditTypeVC:DeleteTitle"),
                                          message: LString("EditTypeVC:DeleteMessage"),
                                          preferredStyle: .alert)

            let cancelAction = UIAlertAction(title: LString("Base:Cancel"), style: .cancel) { _ in
                Dprint("Cancel")
            }
            alert.addAction(cancelAction)

            let okAction = UIAlertAction(title: LString("Base:Confirm"), style: .default) { _ in
                Dprint("Confirm, \(indexPath.row)")
                self.deleteData(tableView: tableView, indexPath: indexPath)
            }
            alert.addAction(okAction)

            present(alert, animated: true, completion: nil)
        }
    }
}
