import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stackfood_multivendor_driver/common/widgets/custom_app_bar_widget.dart';
import 'package:stackfood_multivendor_driver/feature/order/controllers/order_controller.dart';
import 'package:stackfood_multivendor_driver/feature/order/widgets/history_order_widget.dart';
import 'package:stackfood_multivendor_driver/helper/custom_print_helper.dart';
import 'package:stackfood_multivendor_driver/util/dimensions.dart';
import 'package:stackfood_multivendor_driver/util/styles.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  int _selectedIndex = 0;
  final List<String> excludedStatuses = [
    'delivered'.tr,
    'failed'.tr,
    'canceled'.tr,
    'refund_requested'.tr,
    'refunded'.tr,
    'refund_request_canceled'.tr
  ];

  @override
  void initState() {
    super.initState();
    Get.find<OrderController>().getCompletedOrders(1, "delivered");
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
          orderController.getCompletedOrders(
              orderController.offset, "delivered");
        }
      }
    });

    return Scaffold(
      appBar:
          CustomAppBarWidget(title: 'my_orders'.tr, isBackButtonExist: false),
      body: GetBuilder<OrderController>(builder: (orderController) {
        return Column(
          children: [
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
                        if (excludedStatuses[index] == 'delivered'.tr) {
                          await orderController.getCompletedOrders(
                              1, "delivered");
                        }
                        if (excludedStatuses[index] == 'failed'.tr) {
                          await orderController.getCompletedOrders(1, "failed");
                        }
                        if (excludedStatuses[index] == 'canceled'.tr) {
                          await orderController.getCompletedOrders(
                              1, "canceled");
                        }
                        if (excludedStatuses[index] == 'refund_requested'.tr) {
                          await orderController.getCompletedOrders(
                              1, "refund_requested");
                        }
                        if (excludedStatuses[index] == 'refunded'.tr) {
                          await orderController.getCompletedOrders(
                              1, "refunded");
                        }
                        if (excludedStatuses[index] ==
                            'refund_request_canceled'.tr) {
                          await orderController.getCompletedOrders(
                              1, "refund_request_canceled");
                        }
                        _selectedIndex =
                            index; // Update _selectedIndex directly
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
            // List of orders
            Expanded(
              child: orderController.completedOrderList != null
                  ? orderController.completedOrderList!.isNotEmpty
                      ? RefreshIndicator(
                          onRefresh: () async {
                            await orderController.getCompletedOrders(
                                1, "delivered");
                          },
                          child: SingleChildScrollView(
                            controller: scrollController,
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: Center(
                              child: SizedBox(
                                width: 1170,
                                child: Column(
                                  children: [
                                    ListView.builder(
                                      padding: const EdgeInsets.all(
                                          Dimensions.paddingSizeSmall),
                                      itemCount: orderController
                                          .completedOrderList!.length,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return HistoryOrderWidget(
                                            orderModel: orderController
                                                .completedOrderList![index],
                                            isRunning: false,
                                            index: index);
                                      },
                                    ),
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
}
