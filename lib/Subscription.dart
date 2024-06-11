// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';

class Subscription extends StatefulWidget {
  const Subscription({super.key});

  @override
  State<Subscription> createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  bool isSelected1 = false;
  bool isSelected2 = false;

  void selectButton1() {
    setState(() {
      isSelected1 = true;
      isSelected2 = false;
    });
  }

  void selectButton2() {
    setState(() {
      isSelected1 = false;
      isSelected2 = true;
    });
  }

  Map<String, dynamic>? paymentIntentData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F2EF),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          // end: Alignment.bottomLeft,
          colors: [
            Color.fromARGB(255, 237, 205, 207),
            Colors.white,
            Color.fromARGB(255, 247, 220, 211)
          ],
        )),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
            Container(
                margin: EdgeInsets.only(right: 15, top: 15),
                alignment: Alignment.topRight,
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(
                        context,
                      );
                    },
                    icon: Icon(Icons.cancel_rounded))),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                "Subscription Plan",
                style: GoogleFonts.nunito(
                    fontWeight: FontWeight.bold, fontSize: 28),
              ),
            ),
            Row(
              children: [
                Icon(Icons.check_circle, size: 20),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "2000+motivational quotes to deliver a daily \ndose of hope, inspiration, positivity, and a little \nbit of magic into your life.",
                  style: GoogleFonts.nunito(),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Icon(Icons.check_circle, size: 20),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Premium exclusive quotes.",
                  style: GoogleFonts.nunito(),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Icon(Icons.check_circle, size: 20),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Share via social media or text messages.",
                  style: GoogleFonts.nunito(),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                selectButton1();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Color.fromRGBO(46, 59, 75, 1),
                    width: 1.5,
                  ),
                ),
                height: 70,
                width: 335,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // SizedBox(height: 10,),
                          Text(
                            "\t\tMonthly Plan",
                            style: GoogleFonts.nunito(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "3 days free trial\t\t",
                            style: GoogleFonts.nunito(
                                fontSize: 16,
                                backgroundColor: Colors.grey.shade900,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 18,
                        ),
                        Text("Rs 280.00"),
                        Spacer(),
                        isSelected1
                            ? Icon(Icons.check_circle_rounded)
                            : SizedBox(),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                selectButton2();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Color.fromRGBO(46, 59, 75, 1),
                    width: 1.5,
                  ),
                ),
                height: 70,
                width: 335,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // SizedBox(height: 10,),
                          Text(
                            "\t\tYearly Plan",
                            style: GoogleFonts.nunito(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "3 days free trial\t\t",
                            style: GoogleFonts.nunito(
                                fontSize: 16,
                                backgroundColor: Colors.grey.shade900,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 18,
                        ),
                        Text("Rs 3,050.00"),
                        Spacer(),
                        isSelected2
                            ? Icon(Icons.check_circle_rounded)
                            : SizedBox(),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Spacer(),
            Center(
                child: Text(
              "Restore Purchases",
              style: GoogleFonts.nunito(
                  color: Colors.black, fontWeight: FontWeight.bold),
            )),
            Center(
                child: Text(
                    "Totally free for 3 days. And enjoy all the quotes then Rs 3,050.00 will be charged annually or Rs 2800.00/month. You can cancel it anytime. ")),
            ElevatedButton(
                onPressed: () async {
                  // final paymentMethod = await Stripe.instance.createPaymentMethod(
                  //     params: const PaymentMethodParams.card(
                  //         paymentMethodData: PaymentMethodData()));
                  await makePayment();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade800,
                ),
                child: Text(
                  'Subscribe',
                  style: GoogleFonts.nunito(color: Colors.white),
                ))
          ]),
        ),
      ),
    );
  }

  Future<void> makePayment() async {
    try {
      paymentIntentData =
          await createPaymentIntent('20', 'USD'); //json.decode(response.body);
      // print('Response body==>${response.body.toString()}');
      if (paymentIntentData == null) {
        print('Failed to create payment intent');
        return;
      }
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  setupIntentClientSecret:
                      'pk_test_51PPjIS2L9yyHmmzwVaK6GETJylZxloBOVtA7tpnJFvrP66aSnPgyCNJphE2xVYuoy5CwiLFI4KbNBPHlwbupt4cl00bFF3GsiR',
                  paymentIntentClientSecret: paymentIntentData![
                      'sk_test_51PPjIS2L9yyHmmzwATO8tPiJFzCptZjZSgdbztH8PGPN7kIE4hfGebykZplbshXFKU7mr5RIM2bXYpEu1RaVCypV00ADlq0ieu'],
                  //applePay: PaymentSheetApplePay.,
                  //googlePay: true,
                  //testEnv: true,
                  customFlow: true,
                  // style: ThemeMode.dark,
                  // merchantCountryCode: 'US',
                  merchantDisplayName: 'Hammad'))
          .then((value) {});

      ///now finally display payment sheeet
      displayPaymentSheet();
    } catch (e, s) {
      print('Payment exception:$e$s');
    }
  }

  Future <void>displayPaymentSheet() async {
    try {
      await Stripe.instance
          .presentPaymentSheet(             )
          .then((newValue) {
        print('payment intent${paymentIntentData!['id']}');
        print(
            'payment intent${paymentIntentData!['sk_test_51PPjIS2L9yyHmmzwATO8tPiJFzCptZjZSgdbztH8PGPN7kIE4hfGebykZplbshXFKU7mr5RIM2bXYpEu1RaVCypV00ADlq0ieu']}');
        print('payment intent${paymentIntentData!['amount']}');
        print('payment intent$paymentIntentData');
        //orderPlaceApi(paymentIntentData!['id'].toString());
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("paid successfully")));

        paymentIntentData = null;
      }).onError((error, stackTrace) {
        print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
      });
    } on StripeException catch (e) {
      print('Exception/DISPLAYPAYMENTSHEET==> $e');
      showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (_) => const AlertDialog(
                content: Text("Cancelled "),
              ));
    } catch (e) {
      print('$e');
    }
  }

   Future<Map<String, dynamic>> createPaymentIntent(
      String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card',
      };
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        body: body,
        headers: {
          'Authorization':
              'Bearer sk_test_51PPjIS2L9yyHmmzwATO8tPiJFzCptZjZSgdbztH8PGPN7kIE4hfGebykZplbshXFKU7mr5RIM2bXYpEu1RaVCypV00ADlq0ieu',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );
      return jsonDecode(response.body);
    } catch (err) {
      print('Error charging user: ${err.toString()}');
      return {};
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }
}
