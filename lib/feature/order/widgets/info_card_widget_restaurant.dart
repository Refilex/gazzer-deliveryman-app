import 'package:stackfood_multivendor_driver/common/widgets/custom_image_widget.dart';
import 'package:stackfood_multivendor_driver/feature/order/domain/models/order_model.dart';
import 'package:stackfood_multivendor_driver/feature/splash/controllers/splash_controller.dart';
import 'package:stackfood_multivendor_driver/util/dimensions.dart';
import 'package:stackfood_multivendor_driver/util/styles.dart';
import 'package:stackfood_multivendor_driver/common/widgets/custom_snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

class InfoCardWidgetRestaurant extends StatelessWidget {
  final bool showButton;
  final Restaurant? restaurant;
  final Function? messageOnTap;

  const InfoCardWidgetRestaurant(
      {super.key,
      required this.showButton,
      this.restaurant,
      this.messageOnTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
        boxShadow: [
          BoxShadow(
              color: Colors.grey[Get.isDarkMode ? 800 : 200]!,
              spreadRadius: 1,
              blurRadius: 5)
        ],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(height: Dimensions.paddingSizeSmall),
        Text(restaurant!.name,
            style: robotoRegular.copyWith(
                fontSize: Dimensions.fontSizeSmall,
                color: Theme.of(context).disabledColor)),
        const SizedBox(height: Dimensions.paddingSizeSmall),
        (restaurant!.name != null && restaurant!.name!.isNotEmpty)
            ? Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                ClipOval(
                    child: CustomImageWidget(
                  image:
                      '${Get.find<SplashController>().configModel!.baseUrls!.restaurantImageUrl}/${restaurant!.logo}',
                  height: 40,
                  width: 40,
                  fit: BoxFit.cover,
                )),
                const SizedBox(width: Dimensions.paddingSizeSmall),
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Text(restaurant!.name!,
                          style: robotoRegular.copyWith(
                              fontSize: Dimensions.fontSizeSmall)),
                      const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                      showButton
                          ? Row(children: [
                              TextButton.icon(
                                onPressed: () async {
                                  if (await canLaunchUrlString(
                                      'tel:${restaurant!.phone}')) {
                                    launchUrlString('tel:${restaurant!.phone}',
                                        mode: LaunchMode.externalApplication);
                                  } else {
                                    showCustomSnackBar(
                                        'invalid_phone_number_found');
                                  }
                                },
                                icon: Icon(Icons.call,
                                    color: Theme.of(context).primaryColor,
                                    size: 20),
                                label: Text(
                                  'call'.tr,
                                  style: robotoRegular.copyWith(
                                      fontSize: Dimensions.fontSizeSmall,
                                      color: Theme.of(context).primaryColor),
                                ),
                              ),
                              TextButton.icon(
                                onPressed: messageOnTap as void Function()?,
                                icon: Icon(Icons.chat_rounded,
                                    color: Theme.of(context).primaryColor,
                                    size: 20),
                                label: Text(
                                  'message'.tr,
                                  style: robotoRegular.copyWith(
                                      fontSize: Dimensions.fontSizeSmall,
                                      color: Theme.of(context).primaryColor),
                                ),
                              ),
                              TextButton.icon(
                                onPressed: () async {
                                  String url =
                                      'https://www.google.com/maps/dir/?api=1&destination=${restaurant!.latitude},${restaurant!.longitude}&mode=d';
                                  if (await canLaunchUrlString(url)) {
                                    await launchUrlString(url,
                                        mode: LaunchMode.externalApplication);
                                  } else {
                                    throw '${'could_not_launch'.tr} $url';
                                  }
                                },
                                icon: Icon(Icons.directions,
                                    color: Theme.of(context).disabledColor,
                                    size: 20),
                                label: Text(
                                  'direction'.tr,
                                  style: robotoRegular.copyWith(
                                      fontSize: Dimensions.fontSizeSmall,
                                      color: Theme.of(context).disabledColor),
                                ),
                              ),
                            ])
                          :
                          const SizedBox(
                              height: Dimensions.paddingSizeExtraLarge),
                    ])),


              ])
            : Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: Dimensions.paddingSizeSmall),
                  child: Text('no_restaurant_data_found'.tr,
                      style: robotoRegular.copyWith(
                          fontSize: Dimensions.fontSizeSmall)),
                ),
              ),
      ]),
    );
  }
}
