import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:circle_progress_bar/circle_progress_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class EarningsPage extends StatefulWidget {
  const EarningsPage({super.key});

  @override
  State<EarningsPage> createState() => _EarningsPageState();
}

class _EarningsPageState extends State<EarningsPage> {
  String driverEarnings = "";

  getTotalEarningsOfCurrentDriver() async {
    DatabaseReference driversRef =
        FirebaseDatabase.instance.ref().child("drivers");

    await driversRef
        .child(FirebaseAuth.instance.currentUser!.uid)
        .once()
        .then((snap) {
      if ((snap.snapshot.value as Map)["earnings"] != null) {
        setState(() {
          driverEarnings =
              ((snap.snapshot.value as Map)["earnings"]).toString();
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getTotalEarningsOfCurrentDriver();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              color: Colors.white,
              width: 300,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    AnimatedTextKit(
                      totalRepeatCount: Duration.microsecondsPerMillisecond,
                      animatedTexts: [
                        WavyAnimatedText('Total Earnings',
                            textStyle: const TextStyle(
                                fontSize: 25, color: Colors.black87)),
                      ],
                      isRepeatingAnimation: true,
                    ),
                    // Image.asset("assets/images/totalearnings.png", width: 120,),

                    const SizedBox(
                      height: 20,
                    ),

                    CircleProgressBar(
                      foregroundColor: Colors.amber,
                      backgroundColor: Colors.black26,
                      value: 0.7,
                      strokeWidth: 20,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 100,
                            child: Image.asset(
                              "assets/images/indianrupee.png",
                            ),
                          ),
                          const AnimatedCount(
                            style: TextStyle(color: Colors.white),
                            count: 0.7,
                            unit: '%',
                            duration: Duration(milliseconds: 50),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 50,
                    ),

                    Text(
                      "\₹ " + driverEarnings,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
