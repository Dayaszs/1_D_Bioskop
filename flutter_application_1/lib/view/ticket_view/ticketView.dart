import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/data/ticket.dart';
import 'package:flutter_application_1/client/TicketClient.dart';
import 'package:flutter_application_1/utilities/constant.dart';
import 'package:flutter_application_1/view/ticket_view/ticketPDF.dart';

final listTicketProvider =
    FutureProvider.family<List<Ticket>, int>((ref, userId) async {
  return await TicketClient().fetchOnlyUsers(userId);
});

class TicketView extends ConsumerStatefulWidget {
  const TicketView({super.key, required this.data});

  final Map<String, dynamic> data; // data contains the user ID

  @override
  _TicketViewState createState() => _TicketViewState();
}

class _TicketViewState extends ConsumerState<TicketView> {
  String _filter = 'Available';

  @override
  Widget build(BuildContext context) {
    final userId = widget.data['id_user'];
    final ticketsAsync = ref.watch(listTicketProvider(userId));

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'My Tickets',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildTabBar(),
          Expanded(child: _buildTicketLayout(ticketsAsync)),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _filter = 'Available';
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: _filter == 'Available' ? lightColor : darkColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Available',
                style: TextStyle(
                  color: _filter == 'Available' ? Colors.black : Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              setState(() {
                _filter = 'Not Available';
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: _filter == 'Not Available' ? lightColor : darkColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Not Available',
                style: TextStyle(
                  color:
                      _filter == 'Not Available' ? Colors.black : Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTicketLayout(AsyncValue<List<Ticket>> ticketsAsync) {
  return ticketsAsync.when(
    data: (tickets) {
      // Filter tickets based on the current filter
      final filteredTickets = tickets.where((ticket) {
        final status = ticket.penayangan?.status ?? 'Unknown';
        if (_filter == 'Available') {
          return status == 'Available';
        } else {
          return status == 'Not Available';
        }
      }).toList();

      return ListView.builder(
        itemCount: filteredTickets.length,
        itemBuilder: (context, index) {
          final ticket = filteredTickets[index];
          
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Card(
              color: const Color.fromARGB(255, 22, 22, 22),
              child: InkWell(
                onTap: () {
                  // Navigate to the TicketPdfPage when the ticket is clicked
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TicketPdfPage(ticket: ticket),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 150,
                        child: Image.network(
                          ticket.film!.poster_1 ?? 'default_image_url',
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 10),
                      // Ticket Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Movie Title
                            Text(
                              ticket.film?.judul ?? 'Unknown Movie',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 5),
                            // Other details like date, time, etc.
                            Text(
                              'Status: ${ticket.penayangan?.status ?? 'Unknown'}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    },
    loading: () => const Center(child: CircularProgressIndicator()),
    error: (error, stackTrace) => Center(child: Text('Error: $error')),
  );
}

}
