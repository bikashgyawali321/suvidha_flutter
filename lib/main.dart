import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:suvidha/firebase_options.dart';
import 'package:suvidha/models/bookings/booking_model.dart';
import 'package:suvidha/providers/location_provider.dart';
import 'package:suvidha/providers/service_provider.dart';
import 'package:suvidha/screens/home.dart';
import 'package:suvidha/screens/home/booking/booking_details.dart';
import 'package:suvidha/screens/home/bookings.dart';
import 'package:suvidha/screens/home/services/service_providers_screen.dart';
import 'services/notification.dart';
import 'package:suvidha/screens/splash.dart';
import 'providers/auth_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/home/notification_screen.dart';
import 'screens/profile_and_settings.dart';
import 'screens/auth/login.dart';
import 'screens/auth/register.dart';
import 'services/backend_service.dart';
import 'services/custom_hive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptionsAndroid.currentPlatform,
  );

  await CustomHive().init();
  runApp(ProviderWrappedApp());
}

class ProviderWrappedApp extends StatelessWidget {
  const ProviderWrappedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => BackendService()),
        ChangeNotifierProvider(create: (_) => AuthProvider(_)),
        ChangeNotifierProvider(
          create: (_) => NotificationService(_.read<BackendService>()),
        ),
        ChangeNotifierProvider(create: (_) => ServiceProvider(_)),
        ChangeNotifierProvider(create: (_) => BookingsProvider(_)),
        ChangeNotifierProvider(create: (_) => LocationProvider()),
      ],
      child: MyApp(),
    );
  }
}

GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => Splash(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => RegisterScreen(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => Profile(),
    ),
    GoRoute(
      path: '/notification',
      builder: (context, state) => NotificationScreen(),
    ),
    GoRoute(
      path: '/booking/details',
      builder: (context, state) {
        final booking = state.extra as DocsBooking;
        return BookingDetails(
          booking: booking,
        );
      },
    ),
    GoRoute(
      path: '/service/details',
      builder: (context, state) {
        final serviceName = state.extra as String;
        return ServiceProvidersScreen(
          serviceName: serviceName,
        );
      },
    )
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'सुविधा',
      themeMode: context.watch<ThemeProvider>().themeMode,
      // themeMode: ThemeMode.dark,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: suvidhaWhite,
        colorScheme: ColorScheme.light(
          primary: Color(0xFF6200EE),
          secondary: Color(0xFF03DAC6),
          surface: Colors.white,
          error: Color(0xFFB00020),
          onPrimary: Colors.white,
          onSecondary: Colors.black,
          onSurface: Colors.black,
          onError: Colors.white,
          primaryContainer: Color(0xFF2E4E90),
          brightness: Brightness.light,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.black12),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        ),
        cardTheme: CardTheme(
            elevation: 0,
            margin: EdgeInsets.all(2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            color: Color(0xFFFFFFFF).withOpacity(0.99)),
        dividerTheme: const DividerThemeData(
          space: 0,
          thickness: 2,
          color: Colors.black12,
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: ButtonStyle(
            padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(
              EdgeInsets.symmetric(vertical: 16),
            ),
            backgroundColor: const WidgetStatePropertyAll<Color>(
              Colors.lightGreen,
            ),
            foregroundColor: const WidgetStatePropertyAll<Color>(
              Colors.white,
            ),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            minimumSize: const WidgetStatePropertyAll(
              Size(double.infinity, 50),
            ),
          ),
        ),
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: suvidhaWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.deepOrange,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        snackBarTheme: SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: Colors.black.withOpacity(0.8),
        ),
        appBarTheme: AppBarTheme(
          elevation: 0,
          centerTitle: false,
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: suvidhaDarkScaffold,
        fontFamily: 'Euclid',
        colorScheme: ColorScheme.dark(
          primary: Color(0xFFBB46FC),
          secondary: Color(0xFF03DAC6),
          surface: Color(0xFF121212),
          error: Color(0xFFCF6679),
          onPrimary: Colors.black,
          primaryContainer: Colors.green,
          onSecondary: Colors.black,
          onSurface: Colors.white,
          onError: Colors.black,
          brightness: Brightness.dark,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
          ),
        ),
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: suvidhaDarkScaffold,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        dividerTheme: const DividerThemeData(
          space: 0,
          thickness: 1,
          color: Color(0xFFE0E0E0),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: ButtonStyle(
            padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(
              EdgeInsets.symmetric(vertical: 16),
            ),
            backgroundColor:
                const WidgetStatePropertyAll<Color>(Colors.lightGreen),
            foregroundColor: const WidgetStatePropertyAll<Color>(
              Colors.white,
            ),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            minimumSize: const WidgetStatePropertyAll(
              Size(double.infinity, 50),
            ),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.deepOrange,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        snackBarTheme: SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: Colors.white.withOpacity(0.8),
        ),
        appBarTheme: AppBarTheme(
          elevation: 0,
          centerTitle: false,
          color: suvidhaDark,
        ),
        cardTheme: const CardTheme(
          elevation: 0,
          margin: EdgeInsets.all(2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          color: suvidhaDark,
        ),
      ),
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}
