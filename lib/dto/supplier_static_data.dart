import 'package:food4good_app/utils/constants.dart';

class SupplierStaticDataDTO {
  String address;
  String restName;
  String openHours;

  SupplierStaticDataDTO({this.address, this.restName, this.openHours});

  factory SupplierStaticDataDTO.fromJson(Map<String, dynamic> jsonItem) {
    return SupplierStaticDataDTO(
      address: jsonItem[Constants.KEY_STRING_ADDRESS],
      restName: jsonItem[Constants.KEY_SUPPLIER_NAME],
      openHours:
          jsonItem[Constants.KEY_OPEN_HOURS_SUPPLIER_ADMIN], //need to be fixed - convert map open_hours to string
    );
  }

  Map toJson() => {
        Constants.KEY_ADDRESS_AS_STRING: address != null ? address : "",
        Constants.KEY_NAME: restName != null ? restName : "",
        Constants.KEY_OPEN_HOURS_SUPPLIER_ADMIN: openHours != null ? openHours : "",
      };
}
