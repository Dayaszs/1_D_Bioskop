import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_application_1/data/ticket.dart'; // Import the ticket.dart file
import 'package:flutter_application_1/view/ticket_view/ticketPDF.dart'; // Import the new TicketPdfPage

class TicketView extends StatefulWidget {
  const TicketView({super.key});

  @override
  _TicketViewState createState() => _TicketViewState();
}

class _TicketViewState extends State<TicketView> {
  String _filter = 'Completed';

  List<Ticket> get _filteredTickets {
    return _filter == 'Completed'
        ? tickets.where((ticket) => ticket.status == 'Completed').toList()
        : tickets.where((ticket) => ticket.status == 'Not Watched').toList();
  }

  @override
  Widget build(BuildContext context) {
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
          Expanded(child: _buildTicketLayout()),
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
          _buildFilterButton("Completed"),
          const SizedBox(width: 6),
          _buildFilterButton("Not Watched"),
        ],
      ),
    );
  }

  // Custom filter button
  Widget _buildFilterButton(String label) {
    bool isSelected = _filter == label;
    return MouseRegion(
      onEnter: (_) => setState(() => isSelected = true),
      onExit: (_) => setState(() => isSelected = false),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFFCC434)
              : Colors.black.withOpacity(0.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextButton(
          onPressed: () => setState(() => _filter = label),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
            backgroundColor: isSelected
                ? const Color(0xFFFCC434)
                : Colors.black.withOpacity(0.5),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.black : Colors.white.withOpacity(0.5),
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  // Builds the list of filtered tickets based on status
  Widget _buildTicketLayout() {
    return ListView.builder(
      itemCount: _filteredTickets.length,
      itemBuilder: (context, index) {
        final ticket = _filteredTickets[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: GestureDetector(
            onTap: () {
              if (ticket.status == 'Not Watched') {
                // Navigate to the PDF page for "Not Watched" ticket
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TicketPdfPage(ticket: ticket),
                  ),
                );
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Movie Poster
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        '${ticket.picture}',
                        width: 100,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Movie Details
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            '${ticket.judul}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.yellow,
                            ),
                            maxLines: 1,
                            minFontSize: 12,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.category,
                                color: Colors.white,
                                size: 12,
                              ),
                              const SizedBox(width: 4),
                              Flexible(
                                child: AutoSizeText(
                                  '${ticket.genre}',
                                  style: const TextStyle(color: Colors.white),
                                  maxLines: 1,
                                  minFontSize: 12,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.white,
                                size: 12,
                              ),
                              const SizedBox(width: 4),
                              Flexible(
                                child: AutoSizeText(
                                  'ATMA Cinema Pakuwon Jogja',
                                  style: const TextStyle(color: Colors.white),
                                  maxLines: 1,
                                  minFontSize: 12,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: const [
                              Icon(
                                Icons.calendar_today,
                                color: Colors.white,
                                size: 12,
                              ),
                              SizedBox(width: 4),
                              AutoSizeText(
                                '14 October 2024, 13:00 WIB',
                                style: TextStyle(color: Colors.white),
                                maxLines: 2,
                                minFontSize: 12,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // Status Button
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 8,
                            ),
                            decoration: BoxDecoration(
                              color: ticket.status == 'Completed'
                                  ? Colors.green
                                  : Colors.grey,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: AutoSizeText(
                              '${ticket.status}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              minFontSize: 12,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}