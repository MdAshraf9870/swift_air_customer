/// id : "202"
/// phone : "9650979301"
/// name : "Md Ashraf"
/// first_name : null
/// last_name : null
/// orgid : "1976"
/// company : "Developerhub"
/// url : "swift.routplaner.com"
/// email : "mdashraf9870@gmail.com"
/// email_verify : "Verified"
/// house_no : "E 74 j j colony wazirpur "
/// street : "E 74 j j colony wazirpur "
/// city : "DELHI"
/// state : "DELHI"
/// postcode : "110052"
/// country : "India"
/// password : "22bf8feacaf4563ff63c9bc73fd7f06c"
/// pwd_string : "Md9870.com"
/// accessToken : "9692e698c0dbb1f7c6a78f1bbf2a9413"
/// deviceid : "aN9KLKAInJR"
/// fcm_token : "8rjfngjbjhbjh67gbjhbjhbjnjbjbbjbkkvdgdfgdfgfgfdgfdg"
/// otp : "5302"
/// otp_generated_at : "2022-12-07 09:09:52"
/// from_lat : "28.644720"
/// from_long : "77.200249"
/// source : "app"
/// app_ver : null
/// active : "1"
/// is_logged_in : "0"
/// registered_at : "2022-11-23 14:35:02"
/// last_login : "2022-12-07 09:09:52"

class ProfileModel {
  ProfileModel({
      this.id, 
      this.phone, 
      this.name, 
      this.firstName, 
      this.lastName, 
      this.orgid, 
      this.company, 
      this.url, 
      this.email, 
      this.emailVerify, 
      this.houseNo, 
      this.street, 
      this.city, 
      this.state, 
      this.postcode, 
      this.country, 
      this.password, 
      this.pwdString, 
      this.accessToken, 
      this.deviceid, 
      this.fcmToken, 
      this.otp, 
      this.otpGeneratedAt, 
      this.fromLat, 
      this.fromLong, 
      this.source, 
      this.appVer, 
      this.active, 
      this.isLoggedIn, 
      this.registeredAt, 
      this.lastLogin,});

  ProfileModel.fromJson(dynamic json) {
    id = json['id'];
    phone = json['phone'];
    name = json['name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    orgid = json['orgid'];
    company = json['company'];
    url = json['url'];
    email = json['email'];
    emailVerify = json['email_verify'];
    houseNo = json['house_no'];
    street = json['street'];
    city = json['city'];
    state = json['state'];
    postcode = json['postcode'];
    country = json['country'];
    password = json['password'];
    pwdString = json['pwd_string'];
    accessToken = json['accessToken'];
    deviceid = json['deviceid'];
    fcmToken = json['fcm_token'];
    otp = json['otp'];
    otpGeneratedAt = json['otp_generated_at'];
    fromLat = json['from_lat'];
    fromLong = json['from_long'];
    source = json['source'];
    appVer = json['app_ver'];
    active = json['active'];
    isLoggedIn = json['is_logged_in'];
    registeredAt = json['registered_at'];
    lastLogin = json['last_login'];
  }
  String? id;
  String? phone;
  String? name;
  dynamic firstName;
  dynamic lastName;
  String? orgid;
  String? company;
  String? url;
  String? email;
  String? emailVerify;
  String? houseNo;
  String? street;
  String? city;
  String? state;
  String? postcode;
  String? country;
  String? password;
  String? pwdString;
  String? accessToken;
  String? deviceid;
  String? fcmToken;
  String? otp;
  String? otpGeneratedAt;
  String? fromLat;
  String? fromLong;
  String? source;
  dynamic appVer;
  String? active;
  String? isLoggedIn;
  String? registeredAt;
  String? lastLogin;



}