import 'package:food4good_app/utils/constants.dart';

class ProductDTO {
  String availableDishAmount;
  String amount;
  String discount;
  String dishDescription;
  String dishName;
  String fixPrice;
  String productId;
  String maxNumOfDishes;
  String maxPrice;
  String minPrice;
  String originalPrice;
  String updatedAt;
  String createdAt;

  ProductDTO({
    this.createdAt,
    this.updatedAt,
    this.originalPrice,
    this.maxPrice,
    this.minPrice,
    this.productId,
    this.availableDishAmount,
    this.maxNumOfDishes,
    this.discount,
    this.dishDescription,
    this.amount,
    this.dishName,
    this.fixPrice,
  });

  factory ProductDTO.fromJson(Map<String, dynamic> jsonItem) {
    return ProductDTO(
      amount: jsonItem[Constants.KEY_AMOUNT].toString(), //need to be fixed
      availableDishAmount: jsonItem[Constants.KEY_AVAILABLE_DISH_AMOUNT]
          .toString(), //need to be fixed
      discount: jsonItem[Constants.KEY_DISCOUNT],
      dishDescription: jsonItem[Constants.KEY_DISH_DESCRIPTION],
      dishName: jsonItem[Constants.KEY_DISH_NAME],
      fixPrice: jsonItem[Constants.KEY_FIX_PRICE],
      productId: jsonItem[Constants.KEY_ID].toString(),
      maxNumOfDishes: jsonItem[Constants.KEY_MAX_NUM_OF_DISHES],
      maxPrice: jsonItem[Constants.KEY_MAX_PRICE],
      minPrice: jsonItem[Constants.KEY_MIN_PRICE],
      originalPrice: jsonItem[Constants.KEY_ORIGINAL_PRICE],
      updatedAt: jsonItem[Constants.KEY_UPDATED_AT],
      createdAt: jsonItem[Constants.KEY_CREATED_AT],
    );
  }

  Map toJson() => {
        Constants.KEY_AMOUNT: amount,
        Constants.KEY_AVAILABLE_DISH_AMOUNT: availableDishAmount,
        Constants.KEY_CREATED_AT: createdAt,
        Constants.KEY_DISCOUNT: discount,
        Constants.KEY_DISH_DESCRIPTION: dishDescription,
        Constants.KEY_DISH_NAME: dishName,
        Constants.KEY_FIX_PRICE: fixPrice,
        Constants.KEY_ID: productId,
        Constants.KEY_MAX_NUM_OF_DISHES: maxNumOfDishes,
        Constants.KEY_MAX_PRICE: maxPrice,
        Constants.KEY_MIN_PRICE: minPrice,
        Constants.KEY_ORIGINAL_PRICE: originalPrice,
        Constants.KEY_UPDATED_AT: updatedAt
      };
}
