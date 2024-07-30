import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class TripsHistoryPage extends StatefulWidget {
  const TripsHistoryPage({super.key});

  @override
  State<TripsHistoryPage> createState() => _TripsHistoryPageState();
}

class _TripsHistoryPageState extends State<TripsHistoryPage> {
  final completedTripRequestsOfCurrentDriver =
      FirebaseDatabase.instance.ref().child("tripRequests");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.white,
        shadowColor: Colors.white,
        backgroundColor: Colors.white,
        title:  Text(
          'Trips History'.tr(),
          style: const TextStyle(
            color: Colors.black87,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          // Fixed image
          Container(
            height: 180,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/data1.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 20,),
          Expanded(
            child: StreamBuilder(
              stream: completedTripRequestsOfCurrentDriver.onValue,
              builder: (BuildContext context, snapshotData) {
                if (snapshotData.hasError) {
                  return  Center(
                    child: Text(
                      "Error Occurred.".tr(),
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                }

                if (!(snapshotData.hasData)) {
                  return  Center(
                    child: Text(
                      "No record found.".tr(),
                      style: TextStyle(color: Colors.black54),
                    ),
                  );
                }

                Map dataTrips = snapshotData.data!.snapshot.value as Map;
                List tripsList = [];
                dataTrips.forEach((key, value) => tripsList.add({"key": key, ...value}));

                return ListView.builder(
                  itemCount: tripsList.length,
                  itemBuilder: (context, index) {
                    if (tripsList[index]["status"] != null &&
                        tripsList[index]["status"] == "ended" &&
                        tripsList[index]["driverID"] ==
                            FirebaseAuth.instance.currentUser!.uid) {
                      return Card(
                        color: const Color.fromARGB(255, 3, 22, 60),
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Pickup - fare amount
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/person-placeholder.png',
                                    height: 16,
                                    width: 16,
                                  ),
                                  const SizedBox(
                                    width: 18,
                                  ),
                                  Expanded(
                                    child: Text(
                                      tripsList[index]["pickUpAddress"]
                                          .toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.white60,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "₹ ${tripsList[index]["fareAmount"]}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white60,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(
                                height: 8,
                              ),

                              // Dropoff
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/person-placeholder1.png',
                                    height: 16,
                                    width: 16,
                                  ),
                                  const SizedBox(
                                    width: 18,
                                  ),
                                  Expanded(
                                    child: Text(
                                      tripsList[index]["dropOffAddress"]
                                          .toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                );
              },
            ),
          ),
          
        ],
      ),
    );
  }
}
