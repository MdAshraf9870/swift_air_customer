class OrderDetailsModel {
  OrderDetailsModel({
      this.orderId, 
      this.bookingDate, 
      this.deliveryDate, 
      this.senderName, 
      this.senderPhone, 
      this.fromLocation, 
      this.toLocation, 
      this.dropoffName, 
      this.dropoffPhone, 
      this.dropoffCompanyName, 
      this.priority, 
      this.priorityColour, 
      this.qty, 
      this.docType, 
      this.packetType, 
      this.packetClassify, 
      this.status, 
      this.statusCode, 
      this.specialInstructions, 
      this.createdAt, 
      this.fromLat, 
      this.fromLong, 
      this.toLat, 
      this.toLong, 
      this.driverName, 
      this.driverPhone, 
      this.driverEcode,});

  OrderDetailsModel.fromJson(dynamic json) {
    orderId = json['orderId'];
    bookingDate = json['booking_date'];
    deliveryDate = json['delivery_date'];
    senderName = json['sender_name'];
    senderPhone = json['sender_phone'];
    fromLocation = json['from_location'];
    toLocation = json['to_location'];
    dropoffName = json['dropoff_name'];
    dropoffPhone = json['dropoff_phone'];
    dropoffCompanyName = json['dropoff_company_name'];
    priority = json['priority'];
    priorityColour = json['priority_colour'];
    qty = json['qty'];
    docType = json['doc_type'];
    packetType = json['packet_type'];
    packetClassify = json['packet_classify'];
    status = json['status'];
    statusCode = json['status_code'];
    specialInstructions = json['special_instructions'];
    createdAt = json['created_at'];
    fromLat = json['from_lat'];
    fromLong = json['from_long'];
    toLat = json['to_lat'];
    toLong = json['to_long'];
    driverName = json['driver_name'];
    driverPhone = json['driver_phone'];
    driverEcode = json['driver_ecode'];
  }
  String? orderId;
  String? bookingDate;
  String? deliveryDate;
  String? senderName;
  String? senderPhone;
  String? fromLocation;
  String? toLocation;
  String? dropoffName;
  String? dropoffPhone;
  String? dropoffCompanyName;
  String? priority;
  String? priorityColour;
  String? qty;
  String? docType;
  String? packetType;
  String? packetClassify;
  String? status;
  String? statusCode;
  String? specialInstructions;
  String? createdAt;
  String? fromLat;
  String? fromLong;
  String? toLat;
  String? toLong;
  String? driverName;
  String? driverPhone;
  String? driverEcode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['orderId'] = orderId;
    map['booking_date'] = bookingDate;
    map['delivery_date'] = deliveryDate;
    map['sender_name'] = senderName;
    map['sender_phone'] = senderPhone;
    map['from_location'] = fromLocation;
    map['to_location'] = toLocation;
    map['dropoff_name'] = dropoffName;
    map['dropoff_phone'] = dropoffPhone;
    map['dropoff_company_name'] = dropoffCompanyName;
    map['priority'] = priority;
    map['priority_colour'] = priorityColour;
    map['qty'] = qty;
    map['doc_type'] = docType;
    map['packet_type'] = packetType;
    map['packet_classify'] = packetClassify;
    map['status'] = status;
    map['status_code'] = statusCode;
    map['special_instructions'] = specialInstructions;
    map['created_at'] = createdAt;
    map['from_lat'] = fromLat;
    map['from_long'] = fromLong;
    map['to_lat'] = toLat;
    map['to_long'] = toLong;
    map['driver_name'] = driverName;
    map['driver_phone'] = driverPhone;
    map['driver_ecode'] = driverEcode;
    return map;
  }

}