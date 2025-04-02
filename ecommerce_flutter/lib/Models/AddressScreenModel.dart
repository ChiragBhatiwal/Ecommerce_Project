class AddressScreenModel {
  String? sId;
  String? username;
  String? title;
  String? userAddress;
  String? mobile;
  String? city;
  String? state;
  String? pincode;
  String? country;

  AddressScreenModel(
      {this.sId,
      this.title,
      this.username,
      this.mobile,
      this.userAddress,
      this.city,
      this.state,
      this.pincode,
      this.country});

  AddressScreenModel.fromJson(Map<String, dynamic> json) {
    sId = json["sId"];
    title = json["title"];
    userAddress = json["address"];
    mobile = json["mobileNumber"];
    username = json["username"];
    city = json["city"];
    state = json["state"];
    pincode = json["pincode"];
    country = json["country"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["sId"] = this.sId;
    data["title"] = this.title;
    data["address"] = this.userAddress;
    data["city"] = this.city;
    data["country"] = this.country;
    data["state"] = this.state;
    data["pincode"] = this.pincode;
    return data;
  }
}
