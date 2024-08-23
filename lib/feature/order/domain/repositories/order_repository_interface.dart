import 'package:gazzer_delivery/api/api_client.dart';
import 'package:gazzer_delivery/feature/order/domain/models/ignore_model.dart';
import 'package:gazzer_delivery/feature/order/domain/models/update_status_body.dart';
import 'package:gazzer_delivery/interface/repository_interface.dart';

abstract class OrderRepositoryInterface implements RepositoryInterface {
  Future<dynamic> getCompletedOrderList(int offset, String orderStatus);

  Future<dynamic> getCurrentOrders();

  Future<dynamic> getLatestOrders();

  Future<dynamic> updateOrderStatus(
      UpdateStatusBody updateStatusBody, List<MultipartBody> proofAttachment);

  Future<dynamic> getOrderDetails(int? orderID);

  Future<dynamic> acceptOrder(int? orderID);

  void setIgnoreList(List<IgnoreModel> ignoreList);

  List<IgnoreModel> getIgnoreList();

  Future<dynamic> getOrderWithId(int? orderId);

  Future<dynamic> getCancelReasons();
}
