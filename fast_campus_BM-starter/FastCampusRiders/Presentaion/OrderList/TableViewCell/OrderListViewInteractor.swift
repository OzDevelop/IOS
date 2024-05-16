//
//  OrderListViewInteractor.swift
//  FastCampusRiders
//
//  Created by 변상필 on 5/16/24.
//

import UIKit
import MBAkit

class OrderListViewInteractor {
    
    struct OrderListInfo {
        let title: String
        let orderListDelegate: OrderListDelegate
    }
    
    private var timer: Timer?
    private var selectedIndex: Int = 0
    private(set) var orderListDelegate: [OrderListInfo] = []
    var currentOrderListDelegate: OrderListDelegate? {
        return self.orderListDelegate[safe: self.selectedIndex]?.orderListDelegate
    }
}

extension OrderListViewInteractor: ViewInteractorConfigurable {
    typealias VC = OrderListViewController

    func handleMessage(_ interactionMessage: VC.IM) {
        switch interactionMessage {
            case .updateOrderList(let dataList, let categoryView, let vc):
                self.processOrderListData(dataList, on: vc)
                    .updateMenuView(categoryView)
                    .currentOrderListDelegate?
                    .update(viewController: vc)
                self.stopUpdatingtimeSensitiveUI()

            case .selectIndex(let index, let vc):
                self.selectOrderList(index: index)
                    .currentOrderListDelegate?
                    .update(viewController: vc)

            case .suspendTimer:
                self.startUpdatingTimeSensitiveUI()
            case .resumeTimer:
                self.stopUpdatingtimeSensitiveUI()
        }
    }
}
