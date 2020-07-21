import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food4good_app/dto/enum_order_status.dart';
import 'package:food4good_app/dto/order.dart';
import 'package:food4good_app/utils/constants.dart';
import 'package:food4good_app/utils/data_model.dart';
import 'package:food4good_app/utils/localization/strings.dart';
import 'package:food4good_app/utils/localization/translation_strings.dart';
import 'package:food4good_app/utils/logger.dart';
import 'package:food4good_app/widgets/alert_dialog_cancel_order.dart';
import 'package:food4good_app/widgets/alert_dialog_final_price.dart';
import 'package:provider/provider.dart';
import 'package:slider_button/slider_button.dart';

class PickupOrderScreen extends StatefulWidget {
  static const String SCREEN_NAME = 'PickupOrderScreen';
  final OrderDTO order;
  bool didSliderSlide = false;

  PickupOrderScreen(this.order, this.didSliderSlide);

  @override
  _PickupOrderScreenState createState() => _PickupOrderScreenState();
}

class _PickupOrderScreenState extends State<PickupOrderScreen> {
  final String TAG = "PickupOrderScreen";

  @override
  Widget build(BuildContext context) {
    var dataModel = Provider.of<DataModel>(context, listen: true);
    var supplierInfo = dataModel.supplierItemsMap[widget.order.supplierId.toString()];

    return Scaffold(
        body: Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            CachedNetworkImage(
              placeholder: (context, restId) => _getPlaceHolderBackGround(),
              imageUrl: supplierInfo.backgroundImage,
              imageBuilder: (context, imageProvider) => Container(
                height: 200.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(Colors.grey, BlendMode.darken),
                  ),
                ),
              ),
            ),
            CircleAvatar(
              backgroundColor: Constants.CIRCLE_AVATAR_RADIUS_CHECKOUT_COLOR,
              radius: Constants.CIRCLE_AVATAR_RADIUS_CHECKOUT_SCREEN,
              child: ClipOval(
                child: CachedNetworkImage(
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                  imageUrl: supplierInfo.logoImage,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.order.supplierName,
                    style: TextStyle(
                        fontSize: Constants.PICKUP_ORDER_SCREEN_HEADLINE_FONT,
                        color: Constants.PICKUP_ORDER_SCREEN_HEADLINE_COLOR),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.place,
                        color: Constants.PICKUP_ORDER_SCREEN_VAR_COLOR,
                      ),
                      Text(
                        supplierInfo.distance + Translations.of(context).getString(Strings.fromMe),
                        style: TextStyle(
                            fontSize: Constants.PICKUP_ORDER_SCREEN_VAR_FONT,
                            color: Constants.PICKUP_ORDER_SCREEN_VAR_COLOR),
                      )
                    ],
                  ),
                  Text(supplierInfo.address == null ? "" : supplierInfo.address,
                      style: TextStyle(
                          fontSize: Constants.PICKUP_ORDER_SCREEN_VAR_FONT,
                          color: Constants.PICKUP_ORDER_SCREEN_VAR_COLOR)),
                ],
              ),
              FlatButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CancelOrderDialog(widget.order);
                    },
                  );
                  setState(() {
                    widget.order.status = OrderStatus.delivered;
                  });
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  side: BorderSide(color: Constants.FRAME_BORDER_COLOR),
                ),
                child: Text(
                  Translations.of(context).getString(Strings.cancelOrder),
                ),
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  widget.order.numOfProducts.toString(),
                  style:
                      TextStyle(fontSize: Constants.BIG_TEXT_SIZE, color: Constants.PICKUP_ORDER_SCREEN_HEADLINE_COLOR),
                ),
                Text(
                  Translations.of(context).getString(Strings.dishes),
                  style:
                      (TextStyle(fontSize: Constants.MEDIUM_TEXT_SIZE, color: Constants.PICKUP_ORDER_SCREEN_VAR_COLOR)),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  widget.order.totalPrice, //TODO Michal - get estimated price from OrderDTO
                  style:
                      TextStyle(fontSize: Constants.BIG_TEXT_SIZE, color: Constants.PICKUP_ORDER_SCREEN_HEADLINE_COLOR),
                ),
                Text(
                  Translations.of(context).getString(Strings.estimatedPayment),
                  style:
                      (TextStyle(fontSize: Constants.MEDIUM_TEXT_SIZE, color: Constants.PICKUP_ORDER_SCREEN_VAR_COLOR)),
                )
              ],
            ),
            Column(
              children: [
                Text(
                  supplierInfo.pickupHour,
                  style:
                      TextStyle(fontSize: Constants.BIG_TEXT_SIZE, color: Constants.PICKUP_ORDER_SCREEN_HEADLINE_COLOR),
                ),
                Text(
                  Translations.of(context).getString(Strings.pickupTime),
                  style:
                      (TextStyle(fontSize: Constants.MEDIUM_TEXT_SIZE, color: Constants.PICKUP_ORDER_SCREEN_VAR_COLOR)),
                )
              ],
            ),
          ],
        ),
        SizedBox(
          height: 80.0,
        ),
        Text(
          Translations.of(context).getString(Strings.pleaseArriveDuringPickupHours),
          style: TextStyle(color: Constants.PICKUP_ORDER_SCREEN_HEADLINE_COLOR, fontSize: Constants.BIG_TEXT_SIZE),
        ),
        SizedBox(height: 50.0),
        SliderButton(
          dismissible: widget.didSliderSlide,
          vibrationFlag: widget.didSliderSlide,
          action: () {
            Logger.log(TAG, message: "slider did slide");
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return PriceAlert(widget.order);
              },
            );
            widget.order.status = OrderStatus.delivered;
            widget.didSliderSlide = true;
          },
          label: Text(
              widget.didSliderSlide
                  ? Translations.of(context).getString(Strings.orderDelivered)
                  : Translations.of(context).getString(Strings.toConfirmOrder),
              style: TextStyle(color: Constants.PICKUP_ORDER_SCREEN_HEADLINE_COLOR)),
          icon: Center(
              child: Icon(
            Icons.keyboard_arrow_right,
            color: Colors.white,
            size: 70.0,
          )),
          width: 300,
          radius: 40,
          buttonColor: Colors.grey,
          highlightedColor: Colors.white,
        ),
        SizedBox(height: 10.0),
        Text(widget.didSliderSlide ? "" : Translations.of(context).getString(Strings.slideWillBeDoneBySupplier),
            style: TextStyle(fontSize: Constants.MEDIUM_TEXT_SIZE, color: Constants.PICKUP_ORDER_SCREEN_VAR_COLOR)),
        Expanded(
          child: Container(),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            width: 350.0,
            height: 60.0,
            child: RaisedButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
              color: Constants.BUTTON_COLOR,
              onPressed: () {},
              child: Text(
                widget.didSliderSlide
                    ? Translations.of(context).getString(Strings.anotherOrder)
                    : Translations.of(context).getString(Strings.navigation),
                style: (TextStyle(fontSize: Constants.TEXT_RAISED_BUTTON_SIZE, color: Constants.BUTTON_TEXT_COLOR)),
              ),
            ),
          ),
        ),
      ],
    ));
  }

  _getPlaceHolderBackGround() {
    return Image(
      image: AssetImage(Constants.IMG_BACKGROUND),
      //width: widget._itemWidth,
//      height: widget._itemHeight,
      fit: BoxFit.cover,
      //alignment: Alignment.center
    );
  }
}
