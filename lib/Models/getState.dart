/// status : true
/// responseCode : 200
/// message : "City details loaded Successfully"
/// statedetails : [{"statecode":"DE","statename":"DELHI"},{"statecode":"HR","statename":"HARYANA"},{"statecode":"UP","statename":"UTTAR PRADESH"}]



/// statecode : "DE"
/// statename : "DELHI"

class GetState {

  GetState.fromJson(dynamic json) {
    statecode = json['statecode'];
    statename = json['statename'];
  }
  String? statecode;
  String? statename;

  GetState(this.statecode, this.statename);
}