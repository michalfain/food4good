import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class Constants {
  //Urls
  //environment urls
  //static const String URL_UAT = "http://172.17.16.182:8080/backend/";
  static const String URL_UAT = "http://food4good-uat-1.eu-central-1.elasticbeanstalk.com/backend/";
  static const String URL_TEST = "http://testapp-env-2.z6yitptpaw.eu-central-1.elasticbeanstalk.com/backend/";

  //url site
  static const FOOD4GOOD_SITE = 'https://www.food4good.co.il';

  //url image
  static const LOGO_URL = 'https://f4gimages.s3.eu-central-1.amazonaws.com/';

  //url pdf
  static const USER_TERMS_URL = 'https://policies-f4g.s3.eu-central-1.amazonaws.com/use-agreemant+20200316.pdf';
  static const PRIVACY_POLICY_URL = 'https://policies-f4g.s3.eu-central-1.amazonaws.com/privacy-policy+20200316.pdf';

  //Colors Constants
  //general colors
  static const Color BUTTON_COLOR = Color(0xFF424242); //the big bottom button
  static const Color BUTTON_DARKER_COLOR = Color(0xFF000000);
  static const Color BUTTON_TEXT_COLOR = Color(0XFFFFFFFF); //white //the bottom button
  static const Color BOTTOM_NAV_BUTTONS_COLOR = Color(0xFF424242);

  //static const Color FLAG_COLOR = Color(0xFF9E9E9E);
  static const Color FLAG_COLOR = Colors.green;
  static const Color HEADLINE_COLOR = Color(0xFF616161); //the 707070 color from zeplin design
  static const Color ICON_HEADLINE_COLOR = Color(0xFF616161);
  static const Color SCREEN_TEXT_COLOR = Color(0xFF616161);
  static const Color SCREEN_DARKER_TEXT_COLOR = Color(0xFF424242);
  static const Color SCREEN_SUB_LINE_TEXT_COLOR = Color(0xFF424242);
  static const Color ICON_COLOR = Color(0xFF616161);
  static const Color SCREEN_APPBAR_COLOR = Color(0xFF757575); //grey[600]
  static const Color APPBAR_BG_COLOR_SCREEN = Color(0xFFF5F5F5); // grey[100]
  static const Color RESTAURANT_INFO_ROW_COLOR = Color(0xFFB4B4B4);
  static const Color BADGE_BG_COLOR = Color(0XFFFFFFFF); //white
  static const Color DISCOUNT_TEXT_COLOR = Color(0XFFFFFFFF); //white
  static const Color DISCOUNT_CONTAINER_COLOR = Color(0xFF9E9E9E); //grey
  static const Color LOGO_BG_COLOR = Color(0XFFFFFFFF); //white
  static const Color FRAME_BG_COLOR = Color(0XFFFFFFFF); //white

  //colors in specific pages
  //colors checkout screen
  static const Color CHECKOUT_SCREEN_CONTAINER_UNDERLINE = Color(0xFFE0E0E0); //grey[300]
  static const Color CHECKOUT_SCREEN_ICON_COLOR = Color(0xFFBDBDBD); //grey[400]
  static const Color CHECKOUT_SCREEN_VAR_COLOR = Color(0xFF757575); //grey[600]
  static const Color CIRCLE_AVATAR_RADIUS_CHECKOUT_COLOR = Color(0XFFFFFFFF);

  //colors dish-order screen
  static const Color DISH_ORDER_SCREEN_HEADLINE_COLOR = Color(0xFF616161);
  static const Color DISH_ORDER_SCREEN_HEADLINE2_COLOR = Color(0xFF9E9E9E); //grey
  static const Color DISH_ORDER_SCREEN_NUM_OF_LIKES_COLOR = Colors.black;
  static const Color RAISED_BUTTON_DISH_ORDER_COLOR = Color(0xFFFFFFFF); //white
  static const Color RAISED_BUTTON_DISH_ORDER_TEXT_COLOR = Color(0xFF000000); //black
  static const Color RAISED_BUTTON_DISH_ORDER_DISABLE_COLOR = Color(0x00000000); //transparent
  static const Color RAISED_BUTTON_DISH_ORDER_SPLASH_COLOR = Color(0xFF0091EA); //blueAccent
  //Order confirmation screen colors
  static const Color ORDER_CONFIRMATION_SCREEN_TEXT_COLOR = Color(0xFF9E9E9E); //grey
  static const Color ORDER_CONFIRMATION_SCREEN_ICON_COLOR = Color(0xFFBDBDBD); //grey[400]
  static const Color RAISED_BUTTON_CONFIRM_ORDER_BG_COLOR = Color(0xFF000000); //black
  static const Color RAISED_BUTTON_CONFIRMATION_ORDER_TEXT_COLOR = Color(0xFFFFFFFF); //white
  //static const Color HEART_ICON_COLOR_RED = Color(0xFFB71C1C);
  static const Color HEART_ICON_COLOR_RED = Colors.red;

  static const Color HEART_ICON_COLOR_GREY = Color(0xFF607D8B);
  static const Color DISH_ORDER_SCREEN_LOCATION_COLOR = Colors.blueGrey;
  static const Color TAB_TEXT_COLOR = Color(0xFF616161);

  //colors side menu screen
  static const Color NOTIFICATION_ACTIVE_COLOR = Color(0XFFFFFFFF); //white
  static const Color NOTIFICATION_ACTIVE_TRACK_COLOR = Color(0XDD000000); //black87
  //colors supplier screens
  static const Color SUPPLIER_ORDERS_BUTTON_PRESSED_TEXT_COLOR = Color(0XFFFFFFFF); //white
  static const Color SUPPLIER_ORDERS_BUTTON_TEXT_COLOR = Color(0xFF616161); //whit
  static const Color SUPPLIER_TEXT_FIELD_BORDER_COLOR = Color(0xFF757575);
  static const Color SUPPLIER_SHADOW_TEXT_FIELD_BORDER_COLOR = Color(0xFF9E9E9E);
  static const Color SUPPLIER_TEXT_FIELD_BG_COLOR = Color(0XFFFFFFFF); //white
  //static const Color SUPPLIER_NAME_COLOR = Color(0XFFFFFFFF);
  static const Color SUPPLIER_NAME_COLOR = Colors.white;
  static const Color UPPER_BAR_ITEM_COLOR = Color(0xFFFFFFFF);
  static const Color RECTANGLE_FRAME_COLOR = Color(0xFFFFFFFF);
  static const Color RECTANGLE_FRAME_BORDER_COLOR = Color(0xFF000000);
  static const Color RECTANGLE_FRAME_SHADOW_COLOR = Color(0xFF9E9E9E);
  static const Color ORDER_FRAME_COLOR = Color(0xFFFFFFFF);
  static const Color ORDER_FRAME_BORDER_COLOR = Color(0xFF000000);
  static const Color FRAME_BORDER_COLOR = Color(0xFF000000);
  static const Color ORDER_FRAME_SHADOW_COLOR = Color(0xFF9E9E9E);
  static const Color ORDER_STATUS_1 = Color(0xFF43A047);
  static const Color ORDER_STATUS_2 = Color(0xFFB71C1C);
  static const Color ORDER_STATUS_3 = Color(0xFF9E9E9E);
  static const Color ORDER_ITEM_COLOR = Color(0xFF757575);
  static const Color ORDER_ITEM_FLAT_BUTTON_COLOR = Color(0xFF616161);
  static const Color ORDER_ITEM_CONST_COLOR = Color(0xFF9E9E9E);
  static const Color GET_INFO_ITEM_COLOR = Color(0xFF9E9E9E); //grey
  static const Color ALERT_DIALOG_FONT_COLOR = Color(0xFF9E9E9E); //grey
  static const Color PICKUP_ORDER_SCREEN_HEADLINE_COLOR = Color(0xFF757575); //grey[600]
  static const Color PICKUP_ORDER_SCREEN_VAR_COLOR = Color(0xFF9E9E9E); //grey

  //Fonts
  //fontSize
  static const double HEADLINE_SIZE = 20.0;
  static const double BIG_TEXT_SIZE = 16.0;
  static const double MEDIUM_TEXT_SIZE = 14.0;
  static const double TEXT_BUTTON_SIZE = 14.0;
  static const double NUM_OF_LIKES_SIZE = 12.0;
  static const double SMALL_TEXT_SIZE = 12.0;
  static const double BOTTOM_NAV_TEXT_SIZE = 12.0;
  static const double SIDE_MENU_HEADLINE_SIZE = 16.0;
  static const double SIDE_MENU_TEXT_SIZE = 16.0;
  static const double SCREEN_APPBAR_FONT = 20.0;
  static const double CHECKOUT_SCREEN_REST_NAME = 25.0;
  static const double CHECKOUT_SCREEN_TEXT_FONT = 15.0;
  static const double CHECKOUT_SCREEN_VAR_FONT = 18.0;
  static const double CHECKOUT_SCREEN_BUTTON_FONT = 20.0;
  static const double DISH_ORDER_SCREEN_HEADLINE_FONT = 23.0;
  static const double PICKUP_ORDER_SCREEN_HEADLINE_FONT = 25.0;
  static const double PICKUP_ORDER_SCREEN_VAR_FONT = 17.0;
  static const double DISH_ORDER_SCREEN_ADDRESS_FONT = 15.0;
  static const double DISH_ORDER_SCREEN_HEADLINE2_FONT = 15.0;
  static const double DISH_ORDER_SCREEN_HEADLINE3_FONT = 12.0;
  static const double ORDER_CONFIRMATION_SCREEN_CONFIRM_FONT = 30.0;
  static const double TEXT_RAISED_BUTTON_SIZE = 20.0;
  static const double TAB_TEXT_FONT_SIZE = 24.0;
  static const double LIKE_HEART_ICON_SIZE = 28.0;
  static const double LOCATION_ICON_SIZE = 28.0;
  static const double SUPPLIER_NAME_FONT = 18.0;
  static const double UPPER_BAR_TEXT_SIZE = 15.0;
  static const double UPPER_BAR_NO_OF_LIKES = 12.0;
  static const double ORDER_ITEM_FONT = 20.0;
  static const double ORDER_ITEM_FIELD_FONT = 18.0;
  static const double ALERT_DIALOG_SMALL_FONT = 12.0;

  //icons sizes
  static const double SCREEN_ICON_SIZE = 40.0;
  static const double HEART_ICON_SIZE = 15.0;
  static const double GET_INFO_ICON_SIZE = 30.0;
  static const double GET_INFO_TEXT_SIZE = 20.0;
  static const double GET_INFO_ICON_SIZE_SMALL = 25.0;

  //circle avatar radius
  static const double CIRCLE_AVATAR_RADIUS_CHECKOUT_SCREEN = 30.0;
  static const double CIRCLE_AVATAR_RADIUS = 37.0;

  //icons
  static const Icon SELECTED_ITEMS_CHECKOUT_SCREEN_ICON = Icon(IconData(58746));
  static const Icon ESTIMATED_PAYMENT_CHECKOUT_SCREEN_ICON = Icon(IconData(57895));
  static const Icon PICKUP_TIME_CHECKOUT_SCREEN_ICON = Icon(IconData(58405));
  static const Icon ADDRESS_CHECKOUT_SCREEN_ICON = Icon(IconData(0xe84f));
  static const Icon ERROR_ICON = Icon(IconData(0xe000));
  static const Icon FLOWER_ICON = Icon(IconData(0xe545));
  static const Icon HEART_ICON = Icon(IconData(0xe87d));
  static const Icon HEART_BORDER_ICON = Icon(IconData(0xe87e));
  static const Icon LOCATION_ICON = Icon(IconData(0xe0c8));
  static const Icon CHECK_CIRCLE = Icon(IconData(0xe86c));

  //key constants
  static const KEY_ADDRESS = 'address';
  static const KEY_DISTANCE = 'distance';
  static const KEY_DISCOUNT = 'discount';
  static const KEY_STRING_ADDRESS = 'stringAddress';
  static const KEY_ADDRESS_AS_STRING = 'addressAsString';
  static const KEY_CREATED_AT = 'createdAt';
  static const KEY_UPDATED_AT = 'updatedAt';
  static const KEY_LATITUDE = 'latitude';
  static const KEY_LONGITUDE = 'longitude';
  static const KEY_ORDER_ID = 'orderId';
  static const KEY_PICKUP_TIME = 'pickUpTime';
  static const KEY_TOTAL_PRICE = 'totalPrice';
  static const KEY_PRODUCT_AMOUNT = 'productAmount';
  static const KEY_PRODUCTS = 'products';
  static const KEY_PRODUCT_ID = 'productId';
  static const KEY_STATUS = 'status';
  static const KEY_SUPPLIER_ID = 'supplierId';
  static const KEY_TOKEN = 'token';
  static const KEY_DATA = 'data';
  static const KEY_IS_ERROR = 'is_error';
  static const KEY_ERROR_CODE = 'errorCode';
  static const KEY_ERROR_MSG = 'errorMsg';
  static const KEU_UUID = 'uuid';
  static const KEY_USER_ID = 'userId';
  static const KEY_SUPPLIER_NAME = 'supplierName';
  static const KEY_ID = 'id';
  static const KEY_COMMENT = 'comments';
  static const KEY_PRODUCTS_ROWS = 'productsRows';
  static const KEY_PRODUCTS_ID = "productId";
  static const KEY_BG_IMAGE = 'backgroundImage';
  static const KEY_LOGO_IMAGE = 'logoImage';
  static const KEY_FIXED_PRICE = 'fixPrice';
  static const KEY_MAX_PRICE = 'maxPrice';
  static const KEY_MIN_PRICE = 'minPrice';
  static const KEY_DISH_DESCRIPTION = 'dishDescription';
  static const KEY_AMOUNT = 'amount';
  static const KEY_OPEN_HOURS = 'openHours';

  static const KEY_OPEN_HOURS_SUPPLIER_ADMIN = 'open_hours'; //Different parameter name in back end
  static const KEY_USER_FAVORITE = 'userFavorite';
  static const KEY_DISH_NAME = 'dishName';
  static const KEY_ORIGINAL_PRICE = 'originalPrice';
  static const KEY_MAX_NUM_OF_DISHES = 'maxNumOfDishes';
  static const KEY_NUM_OF_PRODUCTS = 'numOfProducts';
  static const KEY_COMMENTS = 'comments';
  static const KEY_PRODUCTS_AMOUNT = 'productAmount';
  static const KEY_AVAILABLE_DISH_AMOUNT = 'availableDishAmount';
  static const KEY_FIX_PRICE = 'fixPrice';
  static const KEY_RATES = 'rates';
  static const KEY_NAME = 'name';
  static const IMG_BACKGROUND = 'assets/images/bg.jpg';
  static const IMG_LOGO = 'assets/images/logo.jpg';
}
