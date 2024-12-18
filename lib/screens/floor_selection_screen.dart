import 'package:flutter/material.dart';
import '../widgets/custom_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FloorSelectionScreen extends StatefulWidget {
  @override
  _FloorSelectionPageState createState() => _FloorSelectionPageState();
}
class _FloorSelectionPageState extends State<FloorSelectionScreen> {
  //Variabile per memorizzare il piano selezionato
  int _selectedFloor = 0; // 0 = nessun piano selezionato

  //Metodo per aggionrare il piano selezionato
  void _selectFloor(int floor) {
    setState(() {
      _selectedFloor = floor;//Salva il valore del piano selezionato (nella memoria temporanea)
      print(floor);
    });
    _saveSelectedFloor(floor); // Salva il valore nelle SharedPreferences
  }

  @override
  void initState(){
    super.initState();
    _loadSelectedFloor();//Carica il piano salvato
  }

  //Metodo per caricare il piano selezionato dalle SharedPreferences
  Future<void> _loadSelectedFloor() async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedFloor = prefs.getInt('selected_floor') ?? 0; //0 come valore predefinito
    });
  }

  //Metodo per salvare il piano selezionato
  Future<void> _saveSelectedFloor(int floor) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('selected_floor', floor);//Salva il valore
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selezione Piano'),
      ),
      drawer: CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            //4 Card, ognuna rappresenta un piano
            for(int i =1; i<=4; i++) ...[
              GestureDetector(
                onTap: () => _selectFloor(i), //Aggiorna il piano selezionato
                child: Card(
                  color: _selectedFloor == i ? Colors.blue : Colors.grey[300], //Colore Condizionale
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16,35,16,35),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Piano $i",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: _selectedFloor == i ? Colors.white : Colors.black,
                        ),
                        ),
                        if(_selectedFloor == i)//Mostra un'icona solo se selezionato
                          Icon(
                            Icons.check_circle,
                            color: Colors.white,
                          )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
            ]
          ],
        ),
      )
    );
  }


}


