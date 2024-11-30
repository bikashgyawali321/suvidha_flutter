import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:simple_animations/simple_animations.dart';

import '../providers/theme_provider.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  bool loading = false;

  void _handleRouting() async {
    await Future.delayed(Duration(seconds: 7));
    context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryDark,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PlayAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(seconds: 1),
              builder: (context, value, _) => Transform.scale(
                scale: Curves.easeIn.transform(value),
                child: Hero(
                    tag: 'logo',
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/icon/app_icon.png',
                          height: 200,
                        ),
                    
                        Text('सुविधा',
                            style: Theme.of(context)
                                .textTheme
                              .displayMedium
                              ?.copyWith(color: suvidhaWhite),
                        ),
                        SizedBox(
                          height: 5,
                        ),    
                        Text(
                          'घरमै सेवा, तपाइको सेवा हाम्रो प्राथमिकता',
                          style:
                              Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                    color: Colors.amber[600],
                                  fontStyle: FontStyle.italic
                                  ),
                        )
                      ],
                    )),
              ),
              onCompleted: () async {
                setState(() {
                  loading = true;
                });
                await Future.delayed(const Duration(seconds: 1));
                _handleRouting();
              },
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 90),
              child: Opacity(
                opacity: loading ? 1 : 0,
                child: LoopAnimationBuilder(
                  tween: ColorTween(begin: primary, end: secondary),
                  duration: const Duration(seconds: 2),
                  builder: (context, value, child) => LinearProgressIndicator(
                    color: value,
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
