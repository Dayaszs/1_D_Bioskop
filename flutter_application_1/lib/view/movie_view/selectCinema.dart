import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/formComponent.dart';
import 'package:flutter_application_1/utilities/constant.dart';
import 'package:flutter_application_1/data/cinema.dart';
import 'package:flutter_application_1/view/movie_view/selectSeat.dart';

class SelectCinema extends StatefulWidget {
  const SelectCinema({super.key});

  @override
  State<SelectCinema> createState() => _SelectCinemaState();
}

class _SelectCinemaState extends State<SelectCinema> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Nearby Cinema', style: textStyle7),
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
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(151, 118, 7, 0.479),
                        border: Border(
                          top: BorderSide(
                            color: Colors.amber, // Warna border
                            width: 1.0, // Ketebalan border
                          ),
                          bottom: BorderSide(
                            color: Colors.amber, // Warna border
                            width: 1.0, // Ketebalan border
                          ),
                          right: BorderSide(
                            color: Colors.amber, // Warna border
                            width: 1.0, // Ketebalan border
                          ),
                          left: BorderSide(
                            color: Colors.amber, // Warna border
                            width: 1.0, // Ketebalan border
                          ),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Atma Cinema Pakuwon Jogja",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "4,55km | Kab. Sleman, Daerah Istimewa Yogyakarta",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(31, 31, 31, 1),
                        // border: Border(
                        //   top: BorderSide(
                        //     color: Colors.amber, // Warna border
                        //     width: 0.0, // Ketebalan border
                        //   ),
                        //   bottom: BorderSide(
                        //     color: Colors.amber, // Warna border
                        //     width: 0.0, // Ketebalan border
                        //   ),
                        //   right: BorderSide(
                        //     color: Colors.amber, // Warna border
                        //     width: 0.0, // Ketebalan border
                        //   ),
                        //   left: BorderSide(
                        //     color: Colors.amber, // Warna border
                        //     width: 0.0, // Ketebalan border
                        //   ),
                        // ),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Atma Cinema Amplaz",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "9,32km | Kab. Sleman, Daerah Istimewa Yogyakarta",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
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
                  SelectSeat();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
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
      ),
    );
  }
}
