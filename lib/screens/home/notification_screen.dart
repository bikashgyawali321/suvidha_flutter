import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:suvidha/extensions.dart';
import 'package:suvidha/models/notification_model.dart';
import 'package:suvidha/services/custom_hive.dart';
import 'package:suvidha/widgets/loading_screen.dart';

class NotificationScreenProvider extends ChangeNotifier {
  CustomHive _customHive = CustomHive();
  List<NotificationModel> notifications = [];
  bool loading = false;
  final BuildContext context;

  NotificationScreenProvider(this.context) {
    getAllNotifications();
  }
  //get all unread notifications
  Future<void> getAllNotifications() async {
    loading = false;
    notifyListeners();
    final response = await _customHive.getNotifications();
    notifications = response;
    notifyListeners();
  }

  Future<void> markNotificationAsRead(String orderId) async {
    await _customHive.markNotificationAsRead(orderId);
    notifyListeners();
  }

  List<NotificationModel> get getFilteredNotifications {
    if (notifications.isNotEmpty) {
      return notifications
          .where((notification) => notification.date
              .isAfter(DateTime.now().subtract(Duration(days: 30))))
          .toList();
    }
    return [];
  }

  void deleteAllNotifications() {
    _customHive.deleteAllNotifications();
    notifyListeners();
  }
}

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: ChangeNotifierProvider(
        create: (_) => NotificationScreenProvider(context),
        builder: (context, child) => Consumer<NotificationScreenProvider>(
          builder: (context, provider, child) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (provider.loading) LoadingScreen(),
                    if (provider.notifications.isEmpty) ...[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.4,
                          ),
                          Center(
                            child: Icon(
                              Icons.notifications_off,
                              size: 70,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'No Active Notifications ',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              "Looks like there are no active notifications from the past 30 days",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      )
                    ],
                    for (final notification in provider.notifications) ...[
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 20,
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainer,
                              child: Icon(
                                notification.isRead == true
                                    ? Icons.notifications
                                    : Icons.notifications_active,
                              ),
                            ),
                            title: Text(
                              notification.title,
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('View Details'),
                                Icon(
                                  Icons.chevron_right,
                                  size: 20,
                                ),
                              ],
                            ),
                            subtitle: Text(notification.date.toVerbalDateTime),
                            onTap: () async {
                              await provider
                                  .markNotificationAsRead(notification.orderId);
                              context.push('/order/${notification.orderId}');
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                    ]
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
