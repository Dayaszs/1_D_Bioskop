import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/penayangan.dart';
import 'package:flutter_application_1/utilities/constant.dart';
import 'package:flutter_application_1/view/movie_view/listFilm.dart';
import 'package:flutter_application_1/client/TicketClient.dart';
import 'package:flutter_application_1/client/TransaksiClient.dart';
import 'package:flutter_application_1/client/PenayanganClient.dart';

class PaymentSuccess extends StatefulWidget {
  final List<String>? listSeats;
  final Penayangan penayangan;
  final Map<String, dynamic> userData;
  final List<int> seats;
  final String? metode_pembayaran;
  final double nominal_pembayaran;

  const PaymentSuccess(
      {super.key,
      required this.listSeats,
      required this.penayangan,
      required this.userData,
      required this.seats,
      required this.metode_pembayaran,
      required this.nominal_pembayaran});

  @override
  State<PaymentSuccess> createState() => _PaymentSuccessState();
}

class _PaymentSuccessState extends State<PaymentSuccess> {
  List<Map<String, dynamic>>? listTicket = [];
  List<Map<String, dynamic>>? listTransaction = [];

  Future<Map<String, dynamic>>? ticket;
  // Map<String, dynamic>? dataTicket;
  Future<Map<String, dynamic>>? transaction;
  // Map<String, dynamic>? dataTransactions;

  List<dynamic>? list_kursi;

  void initState() {
    super.initState();
    list_kursi = widget.penayangan.nomor_kursi_terpakai!
        .split(',')
        .map((k) => int.parse(k))
        .toList();

    for (var i = 0; i < widget.seats.length; i++) {
      list_kursi!.add(widget.seats[i]);
    }

    PenayanganClient().updatePenayangan(
        idPenayangan: widget.penayangan.id_penayangan!,
        nomorKursiTerpakai: list_kursi!.join(','));

    for (var i = 0; i < widget.listSeats!.length; i++) {
      TicketClient().storeTiket(
          idUser: widget.userData['id_user'],
          idPenayangan: widget.penayangan.id_penayangan,
          nomorKursi: widget.listSeats![i]);
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
          ),
          body: FutureBuilder<Map<String, dynamic>>(
              future: ticket,
              builder: (context, ticketSnapshot) {
                if (ticketSnapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (ticketSnapshot.hasError) {
                  return Center(
                      child: Text(
                    'Error: ${ticketSnapshot.error}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors
                          .white, // Asumsikan whiteColor adalah Colors.white
                    ),
                    softWrap: true, // Properti ini pada widget Text
                    overflow: TextOverflow.visible,
                  ));
                } else if (ticketSnapshot.hasData) {
                  final Map<String, dynamic> dataTicket = ticketSnapshot.data!;
                  listTicket!.add(dataTicket);

                  if (listTicket!.length == widget.listSeats!.length) {
                    return _successWidget();
                  } else {
                    return CircularProgressIndicator();
                  }
                } else if (!ticketSnapshot.hasData) {
                  return Center(
                      child: Text(
                    'No data available.',
                    style: TextStyle(
                      fontSize: 12,
                      color: whiteColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ));
                }
              }),
          bottomNavigationBar: _bottomWidget()),
    );
  }

  Widget _failedWidget() {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.warning_outlined, color: Colors.amber, size: 150),
            const SizedBox(height: 20),
            const Text(
              "Payment failed! \n",
              style: TextStyle(
                color: Colors.amber,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "seats : ${widget.listSeats.toString()} \n"
              "number : ${widget.seats.toString()} \n"
              "penayangan : ${widget.penayangan.film!.judul} \n"
              "user data : ${widget.userData['id_user']} \n"
              "nominal : ${widget.nominal_pembayaran} \n"
              "metode : ${widget.metode_pembayaran}\n"
              "list kursi : ${list_kursi!.join(',')}",
              style: TextStyle(
                color: Colors.amber,
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _successWidget() {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle_sharp, color: Colors.amber, size: 150),
            const SizedBox(height: 20),
            const Text(
              "Payment Successful! \n",
              style: TextStyle(
                color: Colors.amber,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "seats : ${widget.listSeats.toString()} \n"
              "number : ${widget.seats.toString()} \n"
              "penayangan : ${widget.penayangan.film!.judul} \n"
              "user data : ${widget.userData['id_user']} \n"
              "nominal : ${widget.nominal_pembayaran} \n"
              "metode : ${widget.metode_pembayaran}",
              style: TextStyle(
                color: Colors.amber,
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _bottomWidget() {
    return Container(
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
                  builder: (context) => FilmListView(
                    userData: widget.userData,
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 15),
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
    );
  }
}
