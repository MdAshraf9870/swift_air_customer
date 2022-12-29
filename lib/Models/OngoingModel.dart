class OngoingModel {
  OngoingModel({
    this.id,
    this.orderId,
    this.fromLocation,
    this.toLocation,
    this.priority,
    this.status,
    this.createdAt,
    this.bookingDate,
    this.priorityColour,
    this.fromLat,
    this.fromLong,
    this.toLat,
    this.toLong,
  });

  OngoingModel.fromJson(dynamic json) {
    id = json['id'];
    orderId = json['orderId'];
    fromLocation = json['from_location'];
    toLocation = json['to_location'];
    priority = json['priority'];
    status = json['status'];
    createdAt = json['created_at'];
    bookingDate = json['booking_date'];
    priorityColour = json['priority_colour'];
    fromLat = json['from_lat'];
    fromLong = json['from_long'];
    toLat = json['to_lat'];
    toLong = json['to_long'];
  }
  String? id;
  String? orderId;
  String? fromLocation;
  String? toLocation;
  String? priority;
  String? status;
  String? createdAt;
  String? bookingDate;
  String? priorityColour;
  String? fromLat;
  String? fromLong;
  String? toLat;
  String? toLong;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['orderId'] = orderId;
    map['from_location'] = fromLocation;
    map['to_location'] = toLocation;
    map['priority'] = priority;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['booking_date'] = bookingDate;
    map['priority_colour'] = priorityColour;
    map['from_lat'] = fromLat;
    map['from_long'] = fromLong;
    map['to_lat'] = toLat;
    map['to_long'] = toLong;
    return map;
  }
}
