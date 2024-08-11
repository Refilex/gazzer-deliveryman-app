import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stackfood_multivendor_driver/common/widgets/custom_app_bar_widget.dart';
import 'package:stackfood_multivendor_driver/feature/order/controllers/order_controller.dart';
import 'package:stackfood_multivendor_driver/feature/order/widgets/history_order_widget.dart';
import 'package:stackfood_multivendor_driver/helper/custom_print_helper.dart';
import 'package:stackfood_multivendor_driver/util/dimensions.dart';
import 'package:stackfood_multivendor_driver/util/styles.dart';

class RunningOrderScreen extends StatefulWidget {
  const RunningOrderScreen({super.key});

  @override
  State<RunningOrderScreen> createState() => _RunningOrderScreenState();
}

class _RunningOrderScreenState extends State<RunningOrderScreen> {
  int _selectedIndex = 0; // Initially set to 0 for "Active order"
  final List<String> excludedStatuses = [
    'Active order',
    'Delivered',
    'Failed',
    'Canceled',
    'Refund requested',
    'Refunded',
    'Refund request canceled'
  ];

  @override
  void initState() {
    super.initState();
    // Fetch initial data for "Active order" when screen first loads
    Get.find<OrderController>().getCurrentOrders();
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    final OrderController orderController = Get.find<OrderController>();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (orderController.completedOrderList != null &&
            !orderController.paginate) {
          int pageSize = (orderController.pageSize! / 10).ceil();
          if (orderController.offset < pageSize) {
            orderController.setOffset(orderController.offset + 1);
            customPrint('end of the page');
            orderController.showBottomLoader();
            orderController
                .getCurrentOrders(); // Ensure this gets called for pagination
          }
        }
      }
    });

    return Scaffold(
      appBar: CustomAppBarWidget(title: 'running_orders'.tr),
      body: GetBuilder<OrderController>(builder: (orderController) {
        return Column(
          children: [
            // Status Tabs...
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SizedBox(
                height: 25,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: excludedStatuses.length,
                  padding:
                      const EdgeInsets.only(left: Dimensions.paddingSizeLarge),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    String category = excludedStatuses[index];
                    return InkWell(
                      onTap: () async {
                        if (excludedStatuses[index] == "Active order") {
                          await Get.find<OrderController>().getCurrentOrders();
                        } else {
                          await orderController.getCompletedOrders(
                              1, _getOrderStatusCode(excludedStatuses[index]));
                        }
                        setState(() {
                          _selectedIndex =
                              index; // Update _selectedIndex with setState
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingSizeSmall,
                            vertical: Dimensions.paddingSizeExtraSmall),
                        margin: const EdgeInsets.only(
                            right: Dimensions.paddingSizeSmall),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radiusDefault),
                          color: _selectedIndex == index
                              ? Theme.of(context).dialogBackgroundColor
                              : Colors.transparent,
                        ),
                        child: Center(
                          child: Text(
                            category,
                            style: _selectedIndex == index
                                ? robotoMedium.copyWith(
                                    fontSize: Dimensions.fontSizeSmall,
                                    color: Theme.of(context).primaryColor)
                                : robotoRegular.copyWith(
                                    fontSize: Dimensions.fontSizeSmall),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            // Conditional view based on selected status...
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  if (excludedStatuses[_selectedIndex] == "Active order") {
                    await orderController.getCurrentOrders();
                  } else {
                    await orderController.getCompletedOrders(1,
                        _getOrderStatusCode(excludedStatuses[_selectedIndex]));
                  }
                },
                child: SingleChildScrollView(
                  controller: scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Center(
                    child: SizedBox(
                      width: 1170,
                      child: Column(
                        children: [
                          // Display Active Order view or Completed Orders view based on selectedIndex
                          if (excludedStatuses[_selectedIndex] ==
                              "Active order")
                            _buildActiveOrderView(orderController)
                          else
                            _buildOrderListView(orderController),
                          if (orderController.paginate)
                            const Center(
                              child: Padding(
                                padding:
                                    EdgeInsets.all(Dimensions.paddingSizeSmall),
                                child: CircularProgressIndicator(),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  // Helper method to get order status code
  String _getOrderStatusCode(String status) {
    switch (status) {
      case 'Delivered':
        return 'delivered';
      case 'Failed':
        return 'failed';
      case 'Canceled':
        return 'canceled';
      case 'Refund requested':
        return 'refund_requested';
      case 'Refunded':
        return 'refunded';
      case 'Refund request canceled':
        return 'refund_request_canceled';
      default:
        return '';
    }
  }

  // Widget for displaying active orders
  Widget _buildActiveOrderView(OrderController orderController) {
    return orderController.currentOrderList != null &&
            orderController.currentOrderList!.isNotEmpty
        ? ListView.builder(
            padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      itemCount: orderController.currentOrderList!.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return HistoryOrderWidget(
                orderModel: orderController.currentOrderList![index],
                isRunning: true,
                index: index,
              );
            },
          )
        : Center(child: Text('no_active_orders_found'.tr));
  }

  // Widget for displaying completed orders
  Widget _buildOrderListView(OrderController orderController) {
    return orderController.completedOrderList != null &&
            orderController.completedOrderList!.isNotEmpty
        ? ListView.builder(
            padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      itemCount: orderController.completedOrderList!.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return HistoryOrderWidget(
                orderModel: orderController.completedOrderList![index],
                isRunning: false,
                index: index,
              );
            },
          )
        : Center(child: Text('no_completed_orders_found'.tr));
  }
}
