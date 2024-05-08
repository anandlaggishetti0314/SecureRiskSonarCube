import 'package:flutter/material.dart';

class OTPScreen extends StatefulWidget {
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  List<String> otpDigits = List.filled(6, '');

  void updateDigit(int index, String value) {
    setState(() {
      otpDigits[index] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                6,
                (index) => OTPDigitBox(
                  digit: otpDigits[index],
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 200,
              child: TextField(
                keyboardType: TextInputType.number,
                maxLength: 6,
                onChanged: (value) {
                  for (int i = 0; i < 6; i++) {
                    if (i < value.length) {
                      updateDigit(i, value[i]);
                    } else {
                      updateDigit(i, '');
                    }
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Enter OTP',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OTPDigitBox extends StatelessWidget {
  final String digit;

  const OTPDigitBox({required this.digit});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      margin: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(4),
      ),
      alignment: Alignment.center,
      child: Text(
        digit,
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
