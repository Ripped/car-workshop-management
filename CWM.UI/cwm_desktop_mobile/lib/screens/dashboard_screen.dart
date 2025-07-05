import 'dart:convert';

import 'package:cwm_desktop_mobile/models/part.dart';
import 'package:cwm_desktop_mobile/providers/notification_provider.dart';
import 'package:cwm_desktop_mobile/providers/recommender_provider.dart';
import 'package:cwm_desktop_mobile/screens/part_details_screen.dart';
import 'package:cwm_desktop_mobile/utils/utils.dart';
import 'package:cwm_desktop_mobile/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cwm_desktop_mobile/models/notification.dart' as notification;

import '../widgets/master_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreen();
}

class _DashboardScreen extends State<DashboardScreen> {
  late RecommenderProvider _recommendProvider;
  late NotificationProvider _notificationProvider;
  List<dynamic>? recommendedParts;
  List<Part>? parts = [];
  List<notification.Notification>? _notifications = [];
  bool isLoading = true;
  bool notIsLoading = true;

  Future _loadData(int? id) async {
    if (id != null) {
      parts = (await _recommendProvider.getRecommendParts(id)).cast<Part>();
    }
    if (parts!.isEmpty) {
      setState(() {
        isLoading = true;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
    _notifications = (await _notificationProvider.getAll()).result;
    if (parts!.isEmpty) {
      setState(() {
        notIsLoading = true;
      });
    } else {
      setState(() {
        notIsLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _recommendProvider = context.read<RecommenderProvider>();
    _notificationProvider = context.read<NotificationProvider>();

    _loadData(Authorization.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: isLoading || notIsLoading
          ? SizedBox(
              height: Responsive.isDesktop(context)
                  ? 500
                  : MediaQuery.of(context).size.height,
              child: GridView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Responsive.isDesktop(context)
                    ? Axis.horizontal
                    : Axis.vertical,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: Responsive.isDesktop(context) ? 2 : 1,
                  childAspectRatio: Responsive.isDesktop(context) ? 1 : 4 / 3,
                ),
                itemCount: _notifications!.length,
                itemBuilder: _buildListNotificationsProizvodi,
              ),
            )
          : SizedBox(
              height: Responsive.isDesktop(context)
                  ? 400
                  : MediaQuery.of(context).size.height,
              child: GridView.builder(
                shrinkWrap: true,
                scrollDirection: Responsive.isDesktop(context)
                    ? Axis.horizontal
                    : Axis.vertical,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 4 / 3,
                ),
                itemCount: parts!.length,
                itemBuilder: _buildListRecommendedProizvodi,
              ),
            ),
    );
  }

  Widget? _buildListNotificationsProizvodi(BuildContext context, int index) {
    notification.Notification notif = _notifications![index];
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
                color: Colors.blueGrey,
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(3, 4)),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              notif.name,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700]),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Expanded(
              child: Text(
                maxLines: 4,
                notif.description,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800]),
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget? _buildListRecommendedProizvodi(BuildContext context, int index) {
    Part proizvod = parts![index];
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    MasterScreen("Proizvod", PartDetailsScreen(proizvod.id))));
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
                color: Colors.blueGrey,
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(3, 4)),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: proizvod.image != "" && proizvod.image != null
                  ? Image(
                      width: 100,
                      height: 250,
                      fit: BoxFit.cover,
                      image: MemoryImage(
                        base64Decode(
                          proizvod.image.toString(),
                        ),
                      ),
                    )
                  : Image(
                      width: 100,
                      height: Responsive.isDesktop(context)
                          ? 250
                          : MediaQuery.of(context).size.height / 4,
                      fit: BoxFit.cover,
                      image:
                          AssetImage('assets/images/image_not_available.png'),
                    ),
            ),
            const SizedBox(
              height: 2.0,
            ),
            Text(
              proizvod.partName,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700]),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              proizvod.serialNumber,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800]),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              '${formatNumber(proizvod.price)} KM',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }
}
