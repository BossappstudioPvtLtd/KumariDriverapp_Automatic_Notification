import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:kumari_drivers/BottamNavigation/trip_histor_ypage.dart';
import 'package:kumari_drivers/components/material_buttons.dart';

class TripsPage extends StatefulWidget {
  const TripsPage({super.key});

  @override
  State<TripsPage> createState() => _TripsPageState();
}

class _TripsPageState extends State<TripsPage> {
  String currentDriverTotalTripsCompleted = "";

  getCurrentDriverTotalNumberOfTripsCompleted() async {
    DatabaseReference tripRequestsRef =
        FirebaseDatabase.instance.ref().child("tripRequests");

    await tripRequestsRef.once().then((snap) async {
      if (snap.snapshot.value != null) {
        Map<dynamic, dynamic> allTripsMap = snap.snapshot.value as Map;
        int allTripsLength = allTripsMap.length;

        List<String> tripsCompletedByCurrentDriver = [];

        allTripsMap.forEach((key, value) {
          if (value["status"] != null) {
            if (value["status"] == "ended") {
              if (value["driverID"] == FirebaseAuth.instance.currentUser!.uid) {
                tripsCompletedByCurrentDriver.add(key);
              }
            }
          }
        });

        setState(() {
          currentDriverTotalTripsCompleted =
              tripsCompletedByCurrentDriver.length.toString();
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();

    getCurrentDriverTotalNumberOfTripsCompleted();
  }

  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Text(
            "Total Trips".tr(),
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 24,
            ),
          ),
          Image.asset("assets/images/taxicity.png"),
          const SizedBox(
            height: 20,
          ),

          //Total Trips
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Text(
                "Total Trips Completed:".tr(),
                style: const TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                currentDriverTotalTripsCompleted.isNotEmpty
                    ? currentDriverTotalTripsCompleted
                    : "0",
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 20,
          ),

          //check trip history
          if (currentDriverTotalTripsCompleted.isNotEmpty)
            MaterialButtons(
              elevationsize: 20,
              text: "Check Trips History".tr(),
              textcolor: Colors.white,
              textweight: FontWeight.bold,
              containerheight: 40,
              containerwidth: 300,
              borderRadius: BorderRadius.circular(8),
              meterialColor: const Color.fromARGB(255, 15, 6, 77),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (c) => const TripsHistoryPage()));
              },
            ),
            
           
        ],
      ),
    );
  }
}
