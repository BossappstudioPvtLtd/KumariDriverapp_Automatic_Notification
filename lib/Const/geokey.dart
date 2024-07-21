import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

String userName = ""; 



String googleMapKey = "AIzaSyCD2x1sLVhV6WHV78aDoGB2r2KxoyVUP_I";  //api key 1

const CameraPosition googlePlexInitialPosition = CameraPosition(
  target: LatLng(8.088306,  77.538452),
  zoom: 14.4746,
);



StreamSubscription<Position>? positionStreamHomePage;
StreamSubscription<Position>? positionStreamNewTripPage;

int driverTripRequestTimeout = 20;

final audioPlayer = AssetsAudioPlayer();


Position? driverCurrentPosition;

String driverName = "";
String driverPhone = "";
String driverPhoto = "";
dynamic carSeats = "";
String carModel ="";
String carNumber ="";

