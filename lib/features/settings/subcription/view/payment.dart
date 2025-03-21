import 'package:flutter/material.dart';
import 'package:testverygood/bootstrap.dart';
import 'package:testverygood/components/HeaderA.dart';
import 'package:testverygood/components/button.dart';

import 'package:testverygood/features/settings/subcription/view/success_pay.dart';
import 'package:testverygood/features/settings/subcription/widgets/vietqr.dart';

class VNPayQRScreen extends StatefulWidget {
  @override
  _VNPayQRScreenState createState() => _VNPayQRScreenState();
}

Future<String?> loadUUID() async {
  return await storage.read(key: 'unique_id');
}

class _VNPayQRScreenState extends State<VNPayQRScreen> {
  String qrData = '';

  @override
  void initState() {
    super.initState();
    _generateQR();
  }

  Future<void> _generateQR() async {
    String? uuid = await loadUUID();
    if (uuid != null) {
      String qrUrl = await generateVietQR(29000, uuid);
      setState(() {
        qrData = qrUrl;
      });
    }
  }

  void _confirmPayment() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SuccessScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const HeaderA(title: 'Payment'),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: qrData.isNotEmpty
                  ? Image.network(qrData)
                  : const CircularProgressIndicator(),
            ),
            const Spacer(),
            OutlineButton(
              label: 'I have paid',
              onPressed: _confirmPayment,
            ),
          ],
        ),
      ),
    );
  }
}
