import 'package:food4good_app/utils/constants.dart';

class SupplierInfoDTO {
  String restName;
  String restId;
  String cost;
  String discount;
  String numOfDishes;
  String description;
  String distance;
  num numOfLikes;
  bool isMyFavorite;
  String range;
  String pickupHour;
  String address;
  String backgroundImage;
  String logoImage;
  String amount;
  String rangeFrom;
  String rangeTo;
  String productId;
  String productName;
  String longitude;
  String latitude;
  String maxNumOfDishes;
  String originalPrice;

  SupplierInfoDTO(
      {this.restName,
      this.restId,
      this.logoImage,
      this.backgroundImage,
      this.cost,
      this.discount,
      this.numOfDishes,
      this.address,
      this.description,
      this.distance,
      this.numOfLikes,
      this.isMyFavorite,
      this.range,
      this.pickupHour,
      this.amount,
      this.rangeFrom,
      this.rangeTo,
      this.productId,
      this.productName,
      this.longitude,
      this.latitude,
      this.maxNumOfDishes,
      this.originalPrice});

  factory SupplierInfoDTO.fromJson(Map<String, dynamic> jsonItem) {
    var product = _getFirstProduct(jsonItem);
    var _discount = product[Constants.KEY_DISCOUNT].toString();

    SupplierInfoDTO supplierInfoDTO = SupplierInfoDTO(
        restName: jsonItem[Constants.KEY_SUPPLIER_NAME],
        restId: jsonItem[Constants.KEY_ID].toString(),
        address: jsonItem[Constants.KEY_ADDRESS],
        backgroundImage: isNullEmpty(jsonItem[Constants.KEY_BG_IMAGE]) ? "" : jsonItem[Constants.KEY_BG_IMAGE],
        logoImage: isNullEmpty(jsonItem[Constants.KEY_LOGO_IMAGE]) ? "" : jsonItem[Constants.KEY_LOGO_IMAGE],
        cost: product[Constants.KEY_FIXED_PRICE] == null
            ? convertPriceToPresentation(product[Constants.KEY_MAX_PRICE])
            : convertPriceToPresentation(product[Constants.KEY_FIXED_PRICE]),
        range: product[Constants.KEY_FIXED_PRICE] == null
            ? "${convertPriceToPresentation(product[Constants.KEY_MIN_PRICE])}-${convertPriceToPresentation(product[Constants.KEY_MAX_PRICE])}"
            : convertPriceToPresentation(product[Constants.KEY_FIXED_PRICE]),
        description: product[Constants.KEY_DISH_DESCRIPTION],
        numOfDishes: product[Constants.KEY_AMOUNT].toString(),
        longitude: jsonItem[Constants.KEY_LONGITUDE],
        latitude: jsonItem[Constants.KEY_LATITUDE],
        pickupHour: openHour(jsonItem[Constants.KEY_OPEN_HOURS_SUPPLIER_ADMIN]),
        discount: getDiscount(_discount),
        distance: jsonItem[Constants.KEY_DISTANCE],
        numOfLikes: jsonItem[Constants.KEY_RATES] == null ? 0 : int.parse(jsonItem[Constants.KEY_RATES]),
        isMyFavorite: jsonItem[Constants.KEY_USER_FAVORITE],
        productId: product[Constants.KEY_ID].toString(),
        productName: product[Constants.KEY_DISH_NAME],
        originalPrice: product[Constants.KEY_ORIGINAL_PRICE],
        //NEW
        maxNumOfDishes: product[Constants.KEY_MAX_NUM_OF_DISHES],
        //NEW
        rangeFrom: convertPriceToPresentation(product[Constants.KEY_MIN_PRICE]),
        rangeTo: convertPriceToPresentation(product[Constants.KEY_MAX_PRICE]));
    //"${jsonItem['discount']}

    return supplierInfoDTO;
  }

  static String convertPriceToPresentation(String price) {
    if (isNullEmpty(price)) {
      return "0";
    }
    return double.parse(price).round().toString();
  }

  static String openHour(Map<String, dynamic> openHours) {
    DateTime currentDate = new DateTime.now();
    int newDateFormat = currentDate.weekday;
    String dayTime = newDateFormat.toString();
    if (!isNullEmpty(openHours) && !isNullEmpty(openHours[dayTime])) {
      return openHours[dayTime];
    }
    return "";
  }

  static getDiscount(String discount) {
    if (_isNumeric(discount)) {
      return discount;
    } else
      return "%%";
  }

  void setDistance(double distance) {}

  @override
  String toString() {
    var stringBuffer = StringBuffer();
    stringBuffer.write("restName: ");
    stringBuffer.write(this.restName);
    stringBuffer.write(", restId: ");
    stringBuffer.write(this.restId);
    stringBuffer.write(", cost: ");
    stringBuffer.write(this.cost);
    stringBuffer.write(",discount: ");
    stringBuffer.write(this.discount);
    stringBuffer.write(", numOfDishes: ");
    stringBuffer.write(this.numOfDishes);
    stringBuffer.write(", address: ");
    stringBuffer.write(this.address);
    stringBuffer.write(",description: ");
    stringBuffer.write(this.description);
    stringBuffer.write(",distance: ");
    stringBuffer.write(this.distance);
    stringBuffer.write(",numOfLikes: ");
    stringBuffer.write(this.numOfLikes);
    stringBuffer.write(",isMyFavorite: ");
    stringBuffer.write(this.isMyFavorite);
    stringBuffer.write(",range: ");
    stringBuffer.write(this.range);
    stringBuffer.write(",pickupHour: ");
    stringBuffer.write(this.pickupHour);

    return stringBuffer.toString();
  }

  static bool isNullEmpty(Object o) => o == null || "" == o;

  static bool _isNumeric(String str) {
    if (isNullEmpty(str) || str == 'Infinity') {
      return false;
    }
    return double.tryParse(str) != null && double.tryParse(str) != double.infinity;
  }

  static bool isHourNull(String h) => h == null;

  static Map<String, dynamic> _getFirstProduct(Map<String, dynamic> jsonItem) {
    if (isNullEmpty(jsonItem['productDTOList']) || jsonItem['productDTOList'].length < 1) {
      return {};
    }
    return jsonItem['productDTOList'][0];
  }

  int compareTo(SupplierInfoDTO other) {
    int thisDestinationInt = isNullEmpty(distance) ? 0 : getIntDestination(distance);
    int otherDestinationInt = isNullEmpty(other.distance) ? 0 : getIntDestination(other.distance);
    return thisDestinationInt.compareTo(otherDestinationInt);
  }

  int getIntDestination(String distance) {
    //for KM distance
    if (distance.contains("km")) {
      double destination = double.parse(distance.split("km")[0].trim());
      return (destination * 1000).round();
    }
    if (distance.contains("ק\"מ")) {
      double destination = double.parse(distance.split("ק\"מ")[0].trim());
      return (destination * 1000).round();
    }
    //for meter distance
    if (distance.contains("m")) {
      int destination = int.parse(distance.split("m")[0].trim());
      return destination;
    }
    if (distance.contains("מ'")) {
      int destination = int.parse(distance.split("מ'")[0].trim());
      return destination;
    }
  }

  Map toJson() => {
        Constants.KEY_AMOUNT: numOfDishes,
        Constants.KEY_AVAILABLE_DISH_AMOUNT: amount,
        Constants.KEY_DISCOUNT: discount,
        Constants.KEY_DISH_DESCRIPTION: description,
        Constants.KEY_DISH_NAME: productName,
        Constants.KEY_FIX_PRICE: cost,
        Constants.KEY_ID: productId,
        Constants.KEY_MAX_NUM_OF_DISHES: maxNumOfDishes,
        Constants.KEY_MAX_PRICE: rangeTo,
        Constants.KEY_MIN_PRICE: rangeFrom,
        Constants.KEY_ORIGINAL_PRICE: originalPrice,
      };
}
