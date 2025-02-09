// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// import 'package:suvidha/providers/theme_provider.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title:
//             Text('सुविधा', style: Theme.of(context).textTheme.headlineMedium),
//         actions: [
//           IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
//           IconButton(
//             onPressed: () {
//               context.push('/profile');
//             },
//             icon: const Icon(
//               Icons.account_circle_outlined,
//               size: 30,
//             ),
//           ),
//         ],
//         centerTitle: true,
//       ),
//       body: SafeArea(
//           child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
//         child: CustomScrollView(
//           physics: AlwaysScrollableScrollPhysics(),
//           slivers: [
//             SliverToBoxAdapter(
//               child: Text(
//                 'Who are you looking for?',
//                 style: Theme.of(context).textTheme.titleLarge,
//               ),
//             ),
//             SliverToBoxAdapter(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Text(
//                     'Choose a service to get started.',
//                     style: Theme.of(context).textTheme.bodyLarge,
//                   ),
//                   SizedBox(
//                     height: 10,
//                   )
//                 ],
//               ),
//             ),
//             SliverGrid.builder(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2, childAspectRatio: 2.4),
//               itemCount: offeredServiceList.offeredService.length,
//               itemBuilder: (_, index) {
//                 final service = offeredServiceList.offeredService[index];
//                 return GestureDetector(
//                   // onTap: () {
//                   //   context.push('/service/${service.name}');
//                   // },
//                   child: Card(
//                     color: Color.lerp(
//                       Theme.of(context).colorScheme.surfaceContainer,
//                       service.name.toColor,
//                       0.7,
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         children: [
//                           ClipOval(
//                             child: Image.asset(
//                               service.imageUrl,
//                               height: 56,
//                             ),
//                           ),
//                           SizedBox(width: 10),
//                           Text(
//                             service.name,
//                             style: Theme.of(context).textTheme.bodyLarge,
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             )
//           ],
//         ),
//       )),
//     );
//   }
// }

// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_field

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:suvidha/providers/auth_provider.dart';
import 'package:suvidha/providers/location_provider.dart';
import 'package:suvidha/providers/theme_provider.dart';
import 'package:suvidha/screens/ask_permission.dart';
import 'package:suvidha/screens/home/bookings.dart';
import 'package:suvidha/screens/home/dashboard.dart';
import 'package:suvidha/screens/home/orders.dart';
import 'package:suvidha/services/notification.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int index = 1;
  late TabController _tabController;
  NotificationService get notificationService =>
      context.read<NotificationService>();
  final ScrollController _mainContentScroller = ScrollController();

  @override
  void initState() {
    _tabController = TabController(
      length: 3,
      vsync: this,
    );
    if (notificationService.canAskPermission) {
      Future.delayed(const Duration(seconds: 3)).then((e) {
        AskPermission.show(context);
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final LocationProvider locationProvider = context.watch<LocationProvider>();
    final AuthProvider authProvider = context.watch<AuthProvider>();
    final _authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Suvidha',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        centerTitle: false,
        titleSpacing: 15,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GestureDetector(
              onTap: () => context.push(
                '/profile',
              ),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Theme.of(context).colorScheme.secondary,
                backgroundImage: authProvider.user?.profilePicture != null
                    ? NetworkImage(authProvider.user!.profilePicture!)
                    : null,
                child: authProvider.user?.profilePicture == null
                    ? Icon(
                        Icons.person,
                        size: 30,
                      )
                    : SizedBox(),
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(index == 1 ? 35 : 20),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 0, 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.location_pin,
                      size: 20,
                    ),
                    Text(
                      locationProvider.loading
                          ? 'Fetching location...'
                          : locationProvider.currentAddress ??
                              'Location not found',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                    ),
                  ],
                ),
                index == 1
                    ? Text(
                        _authProvider.greetingMessage,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.italic,
                            ),
                      )
                    : SizedBox(),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          IndexedStack(
            index: index,
            children: [
              BookingsScreen(),
              Dashboard(),
              Orders(),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.08,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? suvidhaDark
                      : Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () => setState(() {
                          index = 0;
                        }),
                        child: Column(
                          children: [
                            Icon(
                              Icons.event,
                              size: index == 0 ? 30 : 25,
                              color: index == 0
                                  ? Theme.of(context)
                                      .colorScheme
                                      .primaryContainer
                                  : Theme.of(context).colorScheme.onSurface,
                            ),
                            Text(
                              'Bookings',
                              style: TextStyle(
                                color: index == 0
                                    ? Theme.of(context)
                                        .colorScheme
                                        .primaryContainer
                                    : Theme.of(context).colorScheme.onSurface,
                                fontWeight: index == 0
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => setState(() {
                          index = 1;
                        }),
                        child: Column(
                          children: [
                            Icon(
                              Icons.house,
                              size: index == 1 ? 30 : 25,
                              color: index == 1
                                  ? Theme.of(context)
                                      .colorScheme
                                      .primaryContainer
                                  : Theme.of(context).colorScheme.onSurface,
                            ),
                            Text(
                              'Home',
                              style: TextStyle(
                                color: index == 1
                                    ? Theme.of(context)
                                        .colorScheme
                                        .primaryContainer
                                    : Theme.of(context).colorScheme.onSurface,
                                fontWeight: index == 1
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => setState(() {
                          index = 2;
                        }),
                        child: Column(
                          children: [
                            Icon(
                              Icons.history,
                              size: index == 2 ? 30 : 25,
                              color: index == 2
                                  ? Theme.of(context)
                                      .colorScheme
                                      .primaryContainer
                                  : Theme.of(context).colorScheme.onSurface,
                            ),
                            Text(
                              'Orders',
                              style: TextStyle(
                                color: index == 2
                                    ? Theme.of(context)
                                        .colorScheme
                                        .primaryContainer
                                    : Theme.of(context).colorScheme.onSurface,
                                fontWeight: index == 2
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
