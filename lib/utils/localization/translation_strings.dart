import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:food4good_app/utils/localization/strings.dart';

class Translations {
  static String appName = 'Food 4 Good';
  static const String placeholderPattern = '(\{\{([a-zA-Z0-9]+)\}\})';

  Translations(this.locale);

  final Locale locale;

  static Translations of(BuildContext context) {
    return Localizations.of<Translations>(context, Translations);
  }

  static Map<String, Map<Object, String>> _localizedValues = {
    'en': {
      Strings.about: 'About',
      Strings.address: 'Address',
      Strings.all: 'All',
      Strings.amount: 'Amount',
      Strings.andConfirmWithSupplier: "and confirm with the supplier",
      Strings.appName: 'Food4Good',
      Strings.checkOutOtherSuppliers: 'CHECKOUT OTHER SUPPLIERS',
      Strings.close: 'Close',
      Strings.confirmOrderAppbar: 'Confirm Order',
      Strings.contact: 'Contact',
      Strings.date: 'Date',
      Strings.days: 'Days',
      Strings.discount: 'off',
      Strings.dishesDetail: 'Dishes detail',
      Strings.duringPickupHours: 'During pickup hours',
      Strings.errorInPlaceOrder: 'error in place order',
      Strings.errorName: 'ErrorName: ',
      Strings.estimatedPayment: 'Estimated payment',
      Strings.estimatedPayment1Parameter: 'Estimated payment %d Nis',
      Strings.estimatedPayment2Parameters: 'Estimated payment %d-%d Nis',
      Strings.pickupTime: 'Pickup time',
      Strings.selectHowManyItemsToSave: 'Select how many items to save',
      Strings.thePaymentWillBeHandledBySupplier: 'Payment will be handled later by the Supllier',
      Strings.orderButton: 'ORDER',
      Strings.toOrderPleaseSelectNoOfItems: 'To Order, Please select the number of items',
      Strings.youCanSelectUpToThreeItems: '(you can select up to 3 items)',
      Strings.confirmOrderButton: 'Confirm order',
      Strings.failedToUploadData: 'failed To Upload Data. ',
      Strings.faq: 'FAQ',
      Strings.finalPriceWillBeSetByTheSupplier: 'Final price will be set by the supplier',
      Strings.friday: 'Friday',
      Strings.from: 'From',
      Strings.goBackToPreviousPage: 'Go back to previous page',
      Strings.homePage: 'Home page',
      Strings.howManyDishesLeft: 'How many dishes left',
      Strings.joinUs: 'Join us and together we will prevent food wasting',
      Strings.lblSearchByBusinessName: 'Search by business name',
      Strings.login: 'Login',
      Strings.maximumForPickup: 'Maximum for pickup',
      Strings.maximumPrice: 'Maximum price',
      Strings.menu: 'Menu',
      Strings.minimumPrice: 'Minimum price',
      Strings.toMyOrders: 'GO TO MY ORDERS',
      Strings.noImageSelected: 'No Image Selected',
      Strings.notifications: 'Notifications',
      Strings.order: 'ORDER',
      Strings.orderIsDone: 'Order is done!',
      Strings.orders: 'Orders',
      Strings.ordersStatus: 'Orders Status',
      Strings.open: 'Open',
      Strings.originalPrice: 'Original price',
      Strings.password: 'Password',
      Strings.pickADate: 'Pick a Date',
      Strings.pleaseTryAgainLater: 'Please Try Again Later. ',
      Strings.priceRange: 'Price range',
      Strings.privacyPolicy: 'Privacy policy',
      Strings.restaurantLogin: 'Restaurant Login',
      Strings.restaurantName: 'Restaurant Name',
      Strings.save: 'Save',
      Strings.saturday: 'Saturday',
      Strings.selectedItem: 'Selected items',
      Strings.settings: 'Settings',
      Strings.site: 'Site',
      Strings.status: 'Status',
      Strings.sundayToThursday: 'Sunday-Thursday',
      Strings.termsOfService: 'Terms of service',
      Strings.thankYou: 'Thank you, food4good team',
      Strings.today: 'Today',
      Strings.until: 'Until',
      Strings.uploadBackgroundImage: 'Upload Background Image',
      Strings.updateDishes: 'Update Dishes',
      Strings.uploadLogo: 'Upload Logo',
      Strings.updateRestaurantData: 'Update Restaurant Data',
      Strings.uponPickupPresentOrderScreen: "Upon pickup, present order screen",
      Strings.userName: 'User Name',
      Strings.wrongPassword: 'Wrong Password',
      Strings.youDoNotHaveOpenOrders: 'You do not have open orders',
      Strings.possibleToPurchase: 'Possible to purchase',
      Strings.yourOrder: 'Your Order',
      Strings.yourOrderWillWaitAt: 'Your order will wait at ',
      Strings.myOrders: 'My Orders',
      Strings.openOrder: 'Open Orders',
      Strings.closedOrders: 'Closed Orders',
      Strings.wereBought: 'Were bought',
      Strings.currency: 'USD',
      Strings.total: 'Total',
      Strings.dishes: 'Dishes',
      Strings.items: 'Items',
      Strings.youDoNotHaveClosedOrders: 'You do not have closed orders',
      Strings.businessHasDepleteItsPortions: 'This business has depleted its portions',
      Strings.orderConfirmation: 'Order Confirmation',
      Strings.finalPrice: 'Final Price',
      Strings.pleaseAddFinalPrice: 'Please add final price',
      Strings.finalPriceWillBeAddedBySupplier: 'Final price will be added by the supplier',
      Strings.confirm: 'CONFIRM',
      Strings.cancelOrder: 'CANCEL ORDER',
      Strings.pleaseArriveDuringPickupHours: 'Please arrive during pickup hours and present this',
      Strings.toConfirmOrder: 'confirm order',
      Strings.slideWillBeDoneBySupplier: 'Slide will be done by supplier',
      Strings.navigation: 'NAVIGATION',
      Strings.fromMe: ' from me',
      Strings.doYouWantToCancelOrder: 'Do you want to cancel this order?',
      Strings.orderDelivered: 'order delivered',
      Strings.anotherOrder: 'ANOTHER ORDER',
      Strings.pleaseAddFinalNumOfDishes: 'Please add number of dishes',

      //Drawer
      Strings.connectToBusiness: 'Connect to Business',
      Strings.logout: 'Logout',
      Strings.version: 'Version',
      Strings.share: 'Share',
      Strings.yes: 'Yes',
      Strings.no: 'No',

      //aboutScreenText
      Strings.areYouHungryAndFrustrated:
          'Are you hungry and frustrated about the high prices of getting food from outside?',
      Strings.weAreTheSolution: 'We have the solution for you!',
      Strings.food4GoodDeliciousLowCost: 'Food4Good - delicious low cost food from restaurants'
          'For you and for the environment',
      Strings.didYouKnow: 'Did you know?',
      Strings.inIsraelEveryYear:
          'In Israel, every year 2.3 million ton food are thrown to waste, estimated as 20 billion shekels',
      Strings.ridiculous: "It's ridiculous.",
      Strings.weDecidedToTakeAction:
          'So we decided to take action, enabling businesses to sell instead of throw, and for you, to get the best deals on excellent restaurant dishes',
      Strings.howThisWorks: "So how this works?",
      Strings.likeFood4GoodPage: '1. Like Food4Good page',
      Strings.getLinkforAppDownload: '2. Get link for application download',
      Strings.chooseGreatDishes: '3. Choose great dishes from businesses all around you',
      Strings.goToPickUpYourOrderAndPay: '4. go to pick up your order and pay at the restaurant',
      Strings.tellAllYourFriends: '5. Tell all your friends!',
      Strings.forFurtherInformationPleaseVisitOurWebsite: 'For further information please visit our website',
      Strings.pleaseHelpUsSpreadTheWord: 'please help us spread the word and together we can help the environment',

      //loading
      Strings.loadingSuppliers: 'Loading Suppliers',
      Strings.loadingOrders: 'Loading Orders',
    },
    'he': {
      //aboutScreenText
      Strings.areYouHungryAndFrustrated: 'רעבים ומתבאסים להוציא הרבה כסף על משלוח או שפשוט אין לכם כוח לבשל?',
      Strings.weAreTheSolution: 'אנחנו הפתרון!',
      Strings.food4GoodDeliciousLowCost: 'מיזם Food4Good - הזמנת אוכל טעים ואיכותי, בשבילכם ובשביל הסביבה.',
      Strings.didYouKnow: 'הידעתם?',
      Strings.inIsraelEveryYear: 'בישראל נזרקים מדי שנה 2.3 מיליון טון מזון. שמוערכים בכ- 20 מיליארד ש"ח!!',
      Strings.ridiculous: "אבסורד נכון?",
      Strings.weDecidedToTakeAction:
          "אז החלטנו לקחת את האחריות לידיים ולאפשר לעסקים למכור במקום לזרוק. ולכם להרוויח מנות מעולות בהנחות גדולות.",
      Strings.howThisWorks: "ותכל'ס איך זה עובד?",
      Strings.likeFood4GoodPage: '1. עושים לייק לעמוד',
      Strings.getLinkforAppDownload: '2. מקבלים בהמשך לינק להורדת האפליקציה',
      Strings.chooseGreatDishes: '3. בוחרים מנות מעולות מעסקים סביבכם',
      Strings.goToPickUpYourOrderAndPay: '4. מגיעים לאסוף ולשלם בבית העסק',
      Strings.tellAllYourFriends: '5. מספרים לחברים איך היה!',
      Strings.forFurtherInformationPleaseVisitOurWebsite: 'תוכלו לקרוא עלינו עוד באתר: ',
      Strings.pleaseHelpUsSpreadTheWord: 'מוזמנים לשתף ולהפיץ את הבשורה ויחד נשמור על עולם ירוק יותר.',

      Strings.address: 'בכתובת',
      Strings.andConfirmWithSupplier: 'ולאשר מול בית העסק',
      Strings.appName: 'Food4Good',
      Strings.checkOutOtherSuppliers: 'לעוד בתי עסק',
      Strings.confirmOrderAppbar: 'אישור הזמנה',
      Strings.confirmOrderButton: 'לאישור הזמנה',
      Strings.errorInPlaceOrder: 'שגיאה בקבלת ההזמנה',
      Strings.estimatedPayment: 'תשלום משוער',
      Strings.estimatedPayment1Parameter: 'תשלום משוער %d שח',
      Strings.estimatedPayment2Parameters: 'תשלום משוער %d-%d שח',
      Strings.discount: 'הנחה',
      Strings.duringPickupHours: 'בשעות ',
      Strings.finalPriceWillBeSetByTheSupplier: 'מחיר סופי ותשלום יתבצע מול בית העסק',
      Strings.homePage: 'עמוד הבית',
      Strings.joinUs: 'כולנו ביחד נרתמים למען מניעת זריקת אוכל',
      Strings.lblSearchByBusinessName: 'חפש לפי שם בית העסק',
      Strings.login: 'התחבר',
      Strings.toMyOrders: 'להזמנות שלי',
      Strings.orderButton: 'להזמנה',
      Strings.orderIsDone: 'ההזמנה בוצעה!',
      Strings.notifications: 'התראות',
      Strings.pickupTime: 'זמן איסוף',
      Strings.selectHowManyItemsToSave: 'בוחרים כמות יחידות להצלה',
      Strings.selectedItem: 'המנה שנבחרה',
      Strings.termsOfService: 'תנאי שימוש',
      Strings.thankYou: 'תודה מצוות Foof4Good',
      Strings.thePaymentWillBeHandledBySupplier: 'ובהמשך התשלום מתבצע מול בית העסק',
      Strings.toOrderPleaseSelectNoOfItems: 'להזמנה יש לבחור כמות.',
      Strings.uponPickupPresentOrderScreen: 'במעמד לקיחת ההזמנה יש להציג את מסך ההזמנה',
      Strings.userName: 'שם משתמש',
      Strings.wrongPassword: 'סיסמא לא נכונה',
      Strings.password: 'סיסמא',
      Strings.youCanSelectUpToThreeItems: ' (ניתן לבחור עד 3 יחידות)',
      Strings.yourOrderWillWaitAt: 'ההזמנה תצפה לך ב ',
      Strings.possibleToPurchase: 'ניתן לרכוש',
      Strings.youDoNotHaveOpenOrders: 'אין לך הזמנות פתוחות',
      Strings.yourOrder: 'ההזמנה שלך',
      Strings.myOrders: 'ההזמנות שלי',
      Strings.openOrder: 'פתוחות',
      Strings.close: 'סגור',
      Strings.open: 'פתוח',
      Strings.closedOrders: 'סגורות',
      Strings.date: 'תאריך',
      Strings.wereBought: 'נקנו',
      Strings.currency: ' ש"ח',
      Strings.total: 'סך תשלום',
      Strings.dishes: ' מנות',
      Strings.items: 'יחידות',
      Strings.priceRange: 'טווח מחירים',
      Strings.youDoNotHaveClosedOrders: 'אין לך הזמנות סגורות',
      Strings.orderConfirmation: 'אישור הזמנה',
      Strings.finalPrice: 'מחיר סופי',
      Strings.pleaseAddFinalPrice: 'יש להזין את החיוב הסופי עבור ההזמנה',
      Strings.finalPriceWillBeAddedBySupplier: 'ההזנה תתבצע ע"י בית העסק בלבד',
      Strings.confirm: 'אישור',
      Strings.cancelOrder: 'ביטול הזמנה',
      Strings.pleaseArriveDuringPickupHours: 'יש להגיע למסעדה בשעות המצויינות ולהציג קבלה זו',
      Strings.toConfirmOrder: 'לאישור אסיפת הזמנה',
      Strings.slideWillBeDoneBySupplier: 'ההחלקה תתבצע ע"י בית העסק בלבד',
      Strings.navigation: 'ניווט',
      Strings.fromMe: ' ממני',
      Strings.doYouWantToCancelOrder: 'לבטל הזמנה?',
      Strings.orderDelivered: 'ההזמנה נאספה',
      Strings.anotherOrder: 'להזמנה נוספת',
      Strings.pleaseAddFinalNumOfDishes: 'יש להזין מספר מנות שנאספו',

      //Drawer
      Strings.connectToBusiness: 'התחבר לבית העסק',
      Strings.logout: 'התנתק',
      Strings.version: 'גירסה',
      Strings.share: 'שתף',
      Strings.privacyPolicy: 'מדיניות הפרטיות',
      Strings.contact: 'צור קשר',
      Strings.about: 'אודות',
      Strings.faq: 'שאלות ותשובות',
      Strings.yes: 'כן',
      Strings.no: 'לא',
      Strings.businessHasDepleteItsPortions: 'היום העסק הציל את המנות שלו',

      //loading
      Strings.loadingSuppliers: 'טוען ספקים',
      Strings.loadingOrders: 'טוען הזמנות',
    },
  };

  String getString(Object code) {
    var localized = _localizedValues[locale.languageCode][code];
    if (localized == null) {
      localized = _localizedValues['en'][code];
      if (localized == null) {
        localized = code.toString();
      }
    }
    return localized;
  }

  String _sprintf(String template, List replacements) {
    var regExp = RegExp(placeholderPattern);
    assert(
        regExp.allMatches(template).length == replacements.length, "Template and Replacements length are incompatible");

    for (var replacement in replacements) {
      template = template.replaceFirst(regExp, replacement.toString());
    }

    return template;
  }
}
