import 'package:flutter/material.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:food4good_app/screens/admin/supplier_home_page_screen.dart';
import 'package:food4good_app/screens/admin/supplier_logIn_screen.dart';
import 'package:food4good_app/screens/admin/supplier_orders_screen.dart';
import 'package:food4good_app/screens/admin/supplier_update_dishes_screen.dart';
import 'package:food4good_app/screens/admin/suppliers_update_details_screen.dart';
import 'package:food4good_app/screens/screen_main/screen_main.dart';
import 'package:food4good_app/screens/screen_main/page_orders.dart';
import 'package:food4good_app/screens/user/screen_dish_order.dart';
import 'package:food4good_app/screens/user/screen_order_confirmation.dart';
import 'package:food4good_app/screens/side_menu/screen_about.dart';
import 'package:food4good_app/screens/side_menu/screen_faq.dart';
import 'package:food4good_app/screens/side_menu/screen_settings.dart';
import 'package:food4good_app/screens/side_menu/widget_display_pdf.dart';
import 'package:food4good_app/utils/data_model.dart';
import 'package:food4good_app/utils/localization/translations_delegate.dart';

void main() {
  Crashlytics.instance.enableInDevMode = true;

  FlutterError.onError = Crashlytics.instance.recordFlutterError;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DataModel>(
      create: (BuildContext context) => DataModel(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            TranslationsDelegate()
          ],
          supportedLocales: [
            Locale('en', ''),
            Locale('he', ''),
          ],
          initialRoute: MainScreen.SCREEN_NAME,
          routes: {
            MainScreen.SCREEN_NAME: (context) => MainScreen(),
            DishOrderScreen.SCREEN_NAME: (context) => DishOrderScreen(),
            AboutScreen.SCREEN_NAME: (context) => AboutScreen(),
            SettingsScreen.SCREEN_NAME: (context) => SettingsScreen(),
            WidgetDisplayPdf.SCREEN_NAME: (context) => WidgetDisplayPdf(),
            OrderConfirmationScreen.SCREEN_NAME: (context) => OrderConfirmationScreen(),
            PageOrders.SCREEN_NAME: (context) => PageOrders(),
            FAQScreen.SCREEN_NAME: (context) => FAQScreen(),
            SupplierLogInScreen.SCREEN_NAME: (context) => SupplierLogInScreen(),
            SupplierHomePageScreen.SCREEN_NAME: (context) => SupplierHomePageScreen(),
            SupplierOrdersScreen.SCREEN_NAME: (context) => SupplierOrdersScreen(),
            SupplierUpdateDishesScreen.SCREEN_NAME: (context) => SupplierUpdateDishesScreen(),
            SupplierUpdateDetailsScreen.SCREEN_NAME: (context) => SupplierUpdateDetailsScreen(),
          }),
    );
  } //
}
