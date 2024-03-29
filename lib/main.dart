import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_pages_root.dart';
import 'package:nano_tech_cosmetic/core/localization/local_controller.dart';
import 'package:nano_tech_cosmetic/features/auth/data/models/user_model.dart';
import 'package:nano_tech_cosmetic/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:nano_tech_cosmetic/core/constants/app_translations.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/entities/user_entity.dart';
import 'package:nano_tech_cosmetic/injection_countainer.dart' as di;
// import 'dart:io';

User? globalUser; //TODO: يجب وضعها  فارغة عند كل حدث في الرموت و الوكل في البداية مباشرة
String? globalMessage;

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // HttpOverrides.global = MyHttpOverrides();
  await di.init();
  initializeTokenAndCustomer();
  runApp(const MyApp());
}

void initializeTokenAndCustomer() async {
  await Future.delayed(const Duration(seconds: 2));
  FlutterNativeSplash.remove();
  try {
    UserModel userModel = await di.sl<AuthLocalDataSource>().getCachedUser();
    if (kDebugMode) {
      print('userModel');
      print(userModel);
    }
    globalUser = User(
      firstName: userModel.firstName,
      lastName: userModel.lastName,
      gender: userModel.gender,
      birthday: userModel.birthday,
      address: userModel.address,
      phone: userModel.phone,
      email: userModel.email,
      facebook: userModel.facebook,
      twitter: userModel.twitter,
      instagram: userModel.instagram,
      telegram: userModel.telegram,
      role: userModel.role,
      token: userModel.token,
      refreshToken: userModel.refreshToken,
    );
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
}

// class MyHttpOverrides extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext? context) {
//     return super.createHttpClient(context)
//       ..badCertificateCallback =
//           (X509Certificate cert, String host, int port) => true;
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LocaleController controller = Get.put(LocaleController());
    if (kDebugMode) {
      print("===================================");
      print(controller.language.toString());
    }
    return GetMaterialApp(
      title: 'Nano Tech Cosmetic',
      debugShowCheckedModeBanner: false,
      locale: controller.language,
      translations: AppTranslations(),
      theme: controller.appTheme,
      getPages: AppPagesRoutes.appPages,
      initialRoute: "/",
    );
  }
}
