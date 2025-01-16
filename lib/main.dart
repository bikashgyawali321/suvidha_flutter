import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:suvidha/screens/home/home.dart';
import 'package:suvidha/screens/splash.dart';

import 'providers/auth_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/home/profile.dart';
import 'screens/auth/login.dart';
import 'screens/auth/register.dart';
import 'services/auth_service.dart';
import 'services/custom_hive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => AuthProvider(_)),
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
    GoRoute(path: '/profile', builder: (context, state) => Profile()),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'सुविधा',
      themeMode: context.watch<ThemeProvider>().themeMode,
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.light(
          primary: const Color(0xFF6200EE),
          secondary: const Color(0xFF03DAC6),
          surface: Colors.white,
          error: const Color(0xFFB00020),
          onPrimary: Colors.white,
          onSecondary: Colors.black,
          onSurface: Colors.black,
          onError: Colors.white,
          brightness: Brightness.light,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.black12),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        ),
        dividerTheme: const DividerThemeData(
          space: 0,
          thickness: 2,
          color: Colors.black12,
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: ButtonStyle(
            padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(
              const EdgeInsets.symmetric(vertical: 16),
            ),
            backgroundColor: WidgetStatePropertyAll<Color>(
              Colors.lightGreen,
            ),
            foregroundColor: WidgetStatePropertyAll<Color>(
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
        floatingActionButtonTheme: FloatingActionButtonThemeData(
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
          color: Colors.blueGrey[200],
        ),
      ),
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          fontFamily: 'Euclid',
          colorScheme: ColorScheme.dark(
            primary: const Color(0xFFBB86FC),
            secondary: const Color(0xFF03DAC6),
            surface: const Color(0xFF121212),
            error: const Color(0xFFCF6679),
            onPrimary: Colors.black,
            onSecondary: Colors.black,
            onSurface: Colors.white,
            onError: Colors.black,
            brightness: Brightness.dark,
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xFFE0E0E0)),
            ),
          ),
          dividerTheme: const DividerThemeData(
            space: 0,
            thickness: 1,
            color: Color(0xFFE0E0E0),
          ),
          filledButtonTheme: FilledButtonThemeData(
            style: ButtonStyle(
              padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(
                const EdgeInsets.symmetric(vertical: 16),
              ),
              backgroundColor: WidgetStatePropertyAll<Color>(Colors.lightGreen),
              foregroundColor: WidgetStatePropertyAll<Color>(
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
          floatingActionButtonTheme: FloatingActionButtonThemeData(
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
            color: Colors.blueGrey[600],
          )),
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}
