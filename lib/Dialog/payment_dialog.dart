import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kumari_drivers/Methords/common_methords.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:restart_app/restart_app.dart';

class PaymentDialog extends StatefulWidget {
  final String fareAmount;
  // final String fareAmount1;
  // final String fareAmount2;

  const PaymentDialog({
    super.key,
    required this.fareAmount,
    //  required this.fareAmount1,
    //  required this.fareAmount2,
  });

  @override
  State<PaymentDialog> createState() => _PaymentDialogState();
}

class _PaymentDialogState extends State<PaymentDialog> {
  CommonMethods cMethods = CommonMethods();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      backgroundColor: Colors.black54,
      child: Container(
        margin: const EdgeInsets.all(5.0),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.black87, borderRadius: BorderRadius.circular(6)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 8,
            ),
            Image.asset(
              "assets/images/money.png",
              height: 100,
              width: 200,
            ),
            const SizedBox(
              height: 21,
            ),
             Text(
              "COLLECT CASH".tr(),
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(
              height: 21,
            ),
            const Divider(
              height: 1.5,
              color: Colors.white70,
              thickness: 1.0,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "₹${widget.fareAmount}",
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Text(
                    "This Is fare Amount".tr(),
                    style: const TextStyle(color: Colors.grey),
                  ),
                   Text(
                    " (₹ ${widget.fareAmount})".tr(),
                    style: const TextStyle(color: Colors.grey),
                  ),
                   Text(
                    "to be charged frome the user.".tr(),
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              ),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);

                cMethods.turnOnLocationUpdatesForHomePage();

                Restart.restartApp();
              },
              child:  Text(
                "COLLECT CASH".tr(),
                style: const TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
