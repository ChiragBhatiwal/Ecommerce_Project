class AddressModel {
  String? addressId;
  String? address;
  String? pincode;
  String? state;
  String? city;
  String? country;

  AddressModel({
    required this.addressId,
    required this.address,
    required this.pincode,
    required this.state,
    required this.city,
    required this.country,
  });

  AddressModel.fromJson(Map<String, dynamic> json) {
    addressId = json["_id"];
    address = json["address"];
    pincode = json["pincode"];
    state = json["state"];
    city = json["city"];
    country = json["country"];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data["_id"] = this.addressId;
    data["address"] = this.address;
    data["pincode"] = this.pincode;
    data["state"] = this.state;
    data["city"] = this.city;
    data["country"] = this.country;
    return data;
  }
}
