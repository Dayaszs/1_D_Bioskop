import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_application_1/data/ticket.dart';
import 'package:flutter_application_1/view/ticket_view/ticketPDF.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/client/TicketClient.dart';

final listTicketProvider = FutureProvider.family<List<Ticket>, int>((ref, userId) async {
  return await TicketClient().fetchOnlyUsers(userId);
});

class TicketView extends ConsumerStatefulWidget {
  const TicketView({super.key, required this.data});

  final Map<String, dynamic> data; // data contains the user ID

  @override
  _TicketViewState createState() => _TicketViewState();
}

class _TicketViewState extends ConsumerState<TicketView> {

  dynamic _filter = 'Completed';

  @override
  Widget build(BuildContext context) {
    // Fetch tickets using the userID from widget.data['id']
    final userId = widget.data['id_user'];

    // Watch the future provider with the userId argument
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
          _buildFilterSection(),
          Expanded(child: _buildTicketLayout(ticketsAsync)),
        ],
      ),
    );
  }

  // Builds the filter buttons for 'Completed' and 'Not Watched'
  Widget _buildFilterSection() {
    return Container(
      color: const Color.fromARGB(255, 22, 22, 22),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Add your filter buttons here
          // Example:
          ElevatedButton(
            onPressed: () {
              setState(() {
                _filter = 'Completed';
              });
            },
            child: const Text('Completed'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _filter = 'Not Watched';
              });
            },
            child: const Text('Not Watched'),
          ),
        ],
      ),
    );
  }

  // Display the tickets in the layout
  Widget _buildTicketLayout(AsyncValue<List<Ticket>> ticketsAsync) {
    return ticketsAsync.when(
      data: (tickets) {
        return ListView.builder(
          itemCount: tickets.length,
          itemBuilder: (context, index) {
            final ticket = tickets[index];
            return ListTile(
              title: Text(ticket.nomorKursi!),
              subtitle: Text('Film: ${ticket.film!.judul}!'),
              // Add more ticket details here
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text('Error: $error')),
    );
  }
}
