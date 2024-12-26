import 'dart:convert';
import '../screens/setup_screen.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../screens/floor_selection_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/custom_drawer.dart';
import 'package:http/http.dart' as http;

class RoomsScreen extends StatefulWidget {
  @override
  _RoomsPageState createState() => _RoomsPageState();
}

class _RoomsPageState extends State<RoomsScreen>{
  late final Widget _customDrawer;
  int selectedFloor = 0;
  String url_per_chiamate='';
  String api_key_per_chiamate = '';
  bool isLoading = false;
  List<Map<String, dynamic>> rooms = [];

  @override
  void initState(){
    super .initState();
    _customDrawer = CustomDrawer();//Pre-Carica il Drawer

    loadFloorAndRooms();


  }

  /*Future<void> loadFloorAndRooms() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //Recupera il piano salvato
    selectedFloor = prefs.getInt('selected_floor') ?? 0;

    //Se il piano è 0 non caricare le camere
    if(selectedFloor ==0){
      setState(() {
        //Ridisegna per mostrare la card
      });
      return;
    }
    url_per_chiamate=prefs.getString('indirizzo_api') ?? '';
    api_key_per_chiamate = prefs.getString('api_key') ?? '';

    if (url_per_chiamate.isEmpty || api_key_per_chiamate.isEmpty) {
      return;
    }
    final url = Uri.parse('$url_per_chiamate/PrenotazioneCamere/1');

    try {
      final response = await http.get(
        url,
        headers: {
          'X-Api-Key':api_key_per_chiamate,
        },
      );

      if (response.statusCode == 200) {


      } else {

    } catch (e) {

    } finally {

    }

    //Mock della chiamata Api (filtro per il piano selezionato)
    List<Map<String, dynamic>> mockResponse =
    [
      {
        "idPrenotazione": 111276,
        "data": "2024-12-24T00:00:00",
        "nCamera": 202,
        "nPersone": 0,
        "soggiorno": "A",
        "eseguita": false,
        "dataEseguita": null,
        "piano": 2,
        "dataArrivo": "2024-12-24T00:00:00",
        "dataPartenza": "2024-12-26T00:00:00",
        "nomeCliente": "PETRACHI"
      },
      {
        "idPrenotazione": 111761,
        "data": "2024-12-24T00:00:00",
        "nCamera": 219,
        "nPersone": 0,
        "soggiorno": "S",
        "eseguita": false,
        "dataEseguita": null,
        "piano": 2,
        "dataArrivo": "2024-12-23T00:00:00",
        "dataPartenza": "2024-12-27T00:00:00",
        "nomeCliente": "PIRAZZINI"
      },
      {
        "idPrenotazione": 112426,
        "data": "2024-12-24T00:00:00",
        "nCamera": 205,
        "nPersone": 0,
        "soggiorno": "A",
        "eseguita": false,
        "dataEseguita": null,
        "piano": 2,
        "dataArrivo": "2024-12-24T00:00:00",
        "dataPartenza": "2024-12-26T00:00:00",
        "nomeCliente": "CHERA MARIA"
      },
      {
        "idPrenotazione": 112626,
        "data": "2024-12-24T00:00:00",
        "nCamera": 220,
        "nPersone": 0,
        "soggiorno": "A",
        "eseguita": false,
        "dataEseguita": null,
        "piano": 2,
        "dataArrivo": "2024-12-24T00:00:00",
        "dataPartenza": "2024-12-26T00:00:00",
        "nomeCliente": "CHERA"
      },
      {
        "idPrenotazione": 112917,
        "data": "2024-12-24T00:00:00",
        "nCamera": 221,
        "nPersone": 0,
        "soggiorno": "A",
        "eseguita": false,
        "dataEseguita": null,
        "piano": 2,
        "dataArrivo": "2024-12-24T00:00:00",
        "dataPartenza": "2024-12-26T00:00:00",
        "nomeCliente": "FASSINA"
      },
      {
        "idPrenotazione": 112985,
        "data": "2024-12-24T00:00:00",
        "nCamera": 223,
        "nPersone": 0,
        "soggiorno": "A",
        "eseguita": false,
        "dataEseguita": null,
        "piano": 2,
        "dataArrivo": "2024-12-24T00:00:00",
        "dataPartenza": "2024-12-26T00:00:00",
        "nomeCliente": "FERRARI"
      },
      {
        "idPrenotazione": 112986,
        "data": "2024-12-24T00:00:00",
        "nCamera": 222,
        "nPersone": 0,
        "soggiorno": "S",
        "eseguita": false,
        "dataEseguita": null,
        "piano": 2,
        "dataArrivo": "2024-12-23T00:00:00",
        "dataPartenza": "2024-12-26T00:00:00",
        "nomeCliente": "FERRARI"
      },
      {
        "idPrenotazione": 113031,
        "data": "2024-12-24T00:00:00",
        "nCamera": 215,
        "nPersone": 0,
        "soggiorno": "A",
        "eseguita": false,
        "dataEseguita": null,
        "piano": 2,
        "dataArrivo": "2024-12-24T00:00:00",
        "dataPartenza": "2024-12-26T00:00:00",
        "nomeCliente": "BORTOLIN"
      },
      {
        "idPrenotazione": 113075,
        "data": "2024-12-24T00:00:00",
        "nCamera": 201,
        "nPersone": 0,
        "soggiorno": "P",
        "eseguita": false,
        "dataEseguita": null,
        "piano": 2,
        "dataArrivo": "2024-12-23T00:00:00",
        "dataPartenza": "2024-12-24T00:00:00",
        "nomeCliente": "VAZZOLER"
      },
      {
        "idPrenotazione": 113076,
        "data": "2024-12-24T00:00:00",
        "nCamera": 209,
        "nPersone": 0,
        "soggiorno": "P",
        "eseguita": false,
        "dataEseguita": null,
        "piano": 2,
        "dataArrivo": "2024-12-23T00:00:00",
        "dataPartenza": "2024-12-24T00:00:00",
        "nomeCliente": "VAZZOLER"
      },
      {
        "idPrenotazione": 113150,
        "data": "2024-12-24T00:00:00",
        "nCamera": 204,
        "nPersone": 0,
        "soggiorno": "S",
        "eseguita": false,
        "dataEseguita": null,
        "piano": 2,
        "dataArrivo": "2024-12-22T00:00:00",
        "dataPartenza": "2025-01-12T00:00:00",
        "nomeCliente": "RAMIREZ"
      },
      {
        "idPrenotazione": 113371,
        "data": "2024-12-24T00:00:00",
        "nCamera": 223,
        "nPersone": 0,
        "soggiorno": "P",
        "eseguita": false,
        "dataEseguita": null,
        "piano": 2,
        "dataArrivo": "2024-12-21T00:00:00",
        "dataPartenza": "2024-12-24T00:00:00",
        "nomeCliente": "CERUTTI"
      },
      {
        "idPrenotazione": 113588,
        "data": "2024-12-24T00:00:00",
        "nCamera": 211,
        "nPersone": 0,
        "soggiorno": "P",
        "eseguita": false,
        "dataEseguita": null,
        "piano": 2,
        "dataArrivo": "2024-12-23T00:00:00",
        "dataPartenza": "2024-12-24T00:00:00",
        "nomeCliente": "PAOLETTO"
      },
      {
        "idPrenotazione": 113589,
        "data": "2024-12-24T00:00:00",
        "nCamera": 212,
        "nPersone": 0,
        "soggiorno": "P",
        "eseguita": false,
        "dataEseguita": null,
        "piano": 2,
        "dataArrivo": "2024-12-23T00:00:00",
        "dataPartenza": "2024-12-24T00:00:00",
        "nomeCliente": "PAOLETTO"
      },
      {
        "idPrenotazione": 113590,
        "data": "2024-12-24T00:00:00",
        "nCamera": 214,
        "nPersone": 0,
        "soggiorno": "P",
        "eseguita": false,
        "dataEseguita": null,
        "piano": 2,
        "dataArrivo": "2024-12-23T00:00:00",
        "dataPartenza": "2024-12-24T00:00:00",
        "nomeCliente": "PAOLETTO"
      },
      {
        "idPrenotazione": 114258,
        "data": "2024-12-24T00:00:00",
        "nCamera": 215,
        "nPersone": 0,
        "soggiorno": "P",
        "eseguita": false,
        "dataEseguita": null,
        "piano": 2,
        "dataArrivo": "2024-12-23T00:00:00",
        "dataPartenza": "2024-12-24T00:00:00",
        "nomeCliente": "PASTROVICCHIO"
      },
      {
        "idPrenotazione": 114391,
        "data": "2024-12-24T00:00:00",
        "nCamera": 203,
        "nPersone": 0,
        "soggiorno": "S",
        "eseguita": false,
        "dataEseguita": null,
        "piano": 2,
        "dataArrivo": "2024-12-23T00:00:00",
        "dataPartenza": "2024-12-26T00:00:00",
        "nomeCliente": "PREVITALI"
      }
    ];


    rooms = mockResponse.toList();

    setState(() {
      //Aggiorna la UI
    });



  }*/

  // Funzione per mostrare il dialogo di setup
  void _showSetupDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Errore Connessione'),
          content: Text(
            'L\'Url o la API Key sono mancanti. Per favore, vai alla schermata di setup per configurarle.',
            style: TextStyle(fontSize: 16),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Naviga alla schermata di setup
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => SetupScreen()),
                  );
              },
              child: Text('Vai a Setup', style: TextStyle(color: Colors.blue)),
            ),
          ],
        );
      },
    );
  }

  Future<void> loadFloorAndRooms() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String errorMessage;

    // Recupera il piano salvato
    selectedFloor = prefs.getInt('selected_floor') ?? 0;

    // Se il piano è 0, non caricare le camere
    if (selectedFloor == 0) {
      setState(() {
        // Ridisegna per mostrare la card
      });
      return;
    }

    // Recupera l'indirizzo e la chiave API
    url_per_chiamate = prefs.getString('indirizzo_api') ?? '';
    api_key_per_chiamate = prefs.getString('api_key') ?? '';

    if (url_per_chiamate.isEmpty || api_key_per_chiamate.isEmpty) {
      // Non fare nulla se mancano i dati
      _showSetupDialog(context);
      return;
    }

    final url = Uri.parse('$url_per_chiamate/PrenotazioneCamere/$selectedFloor');

    try {
      // Mostra un indicatore di caricamento
      setState(() {
        isLoading = true;
      });

      final response = await http.get(
        url,
        headers: {
          'X-Api-Key': api_key_per_chiamate,
        },
      );

      if (response.statusCode == 200) {
        // Parsing della risposta API
        final List<dynamic> jsonResponse = json.decode(response.body);

        // Converte la risposta in una lista di Map
        rooms = jsonResponse.map((item) => item as Map<String, dynamic>).toList();

        // Aggiorna lo stato dell'interfaccia
        setState(() {
          // Ridisegna con le camere caricate da API
        });
      } else {
        // Gestisci errori HTTP (ad esempio, 400, 401, 500)
        setState(() {
          errorMessage = 'Errore nel caricamento: ${response.statusCode}';
        });
      }
    } catch (e) {
      // Gestione degli errori di rete o altre eccezioni
      setState(() {
        errorMessage = 'Errore: ${e.toString()}';

      });
    } finally {
      // Nascondi l'indicatore di caricamento
      setState(() {
        isLoading = false;
      });
    }
  }

  String _formatDate(String dateStr) {
    try {
      final DateTime parsedDate = DateTime.parse(dateStr);
      return DateFormat('dd-MM-yyyy').format(parsedDate);
    } catch (e) {
      return dateStr; // Ritorna la stringa originale in caso di errore
    }
  }

  Future<void> updateRoomStatus(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Controlliamo se la camera è già eseguita
    if (rooms[index]['eseguita'] == true) {
      // Se è già eseguita, non facciamo nulla
      return;
    }

    // Impostiamo lo stato della camera a 'eseguita' e aggiorniamo la data
    setState(() {
      rooms[index]['eseguita'] = true;
      rooms[index]['dataEseguita'] = DateTime.now().toIso8601String();
    });

    // Recupera l'indirizzo e la chiave API
    String url_per_chiamate = prefs.getString('indirizzo_api') ?? '';
    String api_key_per_chiamate = prefs.getString('api_key') ?? '';

    if (url_per_chiamate.isEmpty || api_key_per_chiamate.isEmpty) {
      // Non fare nulla se mancano i dati
      return;
    }

    // Costruisci l'URL con il numero della camera (idPrenotazione)
    String idPrenotazione = rooms[index]['idPrenotazione'].toString();
    final url = Uri.parse('$url_per_chiamate/PrenotazioneCamere/$idPrenotazione/eseguita');

    print(idPrenotazione);
    print('$url_per_chiamate/PrenotazioneCamere/$idPrenotazione/eseguita');
    print(api_key_per_chiamate);
    // Corpo della richiesta POST (impostiamo eseguita su true)
    final body = 'true';

    try {
      // Inviamo la richiesta POST
      final response = await http.post(
        url,
        headers: {
          'X-Api-Key': api_key_per_chiamate,
          'Content-Type': 'application/json',
        },
          body: body,
      );

      // Controlliamo la risposta
      if (response.statusCode == 200) {
        // Se la risposta è positiva, possiamo fare qualche azione (ad esempio, aggiornare l'interfaccia utente)
        print("Stato della camera aggiornato con successo.");
      } else {
        // Gestione errore
        print('Errore nella richiesta: ${response.statusCode}');
      }
    } catch (e) {
      // Gestione di errori di rete
      print('Errore di rete: $e');
    }
  }

  // Funzione di utilità per righe informative
  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[700]),
          SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(width: 5),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

/*

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
                Text('Stanze del Piano'),
        actions: [
          Padding(padding: const EdgeInsets.fromLTRB(0, 0, 20, 0) , child:
          ElevatedButton(
            onPressed: isLoading ? null : () async {
              setState(() {
                isLoading = true;
              });
              await loadFloorAndRooms();
              */
/*setState(() {
                isLoading = false;
              });*//*


              // Timer per evitare di premere il pulsante troppo velocemente
              Future.delayed(Duration(seconds: 1), () {
                setState(() {
                  isLoading = false;  // Riabilita il pulsante dopo 2 secondi
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Lista aggiornata!'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                });
              });
            },
            child: isLoading
                ? Row(
              children: [
                Text('Caricamento...', style: TextStyle(color: Colors.black)),
                SizedBox(width: 8),
                Container(
                  height: 20.0, // Imposta l'altezza desiderata
                  width: 20.0,  // Imposta la larghezza desiderata
                  child: CircularProgressIndicator(
                    color: Colors.black,
                    strokeWidth: 2, // Modifica lo spessore della linea
                  ),
                )
              ],
            )
                : Row(
              children: [
                Text('Aggiorna', style: TextStyle(color: Colors.black)),
                Icon(Icons.update_rounded, color: Colors.black),
              ],
            ),
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.black),
                ),
              ),
            ),
          ),
          )
        ],
      ),
      drawer: CustomDrawer(),
      body: selectedFloor == 0
        ? Center(
        child: Card(
          color:  Colors.orange,
          child: InkWell(
            onTap: (){
              Navigator.pushNamed(context, 'floor_selection_screen');
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Seleziona un piano per visualizzare le camere',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ),
      )
          : GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Numero di colonne
          childAspectRatio: 2.5, // Rapporto larghezza/altezza
          crossAxisSpacing: 8.0, // Spaziatura orizzontale
          mainAxisSpacing: 8.0, // Spaziatura verticale
        ),
        itemCount: rooms.length,
        itemBuilder: (context, index) {
          final room = rooms[index];
          return GestureDetector(
            onTap: room['eseguita'] ? null : () => updateRoomStatus(index),
            child: Card(
              color: room['eseguita'] ? Colors.green[100] : Colors.red[100],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Titolo Camera
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Camera ${room['nCamera']}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                        ),



                        if (room['soggiorno'] == 'A' || room['soggiorno'] == 'P')
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                            decoration: BoxDecoration(
                              color: room['soggiorno'] == 'A' ? Colors.blue[300] : Colors.orange[300],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  room['soggiorno'] == 'A' ? Icons.login : Icons.logout,
                                  color: Colors.white,
                                  size: 24,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  room['soggiorno'] == 'A' ? 'Arrivo' : 'Partenza',
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),

                        Icon(
                          room['eseguita'] ? Icons.check_circle : Icons.hourglass_empty,
                          color: room['eseguita'] ? Colors.green : Colors.red,
                          size: 24,
                        ),
                      ],
                    ),
                    SizedBox(height: 2),
                    // Informazioni principali
                    Padding(padding: EdgeInsets.fromLTRB(20, 0, 0,0),
                    child: Column(
                      children: [
                        _buildInfoRow(Icons.person, 'Persone:', room['nPersone'].toString()),
                        _buildInfoRow(Icons.person_outline, 'Nominativo:', room['nomeCliente']),
                        _buildInfoRow(Icons.calendar_today, 'Data Arrivo:', _formatDate(room['dataArrivo'])),
                        _buildInfoRow(Icons.calendar_today_outlined, 'Data Partenza:', _formatDate(room['dataPartenza'])),
                      ],
                    ),
                    ),
                    SizedBox(height: 12),

                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stanze del Piano'),

          //backgroundColor: Colors.blueAccent,
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: ElevatedButton(
              onPressed: isLoading
                  ? null
                  : () async {
                setState(() {
                  isLoading = true;
                });
                await loadFloorAndRooms();

                Future.delayed(Duration(seconds: 1), () {
                  setState(() {
                    isLoading = false; // Riabilita il pulsante dopo 1 secondo
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Lista aggiornata!'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  });
                });
              },
              child: isLoading
                  ? Row(
                children: [
                  Text('Caricamento...', style: TextStyle(color: Colors.black)),
                  SizedBox(width: 8),
                  Container(
                    height: 20.0,
                    width: 20.0,
                    child: CircularProgressIndicator(
                      color: Colors.black,
                      strokeWidth: 2,
                    ),
                  )
                ],
              )
                  : Row(
                children: [
                  Text('Aggiorna', style: TextStyle(color: Colors.black)),
                  Icon(Icons.update_rounded, color: Colors.black),
                ],
              ),
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.black),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      drawer: CustomDrawer(),
      body: selectedFloor == 0
          ? Center(
        child: Card(
          color: Colors.blueAccent,
          child: InkWell(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => FloorSelectionScreen()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Seleziona un piano',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
          ),
        ),
      )
          : LayoutBuilder(
        builder: (context, constraints) {
          // Aggiusta il numero di colonne in base all'orientamento
          int crossAxisCount = constraints.maxWidth > 700 ? 2 : 1; // Più colonne per schermi grandi
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount, // Numero di colonne dinamico
              childAspectRatio: 2.5, // Rapporto larghezza/altezza
              crossAxisSpacing: 8.0, // Spaziatura orizzontale
              mainAxisSpacing: 8.0, // Spaziatura verticale
            ),
            itemCount: rooms.length,
            itemBuilder: (context, index) {
              final room = rooms[index];
              return GestureDetector(
                onTap: room['eseguita'] ? null : () => updateRoomStatus(index),
                child: Card(
                  color: room['eseguita'] ? Colors.green[100] : Colors.red[100],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Titolo Camera
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Camera ${room['nCamera']}',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[800],
                              ),
                            ),
                            if (room['soggiorno'] == 'A' || room['soggiorno'] == 'P')
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                                decoration: BoxDecoration(
                                  color: room['soggiorno'] == 'A' ? Colors.blue[300] : Colors.orange[300],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      room['soggiorno'] == 'A' ? Icons.login : Icons.logout,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      room['soggiorno'] == 'A' ? 'Arrivo' : 'Partenza',
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            Icon(
                              room['eseguita'] ? Icons.check_circle : Icons.hourglass_empty,
                              color: room['eseguita'] ? Colors.green : Colors.red,
                              size: 24,
                            ),
                          ],
                        ),
                        SizedBox(height: 2),
                        // Informazioni principali
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Column(
                            children: [
                              _buildInfoRow(Icons.person, 'Persone:', room['nPersone'].toString()),
                              _buildInfoRow(Icons.person_outline, 'Nominativo:', room['nomeCliente']),
                              _buildInfoRow(Icons.calendar_today, 'Data Arrivo:', _formatDate(room['dataArrivo'])),
                              _buildInfoRow(Icons.calendar_today_outlined, 'Data Partenza:', _formatDate(room['dataPartenza'])),
                            ],
                          ),
                        ),
                        SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}



