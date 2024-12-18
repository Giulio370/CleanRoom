import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/custom_drawer.dart';

class RoomsScreen extends StatefulWidget {
  @override
  _RoomsPageState createState() => _RoomsPageState();
}

class _RoomsPageState extends State<RoomsScreen>{
  late final Widget _customDrawer;
  int selectedFloor = 0;
  bool isLoading = false;
  List<Map<String, dynamic>> rooms = [];

  @override
  void initState(){
    super .initState();
    _customDrawer = CustomDrawer();//Pre-Carica il Drawer
    loadFloorAndRooms();
  }

  Future<void> loadFloorAndRooms() async{
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

    //Mock della chiamata Api (filtro per il piano selezionato)
    List<Map<String, dynamic>> mockResponse = [
      {
        "idPrenotazione": 109201,
        "data": "2024-12-17T00:00:00",
        "nCamera": 408,
        "nPersone": 0,
        "soggiorno": "P",
        "eseguita": false,
        "dataEseguita": null,
        "piano": 4
      },
      {
        "idPrenotazione": 109899,
        "data": "2024-12-17T00:00:00",
        "nCamera": 419,
        "nPersone": 0,
        "soggiorno": "S",
        "eseguita": true,
        "dataEseguita": "2024-12-09T15:33:00",
        "piano": 4
      },
      {
        "idPrenotazione": 109900,
        "data": "2024-12-17T00:00:00",
        "nCamera": 420,
        "nPersone": 0,
        "soggiorno": "S",
        "eseguita": false,
        "dataEseguita": null,
        "piano": 4
      },
      {
        "idPrenotazione": 109901,
        "data": "2024-12-17T00:00:00",
        "nCamera": 421,
        "nPersone": 0,
        "soggiorno": "S",
        "eseguita": false,
        "dataEseguita": null,
        "piano": 4
      },
      {
        "idPrenotazione": 109902,
        "data": "2024-12-17T00:00:00",
        "nCamera": 422,
        "nPersone": 0,
        "soggiorno": "S",
        "eseguita": false,
        "dataEseguita": null,
        "piano": 4
      },
      {
        "idPrenotazione": 109903,
        "data": "2024-12-17T00:00:00",
        "nCamera": 425,
        "nPersone": 0,
        "soggiorno": "S",
        "eseguita": false,
        "dataEseguita": null,
        "piano": 4
      },
      {
        "idPrenotazione": 109904,
        "data": "2024-12-17T00:00:00",
        "nCamera": 426,
        "nPersone": 0,
        "soggiorno": "S",
        "eseguita": false,
        "dataEseguita": null,
        "piano": 4
      },
      {
        "idPrenotazione": 110001,
        "data": "2024-12-18T00:00:00",
        "nCamera": 301,
        "nPersone": 2,
        "soggiorno": "A",
        "eseguita": false,
        "dataEseguita": null,
        "piano": 3
      },
      {
        "idPrenotazione": 110002,
        "data": "2024-12-18T00:00:00",
        "nCamera": 302,
        "nPersone": 1,
        "soggiorno": "A",
        "eseguita": true,
        "dataEseguita": "2024-12-15T10:00:00",
        "piano": 3
      },
      {
        "idPrenotazione": 110003,
        "data": "2024-12-19T00:00:00",
        "nCamera": 303,
        "nPersone": 3,
        "soggiorno": "S",
        "eseguita": false,
        "dataEseguita": null,
        "piano": 3
      },
      {
        "idPrenotazione": 110004,
        "data": "2024-12-20T00:00:00",
        "nCamera": 304,
        "nPersone": 2,
        "soggiorno": "S",
        "eseguita": true,
        "dataEseguita": "2024-12-18T14:00:00",
        "piano": 3
      },
      {
        "idPrenotazione": 110005,
        "data": "2024-12-21T00:00:00",
        "nCamera": 305,
        "nPersone": 4,
        "soggiorno": "A",
        "eseguita": false,
        "dataEseguita": null,
        "piano": 3
      },
      {
        "idPrenotazione": 110006,
        "data": "2024-12-21T00:00:00",
        "nCamera": 306,
        "nPersone": 1,
        "soggiorno": "S",
        "eseguita": true,
        "dataEseguita": "2024-12-19T09:00:00",
        "piano": 3
      },
      {
        "idPrenotazione": 110007,
        "data": "2024-12-22T00:00:00",
        "nCamera": 307,
        "nPersone": 2,
        "soggiorno": "P",
        "eseguita": false,
        "dataEseguita": null,
        "piano": 3
      },
      {
        "idPrenotazione": 110008,
        "data": "2024-12-23T00:00:00",
        "nCamera": 308,
        "nPersone": 3,
        "soggiorno": "S",
        "eseguita": false,
        "dataEseguita": null,
        "piano": 3
      },
      {
        "idPrenotazione": 110009,
        "data": "2024-12-24T00:00:00",
        "nCamera": 309,
        "nPersone": 2,
        "soggiorno": "A",
        "eseguita": true,
        "dataEseguita": "2024-12-23T13:00:00",
        "piano": 3
      },
      {
        "idPrenotazione": 110010,
        "data": "2024-12-25T00:00:00",
        "nCamera": 310,
        "nPersone": 1,
        "soggiorno": "S",
        "eseguita": false,
        "dataEseguita": null,
        "piano": 3
      }
    ];


    rooms = mockResponse.toList();

    setState(() {
      //Aggiorna la UI
    });



  }

  Future<void> updateRoomStatus(int index) async{
    setState(() {
      //Aggiorna lo stato della camera
      rooms[index]['eseguita']=true;
      rooms[index]['dataEseguita'] = DateTime.now().toIso8601String();
    });

    //Salva lo stato aggiornato
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('rooms', rooms.toString()); //Presistenza simulata
  }


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
              /*setState(() {
                isLoading = false;
              });*/

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
              color: room['eseguita'] ? Colors.green[200] : Colors.red[300],
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 0, 10, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Camera ${room['nCamera']}',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Padding(padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                      child:Text(
                        'Persone: ${room['nPersone']}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (room['soggiorno'] == 'A') // Rettangolo per Arrivo
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.blue[300],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.login, color: Colors.white, size: 30),
                                SizedBox(width: 6),
                                Text('Arrivo', style: TextStyle(color: Colors.white)),
                              ],
                            ),
                          ),
                        if (room['soggiorno'] == 'P') // Rettangolo per Partenza
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.orange[300],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.logout, color: Colors.white, size: 30),
                                SizedBox(width: 6),
                                Text('Partenza', style: TextStyle(color: Colors.white)),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }


}



