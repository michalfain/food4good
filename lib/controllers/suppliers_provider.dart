//import 'package:flutter_is_emulator/flutter_is_emulator.dart';
import 'package:food4good_app/controllers/base_rest_controller.dart';
import 'package:food4good_app/dto/user_location.dart';
import 'package:food4good_app/dto/response.dart';
import 'package:food4good_app/dto/supplier_info.dart';
import 'package:food4good_app/utils/logger.dart';
import 'package:food4good_app/widgets/supplier_item.dart';
import 'package:geolocation/geolocation.dart';
//import 'package:location/location.dart';

class SuppliersProvider extends BaseRestController {
  static const TAG = "SuppliersProvider";

  Function loadSuppliersDataCallBack;

  SuppliersProvider(this.loadSuppliersDataCallBack);

  void execute() {
    var supplierInfoList = loadSuppliersDataByUser().then(
        (supplierInfoList) => _convertToSupplierItemsMap(supplierInfoList));
  }

  Future loadSuppliersDataByUser() async {
    Logger.log(TAG, message:"------------loadSuppliersDataByUser--------------------");
    var position = await getLocationImpl();
    //var position = new UserLocation(31.5000, 34.7500);
    ResponseDTO response = await executePost("suppliers/forUser", position);
    if (!response.is_error) print("from loadSuppliersData ${response.data}");
    if (response.is_error) {
      if (response.errorCode == 401) {
        super.userLogin();
        execute();
      } else {
        Logger.log(TAG, message:"error- ${response.errorMsg} -error code ${response.errorCode}");
        return;
      }
    } else {
      Logger.log(TAG, message:"${response.data}");
      return response.data
          .map((item) => SupplierInfoDTO.fromJson(item))
          .toList();
    }
  }

  Future loadSuppliersData() async {
    Logger.log(TAG, message:"------------loadSuppliersData--------------------");

    ResponseDTO response = await executeGet("suppliers");
    if (!response.is_error) print("from loadSuppliersData ${response.data}");
    if (response.is_error) {
      if (response.errorCode < 500) {
        super.adminLogin();
        execute();
      }
    } else {
      Logger.log(TAG, message:response.data);
      return response.data
          .map((item) => SupplierInfoDTO.fromJson(item))
          .toList();
    }
  }

  Future<GeolocationResult> getPermission() async {
    final GeolocationResult result =
        await Geolocation.requestLocationPermission(
            permission: const LocationPermission(
                android: LocationPermissionAndroid.fine,
                ios: LocationPermissionIOS.always));
    return result;
  }

  Future<LocationResult> getLocation() {
    return getPermission().then((result) async {
      if (result.isSuccessful) {
        final coords = await Geolocation.currentLocation(accuracy: LocationAccuracy.best);
        return coords.first;
      } else {
        return null;
      }
    });
  }

  Future getLocationImpl() async {
    Logger.log(TAG, message:"------------getLocation--------------------");
    // var location = new Location();
    UserLocation userLocation;
    //LocationData locationData = await location.getLocation();
    LocationResult location = await getLocation();
    Logger.log(TAG, message:location.toString());
    if (location != null) {
      userLocation = new UserLocation(
          location.location.latitude, location.location.longitude);
    } else {
      userLocation = new UserLocation(31.5000, 34.7500);
    }
    // Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    Logger.log(TAG, message:"------------getLocation end --------------------");
    Logger.log(TAG, message: "${userLocation.toJson()}");
    return userLocation.toJson();
  }

  void _convertToSupplierItemsMap(List<dynamic> responseList) {
    //TODO: EMIL: Need to understand why responseList sometimes is null
    if (responseList != null) {
      List<SupplierInfoDTO> suppliersDTOList = responseList.cast<SupplierInfoDTO>();
      Map<String, SupplierInfoDTO> supplierItems = {};
      for (var supplierDTO in suppliersDTOList) {
        supplierItems[supplierDTO.restId] = supplierDTO;
      }

      this.loadSuppliersDataCallBack(supplierItems);
    }
  }

  ResponseDTO getResponseDummy() {
    dynamic data = [
      {
        'createdAt': '2020-02-2121:03:52.78305',
        'updatedAt': "2020-03-0819:24:52.57",
        "id": "3",
        "supplierName": "לחמנינה",
        "address": "מרמורק4תלאביביפו",
        "openHours": "א'-ה'21:00-23:00",
        "backgroundImage":
            "https://f4gimages.s3.eu-central-1.amazonaws.com/6_bg.jpg",
        "logoImage":
            "https://f4gimages.s3.eu-central-1.amazonaws.com/6_logo.jpg",
        "longtitude": "34.7817342",
        "latetude": "32.0712537",
        "rates": "2",
        "displayOrder": "3",
        "productDTOList": [
          {
            "createdAt": "2020-02-2121:03:52.78305",
            "updatedAt": "2020-03-0819:24:52.57",
            "id": "3",
            "dishName": "מאפים,לחמים,סלטים",
            "dishDescription": "מאפים,לחמים,סלטים",
            "fixPrice": "null",
            "maxPrice": "20.0",
            "minPrice": "7.0",
            "amount": "5",
            "originalPrice": "50.0",
            "discount": "40.0",
            "maxNumOfDishes": "0"
          }
        ],
        "distance": "74.5km",
        "userFavorite": "false"
      },
      {
        "createdAt": "2020-02-1420:54:08.649593",
        "updatedAt": "2020-03-0820:28:46.609",
        "id": "1",
        "supplierName": "Allora",
        "address": "בןגוריון39תלאביבייפו",
        "openHours": "00-20:00ו`15:00-16:00",
        "backgroundImage":
            "https://f4gimages.s3.eu-central-1.amazonaws.com/6_bg",
        "productDTOList": [
          {
            "createdAt": "2020-02-2121:03:52.78305",
            "updatedAt": "2020-03-0819:24:52.57",
            "id": "4",
            "dishName": "מאפים,לחמים,סלטים",
            "dishDescription": "מאפים,לחמים,סלטים",
            "fixPrice": "null",
            "maxPrice": "20.0",
            "minPrice": "7.0",
            "amount": "5",
            "originalPrice": "50.0",
            "discount": "40.0",
            "maxNumOfDishes": "0"
          }
        ],
        "rates": "4",
        "displayOrder": "3",
        "distance": "74.5km",
        "userFavorite": "false"
      }
    ];
    ResponseDTO responseDTO = new ResponseDTO(data, false, null, "");
    return responseDTO;
  }
}
