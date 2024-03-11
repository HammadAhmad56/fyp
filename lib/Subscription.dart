// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F2EF),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
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
                onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: Colors.grey.shade800,),
                child: Text(
                  'Subscribe',
                  style: GoogleFonts.nunito(color: Colors.white),
                ))
          ]),
        ),
      ),
    );
  }
}
