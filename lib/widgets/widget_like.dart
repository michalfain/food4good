import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food4good_app/controllers/favorite_controller.dart';
import 'package:food4good_app/dto/upper_bar_config.dart';
import 'package:food4good_app/dto/supplier_info.dart';
import 'package:food4good_app/utils/constants.dart';

class WidgetLike extends StatefulWidget {
  WidgetLike(this.supplierInfoDTO, this.upperBarConfig, this.numOfLikesColor);

  @override
  _WidgetLikeState createState() => _WidgetLikeState();

  final SupplierInfoDTO supplierInfoDTO;
  final UpperBarConfig upperBarConfig;
  final Color numOfLikesColor;
}

class _WidgetLikeState extends State<WidgetLike> {
  static Icon disLike = Icon(
    Icons.favorite_border,
    color: Constants.HEART_ICON_COLOR_RED,
    size: Constants.LIKE_HEART_ICON_SIZE,
  );
  static Icon like = Icon(
    Icons.favorite,
    color: Constants.HEART_ICON_COLOR_RED,
    size: Constants.LIKE_HEART_ICON_SIZE,
  );

  Icon likeOrDis;

  @override
  void initState() {
    super.initState();
    likeOrDis = this.widget.supplierInfoDTO.isMyFavorite ? like : disLike;
  }

  @override
  void setState(fn) {
    super.setState(fn);
    likeOrDis = this.widget.supplierInfoDTO.isMyFavorite ? like : disLike;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _disOrLike();
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          widget.upperBarConfig.isLikesShow
              ? _buildLikeIconWidget()
              : SizedBox(),
          widget.upperBarConfig.isHeartShow
              ? _buildLikeCounterWidget()
              : SizedBox()
        ],
      ),
    );
  }

  Widget _buildLikeCounterWidget() {
    return Text(
      widget.supplierInfoDTO.numOfLikes.toString(),
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: Constants.UPPER_BAR_NO_OF_LIKES,
          color: widget.numOfLikesColor),
    );
  }

  Widget _buildLikeIconWidget() {
    return Center(
      child: likeOrDis,
    );
  }

  _disOrLike() {
    FavoriteController favoriteProvider =
        new FavoriteController(favouriteProviderCallBack);
    bool isMyFavorite;
    if (likeOrDis == disLike) {
      likeOrDis = like;
      isMyFavorite = true;
    } else {
      likeOrDis = disLike;
      isMyFavorite = false;
    }
    favoriteProvider.execute(isMyFavorite, widget.supplierInfoDTO.restId);
  }

  void favouriteProviderCallBack(int numOfLikes, bool isFavorite) {
    this.widget.supplierInfoDTO.numOfLikes = numOfLikes;
    this.widget.supplierInfoDTO.isMyFavorite = isFavorite;
    setState(() {});
  }
}
