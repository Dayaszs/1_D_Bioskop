import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/formComponent.dart';
import 'package:flutter_application_1/utilities/constant.dart';
import 'package:flutter_application_1/data/penayangan.dart';
import 'package:flutter_application_1/view/movie_view/payment.dart';

class SelectSeat extends StatefulWidget {
  const SelectSeat({super.key});

  @override
  State<SelectSeat> createState() => _SelectSeatState();
}

class _SelectSeatState extends State<SelectSeat> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Select Seat', style: textStyle7),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.amber, Colors.black],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        border: Border(
                          top: BorderSide(
                            color: Colors.amber, // Warna border
                            width: 3.0, // Ketebalan border
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Text("\n"),
                        ],
                      )),
                  SizedBox(height: 24),
                  Container(
                    // decoration: BoxDecoration(
                    //   border: Border(
                    //     top: BorderSide(
                    //       color: Colors.grey, // Warna border
                    //       width: 1.0, // Ketebalan border
                    //     ),
                    //     bottom: BorderSide(
                    //       color: Colors.grey, // Warna border
                    //       width: 1.0, // Ketebalan border
                    //     ),
                    //     right: BorderSide(
                    //       color: Colors.grey, // Warna border
                    //       width: 1.0, // Ketebalan border
                    //     ),
                    //     left: BorderSide(
                    //       color: Colors.grey, // Warna border
                    //       width: 1.0, // Ketebalan border
                    //     ),
                    //   ),
                    // ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 150,
                              height: 310,
                              child: GridView.count(
                                crossAxisCount: 5,
                                mainAxisSpacing: 2,
                                crossAxisSpacing: 2,
                                children: List.generate(50, (index) {
                                  return Container(
                                    alignment: Alignment.center,
                                    width: 13,
                                    height: 13,
                                    decoration: BoxDecoration(
                                      color:
                                          const Color.fromARGB(255, 55, 55, 55),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                    ),
                                    child: Text('A${index + 1}',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.white,
                                        )),
                                  );
                                }),
                              ),
                            ),
                            SizedBox(
                              width: 150,
                              height: 310,
                              child: GridView.count(
                                crossAxisCount: 5,
                                mainAxisSpacing: 2,
                                crossAxisSpacing: 2,
                                children: List.generate(50, (index) {
                                  return Container(
                                    alignment: Alignment.center,
                                    width: 13,
                                    height: 13,
                                    decoration: BoxDecoration(
                                      color:
                                          const Color.fromARGB(255, 55, 55, 55),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                    ),
                                    child: Text('B${index + 1}',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.white,
                                        )),
                                  );
                                }),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 13,
                                  height: 13,
                                  color: Color.fromRGBO(97, 97, 97, 1),
                                ),
                                SizedBox(width: 5),
                                Text("Available",
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.white))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 13,
                                  height: 13,
                                  color: Color.fromRGBO(243, 198, 49, 0.604),
                                ),
                                SizedBox(width: 5),
                                Text("Reserved",
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.white))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 13,
                                  height: 13,
                                  color: Colors.amber,
                                ),
                                SizedBox(width: 5),
                                Text("Selected",
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.white))
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  Container(
                    // decoration: BoxDecoration(
                    //   border: Border(
                    //     top: BorderSide(
                    //       color: Colors.grey, // Warna border
                    //       width: 1.0, // Ketebalan border
                    //     ),
                    //     bottom: BorderSide(
                    //       color: Colors.grey, // Warna border
                    //       width: 1.0, // Ketebalan border
                    //     ),
                    //     right: BorderSide(
                    //       color: Colors.grey, // Warna border
                    //       width: 1.0, // Ketebalan border
                    //     ),
                    //     left: BorderSide(
                    //       color: Colors.grey, // Warna border
                    //       width: 1.0, // Ketebalan border
                    //     ),
                    //   ),
                    // ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Select Date & Time", style: textStyle7),
                        SizedBox(height: 10),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: List.generate(14, (index) {
                              return Row(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.only(
                                        top: 10, left: 3, right: 3, bottom: 3),
                                    decoration: BoxDecoration(
                                      color:
                                          const Color.fromARGB(255, 44, 44, 44),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Oct",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            )),
                                        SizedBox(height: 15),
                                        Container(
                                          width: 50,
                                          height: 50,
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 81, 81, 81),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(100)),
                                          ),
                                          child: Text("${index + 1}",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10)
                                ],
                              );
                            }),
                          ),
                        ),
                        SizedBox(height: 10),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: List.generate(8, (index) {
                              return Row(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 20),
                                    decoration: BoxDecoration(
                                      color:
                                          const Color.fromARGB(255, 44, 44, 44),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                    ),
                                    child: Text("${index + 7}:00",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        )),
                                  ),
                                  SizedBox(width: 8),
                                ],
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // layar
                  // kursi
                  // keterangan
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.grey, // Warna border
                width: 1.0, // Ketebalan border
              ),
            ),
          ),
          child: BottomAppBar(
            color: Colors.black,
            child: Container(
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total: \nRp. 0,00',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Payment(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: const Text(
                      'Buy Ticket',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NarrowLayout extends StatelessWidget {
  const NarrowLayout({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class WideLayout extends StatelessWidget {
  const WideLayout({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
