class ProfileModel {
  int? id;
  String? fName;
  String? lName;
  String? phone;
  String? email;
  String? identityNumber;
  String? identityType;
  String? identityImage;
  String? image;
  String? fcmToken;
  int? zoneId;
  int? active;
  double? avgRating;
  int? ratingCount;
  int? memberSinceDays;
  int? orderCount;
  int? todaysOrderCount;
  int? thisWeekOrderCount;
  double? cashInHands;
  int? earnings;
  String? type;
  double? balance;
  double? todaysEarning;
  double? thisWeekEarning;
  double? thisMonthEarning;
  String? createdAt;
  String? updatedAt;
  double? totalIncentiveEarning;
  String? shiftName;
  String? shiftStartTime;
  String? shiftEndTime;
  List<IncentiveList>? incentiveList;
  double? payableBalance;
  bool? adjustable;
  bool? overFlowWarning;
  bool? overFlowBlockWarning;
  double? withDrawableBalance;
  double? totalWithdrawn;
  bool? showPayNowButton;

  ProfileModel({
    this.id,
    this.fName,
    this.lName,
    this.phone,
    this.email,
    this.identityNumber,
    this.identityType,
    this.identityImage,
    this.image,
    this.fcmToken,
    this.zoneId,
    this.active,
    this.avgRating,
    this.memberSinceDays,
    this.orderCount,
    this.todaysOrderCount,
    this.thisWeekOrderCount,
    this.cashInHands,
    this.ratingCount,
    this.createdAt,
    this.updatedAt,
    this.earnings,
    this.type,
    this.balance,
    this.todaysEarning,
    this.thisWeekEarning,
    this.thisMonthEarning,
    this.totalIncentiveEarning,
    this.shiftName,
    this.shiftStartTime,
    this.shiftEndTime,
    this.incentiveList,
    this.payableBalance,
    this.adjustable,
    this.overFlowWarning,
    this.overFlowBlockWarning,
    this.withDrawableBalance,
    this.totalWithdrawn,
    this.showPayNowButton,
  });

  ProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fName = json['f_name'];
    lName = json['l_name'];
    phone = json['phone'];
    email = json['email'];
    identityNumber = json['identity_number'];
    identityType = json['identity_type'];
    identityImage = json['identity_image'];
    image = json['image'];
    fcmToken = json['fcm_token'];
    zoneId = json['zone_id'];
    active = json['active'];
    avgRating = json['avg_rating']?.toDouble();
    ratingCount = json['rating_count'];
    memberSinceDays = json['member_since_days'];
    orderCount = json['order_count'];
    todaysOrderCount = json['todays_order_count'];
    thisWeekOrderCount = json['this_week_order_count'];
    cashInHands = json['cash_in_hands']?.toDouble();
    earnings = json['earning'];
    type = json['type'];
    balance = json['balance']?.toDouble();
    todaysEarning = json['todays_earning']?.toDouble();
    thisWeekEarning = json['this_week_earning']?.toDouble();
    thisMonthEarning = json['this_month_earning']?.toDouble();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    totalIncentiveEarning = json['total_incentive_earning']?.toDouble();
    shiftName = json['shift_name'];
    shiftStartTime = json['shift_start_time'];
    shiftEndTime = json['shift_end_time'];
    if (json['incentive_list'] != null) {
      incentiveList = <IncentiveList>[];
      json['incentive_list'].forEach((v) {
        incentiveList!.add(IncentiveList.fromJson(v));
      });
    }
    payableBalance = json['Payable_Balance']?.toDouble();
    adjustable = json['adjust_able'];
    overFlowWarning = json['over_flow_warning'];
    overFlowBlockWarning = json['over_flow_block_warning'];
    withDrawableBalance = json['withdraw_able_balance']?.toDouble();
    totalWithdrawn = json['total_withdrawn']?.toDouble();
    showPayNowButton = json['show_pay_now_button'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['f_name'] = fName;
    data['l_name'] = lName;
    data['phone'] = phone;
    data['email'] = email;
    data['identity_number'] = identityNumber;
    data['identity_type'] = identityType;
    data['identity_image'] = identityImage;
    data['image'] = image;
    data['fcm_token'] = fcmToken;
    data['zone_id'] = zoneId;
    data['active'] = active;
    data['avg_rating'] = avgRating;
    data['rating_count'] = ratingCount;
    data['member_since_days'] = memberSinceDays;
    data['order_count'] = orderCount;
    data['todays_order_count'] = todaysOrderCount;
    data['this_week_order_count'] = thisWeekOrderCount;
    data['cash_in_hands'] = cashInHands;
    data['earning'] = earnings;
    data['balance'] = balance;
    data['type'] = type;
    data['todays_earning'] = todaysEarning;
    data['this_week_earning'] = thisWeekEarning;
    data['this_month_earning'] = thisMonthEarning;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['total_incentive_earning'] = totalIncentiveEarning;
    data['shift_name'] = shiftName;
    if (incentiveList != null) {
      data['incentive_list'] = incentiveList!.map((v) => v.toJson()).toList();
    }
    data['Payable_Balance'] = payableBalance;
    data['adjust_able'] = adjustable;
    data['over_flow_warning'] = overFlowWarning;
    data['over_flow_block_warning'] = overFlowBlockWarning;
    data['withdraw_able_balance'] = withDrawableBalance;
    data['total_withdrawn'] = totalWithdrawn;
    data['show_pay_now_button'] = showPayNowButton;
    return data;
  }
}

class IncentiveList {
  int? id;
  int? zoneId;
  double? earning;
  double? incentive;
  String? createdAt;
  String? updatedAt;

  IncentiveList({
    this.id,
    this.zoneId,
    this.earning,
    this.incentive,
    this.createdAt,
    this.updatedAt,
  });

  IncentiveList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    zoneId = json['zone_id'];
    earning = json['earning']?.toDouble();
    incentive = json['incentive']?.toDouble();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['zone_id'] = zoneId;
    data['earning'] = earning;
    data['incentive'] = incentive;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
