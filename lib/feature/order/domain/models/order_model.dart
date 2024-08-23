import 'dart:convert';

class PaginatedOrderModel {
  int? totalSize;
  String? limit;
  String? offset;
  List<OrderModel>? orders;

  PaginatedOrderModel({this.totalSize, this.limit, this.offset, this.orders});

  PaginatedOrderModel.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'];
    limit = json['limit'].toString();
    offset = json['offset'].toString();
    if (json['orders'] != null) {
      orders = [];
      json['orders'].forEach((v) {
        orders!.add(OrderModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_size'] = totalSize;
    data['limit'] = limit;
    data['offset'] = offset;
    if (orders != null) {
      data['orders'] = orders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderModel {
  int? id;
  int? userId;
  double? orderAmount;
  double? couponDiscountAmount;
  String? paymentStatus;
  String? orderStatus;
  double? totalTaxAmount;
  String? paymentMethod;
  String? transactionReference;
  int? deliveryAddressId;
  int? deliveryManId;
  String? orderType;
  int? restaurantId;
  String? createdAt;
  String? updatedAt;
  double? deliveryCharge;
  double? originalDeliveryCharge;
  double? dmTips;
  String? scheduleAt;
  String? restaurantName;
  double? restaurantDiscountAmount;
  String? restaurantAddress;
  String? restaurantLat;
  String? restaurantLng;
  String? restaurantLogo;
  String? restaurantPhone;
  String? restaurantDeliveryTime;
  int? vendorId;
  int? detailsCount;
  String? orderNote;
  DeliveryAddress? deliveryAddress;
  Customer? customer;
  int? processingTime;
  int? chatPermission;
  String? restaurantModel;
  bool? cutlery;
  String? unavailableItemNote;
  String? deliveryInstruction;
  List<String>? orderProof;
  List<Payments>? payments;
  double? storeDiscountAmount;
  bool? taxStatus;
  double? additionalCharge;
  double? extraPackagingAmount;
  double? referrerBonusAmount;
  List<Restaurant>? restaurants;
  String? couponCode;

  OrderModel({
    this.id,
    this.userId,
    this.orderAmount,
    this.couponDiscountAmount,
    this.paymentStatus,
    this.orderStatus,
    this.totalTaxAmount,
    this.paymentMethod,
    this.transactionReference,
    this.deliveryAddressId,
    this.deliveryManId,
    this.orderType,
    this.restaurantId,
    this.createdAt,
    this.updatedAt,
    this.deliveryCharge,
    this.originalDeliveryCharge,
    this.dmTips,
    this.scheduleAt,
    this.restaurantName,
    this.restaurantDiscountAmount,
    this.restaurantAddress,
    this.restaurantLat,
    this.restaurantLng,
    this.restaurantLogo,
    this.restaurantPhone,
    this.restaurantDeliveryTime,
    this.vendorId,
    this.detailsCount,
    this.orderNote,
    this.deliveryAddress,
    this.customer,
    this.processingTime,
    this.chatPermission,
    this.restaurantModel,
    this.cutlery,
    this.unavailableItemNote,
    this.deliveryInstruction,
    this.orderProof,
    this.payments,
    this.storeDiscountAmount,
    this.taxStatus,
    this.additionalCharge,
    this.extraPackagingAmount,
    this.referrerBonusAmount,
    this.restaurants,
      this.couponCode});

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    orderAmount = json['order_amount']?.toDouble();
    couponDiscountAmount = json['coupon_discount_amount']?.toDouble();
    paymentStatus = json['payment_status'];
    orderStatus = json['order_status'];
    totalTaxAmount = json['total_tax_amount']?.toDouble();
    paymentMethod = json['payment_method'];
    transactionReference = json['transaction_reference'];
    deliveryAddressId = json['delivery_address_id'];
    deliveryManId = json['delivery_man_id'];
    orderType = json['order_type'];
    restaurantId = json['restaurant_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deliveryCharge = json['delivery_charge']?.toDouble();
    originalDeliveryCharge = json['original_delivery_charge']?.toDouble();
    dmTips = json['dm_tips']?.toDouble();
    scheduleAt = json['schedule_at'];
    restaurantName = json['restaurant_name'];
    restaurantDiscountAmount = json['restaurant_discount_amount']?.toDouble();
    restaurantAddress = json['restaurant_address'];
    restaurantLat = json['restaurant_lat'];
    restaurantLng = json['restaurant_lng'];
    restaurantLogo = json['restaurant_logo'];
    restaurantPhone = json['restaurant_phone'];
    restaurantDeliveryTime = json['restaurant_delivery_time'];
    vendorId = json['vendor_id'];
    detailsCount = json['details_count'];
    orderNote = json['order_note'];
    deliveryAddress = json['delivery_address'] != null
        ? DeliveryAddress.fromJson(json['delivery_address'])
        : null;
    customer =
        json['customer'] != null ? Customer.fromJson(json['customer']) : null;
    processingTime = json['processing_time'];
    chatPermission = json['chat_permission'];
    restaurantModel = json['restaurant_model'];
    cutlery = json['cutlery'];
    unavailableItemNote = json['unavailable_item_note'];
    deliveryInstruction = json['delivery_instruction'];
    if (json['order_proof'] != null && json['order_proof'] != "null") {
      if (json['order_proof'].toString().startsWith('[')) {
        orderProof = [];
        if (json['order_proof'] is String) {
          jsonDecode(json['order_proof']).forEach((v) {
            orderProof!.add(v);
          });
        } else {
          json['order_proof'].forEach((v) {
            orderProof!.add(v);
          });
        }
      } else {
        orderProof = [];
        orderProof!.add(json['order_proof'].toString());
      }
    }
    if (json['payments'] != null) {
      payments = <Payments>[];
      json['payments'].forEach((v) {
        payments!.add(Payments.fromJson(v));
      });
    }
    storeDiscountAmount = json['restaurant_discount']?.toDouble();
    taxStatus = json['tax_status'] == 'included' ? true : false;
    additionalCharge = json['additional_charge']?.toDouble() ?? 0;
    extraPackagingAmount = json['extra_packaging_amount']?.toDouble();
    referrerBonusAmount = json['ref_bonus_amount']?.toDouble();
    couponCode = json['coupon_code'];

    restaurants = (json['restaurants'] as List?)
        ?.map((item) => Restaurant.fromJson(item))
        .toList() ?? [];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['order_amount'] = orderAmount;
    data['coupon_discount_amount'] = couponDiscountAmount;
    data['payment_status'] = paymentStatus;
    data['order_status'] = orderStatus;
    data['total_tax_amount'] = totalTaxAmount;
    data['payment_method'] = paymentMethod;
    data['transaction_reference'] = transactionReference;
    data['delivery_address_id'] = deliveryAddressId;
    data['delivery_man_id'] = deliveryManId;
    data['order_type'] = orderType;
    data['restaurant_id'] = restaurantId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['delivery_charge'] = deliveryCharge;
    data['original_delivery_charge'] = originalDeliveryCharge;
    data['dm_tips'] = dmTips;
    data['schedule_at'] = scheduleAt;
    data['restaurant_name'] = restaurantName;
    data['restaurant_discount_amount'] = restaurantDiscountAmount;
    data['restaurant_address'] = restaurantAddress;
    data['restaurant_lat'] = restaurantLat;
    data['restaurant_lng'] = restaurantLng;
    data['restaurant_logo'] = restaurantLogo;
    data['restaurant_phone'] = restaurantPhone;
    data['restaurant_delivery_time'] = restaurantDeliveryTime;
    data['vendor_id'] = vendorId;
    data['details_count'] = detailsCount;
    data['order_note'] = orderNote;
    if (deliveryAddress != null) {
      data['delivery_address'] = deliveryAddress!.toJson();
    }
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    data['processing_time'] = processingTime;
    data['chat_permission'] = chatPermission;
    data['restaurant_model'] = restaurantModel;
    data['cutlery'] = cutlery;
    data['unavailable_item_note'] = unavailableItemNote;
    data['delivery_instruction'] = deliveryInstruction;
    data['order_proof'] = orderProof;
    if (payments != null) {
      data['payments'] = payments!.map((v) => v.toJson()).toList();
    }
    data['store_discount_amount'] = storeDiscountAmount;
    data['additional_charge'] = additionalCharge;
    data['extra_packaging_amount'] = extraPackagingAmount;
    data['ref_bonus_amount'] = referrerBonusAmount;
    data['restaurants'] = restaurants;
    data['coupon_code'] = couponCode;
    return data;
  }
}

class DeliveryAddress {
  int? id;
  String? addressType;
  String? contactPersonNumber;
  String? address;
  String? latitude;
  String? longitude;
  int? userId;
  String? contactPersonName;
  String? createdAt;
  String? updatedAt;
  int? zoneId;
  String? streetNumber;
  String? house;
  String? floor;

  DeliveryAddress({
    this.id,
    this.addressType,
    this.contactPersonNumber,
    this.address,
    this.latitude,
    this.longitude,
    this.userId,
    this.contactPersonName,
    this.createdAt,
    this.updatedAt,
    this.zoneId,
    this.streetNumber,
    this.house,
    this.floor,
  });

  DeliveryAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    addressType = json['address_type'];
    contactPersonNumber = json['contact_person_number'];
    address = json['address'];
    latitude = json['latitude'].toString();
    longitude = json['longitude'].toString();
    userId = json['user_id'];
    contactPersonName = json['contact_person_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    zoneId = json['zone_id'];
    streetNumber = json['road'];
    house = json['house'];
    floor = json['floor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['address_type'] = addressType;
    data['contact_person_number'] = contactPersonNumber;
    data['address'] = address;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['user_id'] = userId;
    data['contact_person_name'] = contactPersonName;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['zone_id'] = zoneId;
    data['road'] = streetNumber;
    data['house'] = house;
    data['floor'] = floor;
    return data;
  }
}

class Customer {
  int? id;
  String? fName;
  String? lName;
  String? phone;
  String? email;
  String? image;
  String? createdAt;
  String? updatedAt;
  String? cmFirebaseToken;

  Customer({
    this.id,
    this.fName,
    this.lName,
    this.phone,
    this.email,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.cmFirebaseToken,
  });

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fName = json['f_name'];
    lName = json['l_name'];
    phone = json['phone'];
    email = json['email'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    cmFirebaseToken = json['cm_firebase_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['f_name'] = fName;
    data['l_name'] = lName;
    data['phone'] = phone;
    data['email'] = email;
    data['image'] = image;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['cm_firebase_token'] = cmFirebaseToken;
    return data;
  }
}

class Payments {
  int? id;
  int? orderId;
  double? amount;
  String? paymentStatus;
  String? paymentMethod;
  String? createdAt;
  String? updatedAt;

  Payments({
    this.id,
    this.orderId,
    this.amount,
    this.paymentStatus,
    this.paymentMethod,
    this.createdAt,
    this.updatedAt,
  });

  Payments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    amount = json['amount']?.toDouble();
    paymentStatus = json['payment_status'];
    paymentMethod = json['payment_method'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_id'] = orderId;
    data['amount'] = amount;
    data['payment_status'] = paymentStatus;
    data['payment_method'] = paymentMethod;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Restaurant {
  int id;
  String name;
  String phone;
  String email;
  String logo;
  String latitude;
  String longitude;
  String address;
  dynamic footerText;
  int minimumOrder;
  int? comission;
  bool scheduleOrder;
  dynamic openingTime;
  dynamic closeingTime;
  int status;
  int vendorId;
  DateTime createdAt;
  DateTime updatedAt;
  bool freeDelivery;
  List<int> rating;
  String coverPhoto;
  bool delivery;
  bool takeAway;
  bool foodSection;
  int tax;
  int zoneId;
  dynamic categoryId;
  bool reviewsSection;
  bool active;
  String offDay;
  int selfDeliverySystem;
  bool posSystem;
  int minimumShippingCharge;
  String deliveryTime;
  int veg;
  int nonVeg;
  int orderCount;
  int totalOrder;
  dynamic perKmShippingCharge;
  String restaurantModel;
  dynamic maximumShippingCharge;
  String slug;
  bool orderSubscriptionActive;
  bool cutlery;
  dynamic metaTitle;
  dynamic metaDescription;
  dynamic metaImage;
  int announcement;
  dynamic announcementMessage;
  dynamic qrCode;
  dynamic additionalData;
  dynamic additionalDocuments;
  bool gstStatus;
  String gstCode;
  bool freeDeliveryDistanceStatus;
  String freeDeliveryDistanceValue;

  Restaurant({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.logo,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.footerText,
    required this.minimumOrder,
    required this.comission,
    required this.scheduleOrder,
    required this.openingTime,
    required this.closeingTime,
    required this.status,
    required this.vendorId,
    required this.createdAt,
    required this.updatedAt,
    required this.freeDelivery,
    required this.rating,
    required this.coverPhoto,
    required this.delivery,
    required this.takeAway,
    required this.foodSection,
    required this.tax,
    required this.zoneId,
    required this.categoryId,
    required this.reviewsSection,
    required this.active,
    required this.offDay,
    required this.selfDeliverySystem,
    required this.posSystem,
    required this.minimumShippingCharge,
    required this.deliveryTime,
    required this.veg,
    required this.nonVeg,
    required this.orderCount,
    required this.totalOrder,
    required this.perKmShippingCharge,
    required this.restaurantModel,
    required this.maximumShippingCharge,
    required this.slug,
    required this.orderSubscriptionActive,
    required this.cutlery,
    required this.metaTitle,
    required this.metaDescription,
    required this.metaImage,
    required this.announcement,
    required this.announcementMessage,
    required this.qrCode,
    required this.additionalData,
    required this.additionalDocuments,
    required this.gstStatus,
    required this.gstCode,
    required this.freeDeliveryDistanceStatus,
    required this.freeDeliveryDistanceValue,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        logo: json["logo"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        address: json["address"],
        footerText: json["footer_text"],
        minimumOrder: json["minimum_order"],
        comission: json["comission"],
        scheduleOrder: json["schedule_order"],
        openingTime: json["opening_time"],
        closeingTime: json["closeing_time"],
        status: json["status"],
        vendorId: json["vendor_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        freeDelivery: json["free_delivery"],
        rating: List<int>.from(json["rating"].map((x) => x)),
        coverPhoto: json["cover_photo"],
        delivery: json["delivery"],
        takeAway: json["take_away"],
        foodSection: json["food_section"],
        tax: json["tax"],
        zoneId: json["zone_id"],
        categoryId: json["category_id"],
        reviewsSection: json["reviews_section"],
        active: json["active"],
        offDay: json["off_day"],
        selfDeliverySystem: json["self_delivery_system"],
        posSystem: json["pos_system"],
        minimumShippingCharge: json["minimum_shipping_charge"],
        deliveryTime: json["delivery_time"],
        veg: json["veg"],
        nonVeg: json["non_veg"],
        orderCount: json["order_count"],
        totalOrder: json["total_order"],
        perKmShippingCharge: json["per_km_shipping_charge"],
        restaurantModel: json["restaurant_model"],
        maximumShippingCharge: json["maximum_shipping_charge"],
        slug: json["slug"],
        orderSubscriptionActive: json["order_subscription_active"],
        cutlery: json["cutlery"],
        metaTitle: json["meta_title"],
        metaDescription: json["meta_description"],
        metaImage: json["meta_image"],
        announcement: json["announcement"],
        announcementMessage: json["announcement_message"],
        qrCode: json["qr_code"],
        additionalData: json["additional_data"],
        additionalDocuments: json["additional_documents"],
        gstStatus: json["gst_status"],
        gstCode: json["gst_code"],
        freeDeliveryDistanceStatus: json["free_delivery_distance_status"],
        freeDeliveryDistanceValue: json["free_delivery_distance_value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "email": email,
        "logo": logo,
        "latitude": latitude,
        "longitude": longitude,
        "address": address,
        "footer_text": footerText,
        "minimum_order": minimumOrder,
        "comission": comission,
        "schedule_order": scheduleOrder,
        "opening_time": openingTime,
        "closeing_time": closeingTime,
        "status": status,
        "vendor_id": vendorId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "free_delivery": freeDelivery,
        "rating": List<dynamic>.from(rating.map((x) => x)),
        "cover_photo": coverPhoto,
        "delivery": delivery,
        "take_away": takeAway,
        "food_section": foodSection,
        "tax": tax,
        "zone_id": zoneId,
        "category_id": categoryId,
        "reviews_section": reviewsSection,
        "active": active,
        "off_day": offDay,
        "self_delivery_system": selfDeliverySystem,
        "pos_system": posSystem,
        "minimum_shipping_charge": minimumShippingCharge,
        "delivery_time": deliveryTime,
        "veg": veg,
        "non_veg": nonVeg,
        "order_count": orderCount,
        "total_order": totalOrder,
        "per_km_shipping_charge": perKmShippingCharge,
        "restaurant_model": restaurantModel,
        "maximum_shipping_charge": maximumShippingCharge,
        "slug": slug,
        "order_subscription_active": orderSubscriptionActive,
        "cutlery": cutlery,
        "meta_title": metaTitle,
        "meta_description": metaDescription,
        "meta_image": metaImage,
        "announcement": announcement,
        "announcement_message": announcementMessage,
        "qr_code": qrCode,
        "additional_data": additionalData,
        "additional_documents": additionalDocuments,
        "gst_status": gstStatus,
        "gst_code": gstCode,
        "free_delivery_distance_status": freeDeliveryDistanceStatus,
        "free_delivery_distance_value": freeDeliveryDistanceValue,
      };
}
