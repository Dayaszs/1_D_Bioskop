import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/fnb.dart';
import 'package:flutter_application_1/utilities/constant.dart';
import 'package:flutter_application_1/client/MenuClient.dart'; 

class ListFnbView extends StatefulWidget {
  @override
  _ListFnbViewState createState() => _ListFnbViewState();
}

class _ListFnbViewState extends State<ListFnbView> {
  late Future<List<Fnb>> _fnbs;

  @override
  void initState() {
    super.initState();
    _fnbs = Menuclient().fetchMenus(); // Mengambil data dari API
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          'Food And Beverage',
          style: TextStyle(
            color: whiteColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 0),
                child: Icon(Icons.arrow_back_ios, color: lightColor),
              ),
              Text(
                'Back',
                style: TextStyle(color: lightColor),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        color: Colors.black,
        padding: EdgeInsets.all(8.0),
        child: FutureBuilder<List<Fnb>>(
          future: _fnbs, // Menggunakan future yang sudah dipersiapkan
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Failed to load menus', style: TextStyle(color: Colors.white)));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No menus available', style: TextStyle(color: Colors.white)));
            } else {
              List<Fnb> fnbs = snapshot.data!;

              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Display 2 columns
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.7,
                ),
                itemCount: fnbs.length,
                itemBuilder: (context, index) {
                  final fnb = fnbs[index];
                  return Card(
                    color: Colors.grey[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(10)),
                            child: Image.network(
                              fnb.gambar!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes != null
                                        ? loadingProgress.cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                    color: Colors.amber,
                                  ),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return Center(
                                  child: Icon(
                                    Icons.broken_image,
                                    color: Colors.white,
                                    size: 48,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                fnb.nama!,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4),
                              Text(
                                fnb.deskripsi!,
                                style: TextStyle(color: Colors.white70, fontSize: 12),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 4),
                              Text(
                                fnb.harga!.toString(),
                                style: TextStyle(
                                  color: Colors.amber,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
