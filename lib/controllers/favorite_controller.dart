import 'package:food4good_app/dto/response.dart';

import 'base_rest_controller.dart';

class FavoriteController extends BaseRestController {
  int numOfLikes;
  Function favoriteCallBack;

  FavoriteController(this.favoriteCallBack);

  void execute(bool isLiked, String supplierId) {
    setLike(isLiked, supplierId)
        .then((response) => _setResult(response, isLiked));
  }

  setLike(bool isLiked, String supplierId) async {
    ResponseDTO response;
    if (isLiked) {
      response = await executeGet("suppliers/favorite/$supplierId");
    } else {
      response = await executeDelete("suppliers/favorite/$supplierId");
    }
    return response;
  }

  _setResult(ResponseDTO response, bool isLiked) {
    this.favoriteCallBack(response.data, isLiked);
  }
}
