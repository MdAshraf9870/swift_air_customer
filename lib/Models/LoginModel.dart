class LoginModel {
  LoginModel({
      this.status, 
      this.responseCode, 
      this.message, 
      this.customerId, 
      this.accessToken, 
      this.name, 
      this.orgid, 
      this.url, 
      this.phone, 
      this.houseNo, 
      this.street, 
      this.city, 
      this.state, 
      this.postcode, 
      this.country, 
      this.fromLat, 
      this.fromLong, 
      this.address, 
      this.active, 
      this.deviceid, 
      this.fcmToken, 
      this.otp, 
      this.appVer,});

  LoginModel.fromJson(dynamic json) {
    status = json['status'] ?? false;
    responseCode = json['responseCode'];
    message = json['message'];
    customerId = json['customerId'];
    accessToken = json['accessToken'];
    name = json['name'];
    orgid = json['orgid'];
    url = json['url'];
    phone = json['phone'];
    houseNo = json['house_no'];
    street = json['street'];
    city = json['city'];
    state = json['state'];
    postcode = json['postcode'];
    country = json['country'];
    fromLat = json['from_lat'];
    fromLong = json['from_long'];
    address = json['address'];
    active = json['active'];
    deviceid = json['deviceid'];
    fcmToken = json['fcm_token'];
    otp = json['otp'];
    appVer = json['app_ver'];
  }
  bool? status;
  int? responseCode;
  String? message;
  String? customerId;
  String? accessToken;
  String? name;
  String? orgid;
  String? url;
  String? phone;
  String? houseNo;
  String? street;
  String? city;
  String? state;
  String? postcode;
  String? country;
  String? fromLat;
  String? fromLong;
  String? address;
  String? active;
  String? deviceid;
  String? fcmToken;
  int? otp;
  String? appVer;



}