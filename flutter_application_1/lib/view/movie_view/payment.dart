import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/formComponent.dart';
import 'package:flutter_application_1/utilities/constant.dart';
import 'package:flutter_application_1/view/movie_view/paymentSuccess.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  TextEditingController DiscountCodeController = TextEditingController();

  List<Map<String, String>> payment = [
    {
      "image": "images/gopay.png",
      "name": "Gopay",
      "details": "",
    },
    {
      "image": "images/dana.png",
      "name": "Dana",
      "details": "",
    },
    {
      "image": "images/shopeepay.png",
      "name": "Shopee Pay",
      "details": "",
    },
    {
      "image": "images/atm.png",
      "name": "ATM",
      "details": "",
    },
    {
      "image": "images/visa.png",
      "name": "International Payments",
      "details": "(Visa, Master, JCB, Amex)",
    },
  ];

  int selectedPayment = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Payment', style: textStyle7),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.black,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 54, 54, 54),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset("images/film.png",
                              width: 100, height: 140),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Avengers Infinity War',
                                    style: TextStyle(
                                      color: Colors.amber,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    )),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.movie_creation_outlined,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 10),
                                    Text("Acton, adventure, sci-fi",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        )),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.location_city_outlined,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 10),
                                    Text("ATMA Cinema Pakuwon Jogja",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        )),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.timer_outlined,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 10),
                                    Text("09 October 2024, 11:00 WIB",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.all(0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Order ID",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              )),
                          Text("2202987203803",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Seat",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              )),
                          Text("H7, H8",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color.fromARGB(255, 58, 58, 58),
                              iconColor: Colors.white,
                              prefixIcon: Icon(Icons.discount,
                                  color: Colors.white, size: 16),
                              hintText: 'Masukkan kode diskon',
                              hintStyle:
                                  TextStyle(color: Colors.white, fontSize: 12),
                              // enabledBorder: UnderlineInputBorder(
                              //   borderSide: BorderSide(color: Colors.white), // Warna garis bawah saat tidak fokus
                              // ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 10.0),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),

                                borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 1.0), // Warna border saat fokus
                              ),
                            ),
                            style: TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                          ),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  5), // Sesuaikan nilai radius
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 17, horizontal: 20),
                          ),
                          onPressed: () {
                            // Proses kode diskon
                          },
                          child: Text('Apply',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              )),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: Colors.white, // Warna border
                            width: 1.0, // Ketebalan border
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.all(0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              )),
                          Text("Rp. 189.000,00",
                              style: TextStyle(
                                color: Colors.amber,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Text("Payment Method",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                    SizedBox(height: 10),
                    Column(
                      children: List.generate(payment.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedPayment = index;
                            });
                          },
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: (selectedPayment==index ? Color.fromRGBO(151, 118, 7, 0.479) : const Color.fromARGB(255, 51, 51, 51)),
                                    border: Border(
                                      top: BorderSide(
                                        color: (selectedPayment==index ? Colors.amber : const Color.fromARGB(0, 0, 0, 0)), // Warna border
                                        width: 1.0, // Ketebalan border
                                      ),
                                      bottom: BorderSide(
                                        color: (selectedPayment==index ? Colors.amber : const Color.fromARGB(0, 0, 0, 0)), // Warna border
                                        width: 1.0, // Ketebalan border
                                      ),
                                      right: BorderSide(
                                        color: (selectedPayment==index ? Colors.amber : const Color.fromARGB(0, 0, 0, 0)), // Warna border
                                        width: 1.0, // Ketebalan border
                                      ),
                                      left: BorderSide(
                                        color: (selectedPayment==index ? Colors.amber : const Color.fromARGB(0, 0, 0, 0)), // Warna border
                                        width: 1.0, // Ketebalan border
                                      ),
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 6),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            '${payment[index]["image"]}',
                                            width: 100,
                                            height: 50,
                                          ),
                                          SizedBox(width: 10),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              if(payment[index]["details"] != "") ...[
                                                Text('${payment[index]["name"]}',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                    )),
                                                Text('${payment[index]["details"]}',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 10,
                                                    ))
                                              ] else ...[
                                                Text('${payment[index]["name"]}',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                ))
                                              ]
                                            ],
                                          )
                                        ],
                                      ),
                                      Icon(Icons.navigate_next, color: Colors.white)
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        );
                      }),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(223, 87, 73, 37),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Complete your payment in",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "15:00",
                              style: TextStyle(
                                color: Colors.amber,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        child: BottomAppBar(
          color: Colors.black,
          child: Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PaymentSuccess(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: const Text(
                'Continue',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
