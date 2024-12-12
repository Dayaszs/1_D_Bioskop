import 'package:flutter_application_1/client/PenayanganClient.dart';
import 'package:flutter_application_1/client/StudioClient.dart';
import 'package:flutter_application_1/data/film.dart';
import 'package:intl/intl.dart';
import 'package:timezone/standalone.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/formComponent.dart';
import 'package:flutter_application_1/utilities/constant.dart';
import 'package:flutter_application_1/data/penayangan.dart';
import 'package:flutter_application_1/data/bioskop.dart';
import 'package:flutter_application_1/view/movie_view/payment.dart';

class SelectSeat extends StatefulWidget {
  final Film film;
  final Bioskop bioskop;

  const SelectSeat({super.key, required this.film, required this.bioskop});

  @override
  State<SelectSeat> createState() => _SelectSeatState();
}

class _SelectSeatState extends State<SelectSeat> {
  int price = 50000;
  final formatter = NumberFormat('#,###');

  DateTime selectedDate = DateTime.now();
  DateTime selectedTime = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 7, 0);

  int selectedIndexDate = 0;
  int selectedIndexTime = 0;

  late Future<Map<String, dynamic>> studioFuture;
  late Future<Map<String, dynamic>> penayanganFuture;

  List<dynamic> statusSeat = List.filled(100, 'available');
  List<dynamic> selectedSeats = [];

  @override
  void initState() {
    super.initState();

    // Pindahkan pemanggilan ke dalam initState
    studioFuture = Studioclient().searchStudio(
      id_film: widget.film.id_film!,
      id_bioskop: widget.bioskop.idBioskop!,
    );

    studioFuture.then((studioData) {
      final idStudio = studioData['id']; // Akses ID dari hasil studioFuture

      penayanganFuture = PenayanganClient().fetchPenayangan(
          id_film: widget.film.id_film!,
          id_sesi: 1,
          id_studio: idStudio,
          tanggal_tayang: DateTime.now().toString());

      penayanganFuture.then((penayanganData) {
        List<dynamic> userSeat =
            penayanganData['nomor_kursi_terpakai'].split(',');

        for (int i = 1; i <= 100; i++) {
          if (userSeat.contains(i)) {
            statusSeat[i - 1] = "reserved";
          }
        }

        setState(() {});
      }).catchError((error) {
        // Tangani error jika `studioFuture` gagal
        print('Error fetching penayangan: $error');
      });
      setState(() {}); // Perbarui state jika diperlukan
    }).catchError((error) {
      // Tangani error jika `studioFuture` gagal
      print('Error fetching studio: $error');
    });
  }

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
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        // Jika kursi available, ubah menjadi selected
                                        if (statusSeat[(10 * (index ~/ 5) +
                                                (index % 5))] ==
                                            'available') {
                                          statusSeat[(10 * (index ~/ 5) +
                                              (index % 5))] = 'selected';
                                          selectedSeats.add((10 * (index ~/ 5) +
                                              (index % 5)) + 1);
                                        } else if (statusSeat[
                                                (10 * (index ~/ 5) +
                                                    (index % 5))] ==
                                            'selected') {
                                          // Jika kursi selected, ubah kembali ke available
                                          statusSeat[(10 * (index ~/ 5) +
                                              (index % 5))] = 'available';
                                          selectedSeats.remove(
                                              (10 * (index ~/ 5) +
                                                  (index % 5)) + 1);
                                        }
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 13,
                                      height: 13,
                                      decoration: BoxDecoration(
                                        color: (statusSeat[(10 * (index ~/ 5) +
                                                    (index % 5))] ==
                                                'available'
                                            ? (Color.fromARGB(255, 55, 55, 55))
                                            : (statusSeat[(10 * (index ~/ 5) +
                                                        (index % 5))] ==
                                                    'reserved'
                                                ? Color.fromRGBO(
                                                    243, 198, 49, 0.604)
                                                : Colors.amber)),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                      ),
                                      child: Text(
                                          '${String.fromCharCode(65 + (index ~/ 5))}${(index % 5) + 1}',
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: (statusSeat[
                                                        (10 * (index ~/ 5) +
                                                            (index % 5))] ==
                                                    'available'
                                                ? Colors.white
                                                : Colors.black),
                                          )),
                                    ),
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
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        // Jika kursi available, ubah menjadi selected
                                        if (statusSeat[(10 * (index ~/ 5) +
                                                    (index % 5)) +
                                                5] ==
                                            'available') {
                                          statusSeat[(10 * (index ~/ 5) +
                                                  (index % 5)) +
                                              5] = 'selected';
                                          selectedSeats.add((10 * (index ~/ 5) +
                                                  (index % 5)) +
                                              5 + 1);
                                        } else if (statusSeat[
                                                (10 * (index ~/ 5) +
                                                        (index % 5)) +
                                                    5] ==
                                            'selected') {
                                          // Jika kursi selected, ubah kembali ke available
                                          statusSeat[(10 * (index ~/ 5) +
                                                  (index % 5)) +
                                              5] = 'available';
                                          selectedSeats.remove((10 * (index ~/ 5) +
                                                  (index % 5)) +
                                              5 + 1);
                                        }
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 13,
                                      height: 13,
                                      decoration: BoxDecoration(
                                        color: (statusSeat[(10 * (index ~/ 5) +
                                                        (index % 5)) +
                                                    5] ==
                                                'available'
                                            ? (Color.fromARGB(255, 55, 55, 55))
                                            : (statusSeat[(10 * (index ~/ 5) +
                                                            (index % 5)) +
                                                        5] ==
                                                    'reserved'
                                                ? Color.fromRGBO(
                                                    243, 198, 49, 0.604)
                                                : Colors.amber)),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                      ),
                                      child: Text(
                                          '${String.fromCharCode(65 + (index ~/ 5))}${(index % 5) + 6}',
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: (statusSeat[
                                                        (10 * (index ~/ 5) +
                                                                (index % 5)) +
                                                            5] ==
                                                    'available'
                                                ? Colors.white
                                                : Colors.black),
                                          )),
                                    ),
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
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedIndexDate = index;
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.only(
                                          top: 10,
                                          left: 3,
                                          right: 3,
                                          bottom: 3),
                                      decoration: BoxDecoration(
                                        color: (selectedIndexDate == index
                                            ? Colors.amber
                                            : Color.fromARGB(255, 44, 44, 44)),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30)),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                              "${DateFormat('MMM').format(selectedDate.add(Duration(days: index)))}",
                                              style: TextStyle(
                                                color:
                                                    (selectedIndexDate == index
                                                        ? Colors.black
                                                        : Colors.white),
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
                                              color: (selectedIndexDate == index
                                                  ? const Color.fromARGB(
                                                      255, 32, 30, 30)
                                                  : Color.fromARGB(
                                                      255, 81, 81, 81)),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(100)),
                                            ),
                                            child: Text(
                                                "${DateFormat('dd').format(DateTime.now().add(Duration(days: index)))}",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          )
                                        ],
                                      ),
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
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedIndexTime = index;
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 20),
                                      decoration: BoxDecoration(
                                        color: (selectedIndexTime == index
                                            ? Colors.amber
                                            : Color.fromARGB(255, 44, 44, 44)),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30)),
                                      ),
                                      child: Text(
                                          "${DateFormat('HH:mm').format(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 7, 0).add(Duration(hours: (index * 2))))} - ${DateFormat('HH:mm').format(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 7, 0).add(Duration(hours: 2 + (index * 2))))}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: (selectedIndexTime == index
                                                ? Colors.black
                                                : Colors.white),
                                            fontSize: 12,
                                          )),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                ],
                              );
                            }),
                          ),
                        ),
                        Text("${widget.film.judul} \n ${widget.bioskop.namaBioskop} \n ${selectedSeats.toString()} \n ${studioFuture} \n", style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: whiteColor,
                                  ),)
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
                    'Total: \nRp. ${formatter.format(statusSeat.where((seat) => seat == 'selected').length * price)}.00',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  ElevatedButton(
                    onPressed:
                        statusSeat.where((seat) => seat == 'selected').length >
                                0
                            ? () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Payment(),
                                  ),
                                );
                              }
                            : () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: (statusSeat
                                  .where((seat) => seat == 'selected')
                                  .length >
                              0
                          ? Colors.amber
                          : Colors.grey),
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
