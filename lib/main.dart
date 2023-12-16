import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:themanager/common/utils/constants.dart';
import 'package:themanager/features/auth/controllers/user_controller.dart';
import 'package:themanager/features/onboarding/pages/onboarding.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:themanager/features/todo/pages/home_page.dart';
import 'package:themanager/firebase_options.dart';
import 'common/models/user_model.dart';
import 'common/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  static final defaultLightColorScheme =
      ColorScheme.fromSwatch(primarySwatch: Colors.blue);
  static final defaultDarkColorScheme = ColorScheme.fromSwatch(
      brightness: Brightness.dark, primarySwatch: Colors.blue);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(userProvider.notifier).refresh();
    List<UserModel> users = ref.watch(userProvider);
    return ScreenUtilInit(
        useInheritedMediaQuery: true,
        designSize: const Size(375, 825),
        minTextAdapt: true,
        builder: (context, child) {
          return DynamicColorBuilder(
              builder: (lightcolorscheme, darkcolorscheme) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              themeMode: ThemeMode.dark,
              theme: ThemeData(
                scaffoldBackgroundColor: AppConsts.kBkDark,
                colorScheme: lightcolorscheme ?? defaultLightColorScheme,
                useMaterial3: true,
              ),
              darkTheme: ThemeData(
                  scaffoldBackgroundColor: AppConsts.kBkDark,
                  colorScheme: darkcolorscheme ?? defaultDarkColorScheme,
                  useMaterial3: true),
              home: users.isEmpty ? OnBoarding() : HomePage(),
              onGenerateRoute: Routes.onGenerateRoute,
            );
          });
        });
  }
}



