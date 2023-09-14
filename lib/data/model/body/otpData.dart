class OtpData {
  String? code;
  String? otp;
  String? requestType;
  String? userName;

  OtpData({this.code, this.otp, this.requestType, this.userName});

  OtpData.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    otp = json['otp'];
    requestType = json['requestType'];
    userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['otp'] = this.otp;
    data['requestType'] = this.requestType;
    data['userName'] = this.userName;
    return data;
  }
}
