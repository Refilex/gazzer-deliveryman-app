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
  int _selectedIndex = 0;
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
    Get.find<OrderController>().getCurrentOrders();
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    final OrderController orderController = Get.find<OrderController>();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          orderController.completedOrderList != null &&
          !orderController.paginate) {
        int pageSize = (orderController.pageSize! / 10).ceil();
        if (orderController.offset < pageSize) {
          orderController.setOffset(orderController.offset + 1);
          customPrint('end of the page');
          orderController.showBottomLoader();
          orderController.getCurrentOrders();
        }
      }
    });

    return Scaffold(
      appBar: CustomAppBarWidget(title: 'running_orders'.tr),
      body: GetBuilder<OrderController>(builder: (orderController) {
        return Column(
          children: [
            // Status Tabs
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
                          Get.find<OrderController>().getCurrentOrders();
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
            // Conditional view based on selected status
            Expanded(
              child: orderController.completedOrderList != null
                  ? orderController.completedOrderList!.isNotEmpty
                      ? RefreshIndicator(
                          onRefresh: () async {
                            await orderController.getCurrentOrders();
                          },
                          child: SingleChildScrollView(
                            controller: scrollController,
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: Center(
                              child: SizedBox(
                                width: 1170,
                                child: Column(
                                  children: [
                                    if (excludedStatuses[_selectedIndex] ==
                                        "Active order")
                                      _buildActiveOrderView(orderController)
                                    else
                                      _buildOrderListView(orderController),
                                    orderController.paginate
                                        ? const Center(
                                            child: Padding(
                                              padding: EdgeInsets.all(
                                                  Dimensions.paddingSizeSmall),
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          )
                                        : const SizedBox(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      : Center(child: Text('no_order_found'.tr))
                  : const Center(child: CircularProgressIndicator()),
            ),
          ],
        );
      }),
    );
  }

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

  Widget _buildActiveOrderView(OrderController orderController) {
    // Custom widget for "Active order"
    return ListView.builder(
      padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      itemCount: orderController.currentOrderList!.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return HistoryOrderWidget(
            orderModel: orderController.currentOrderList![index],
            isRunning: true,
            index: index);
      },
    );
  }

  Widget _buildOrderListView(OrderController orderController) {
    return ListView.builder(
      padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      itemCount: orderController.completedOrderList!.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return HistoryOrderWidget(
            orderModel: orderController.completedOrderList![index],
            isRunning: false,
            index: index);
      },
    );
  }
}
