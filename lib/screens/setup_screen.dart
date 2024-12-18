
import 'package:flutter/material.dart';
import '../widgets/custom_drawer.dart';

class SetupScreen extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}
class _InputPageState extends State<SetupScreen> {
  // Creiamo due controller per i TextField
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();

  // Variabili per memorizzare le stringhe inserite
  String _api_key = '';
  String _indirizzo_api = '';

  void _saveInput() {
    setState(() {
      _indirizzo_api = _controller1.text;
      _api_key = _controller2.text;
    });

    // Stampa in console per verifica
    print('Prima stringa: $_indirizzo_api');
    print('Seconda stringa: $_api_key');
  }

  @override
  void dispose() {
    // Puliamo i controller quando il widget viene distrutto
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Setup'),
      ),
      drawer: FutureBuilder(
        future: Future.delayed(Duration.zero), // Precarica il drawer immediatamente
        builder: (context, snapshot) {
          return CustomDrawer(); // Mostra il tuo Drawer
        },
      ),
      body:
          SingleChildScrollView(
            reverse: true,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: 100),
                Container(width: 500,child:Text("Indirizzo Api")),
                SizedBox(height: 10),
                Center(
                  child: SizedBox(
                    width: 500,
                    child: TextField(
                      controller: _controller1,
                      onChanged: (value){
                        setState(() {
                          _indirizzo_api = value; //Salva il testo dell'indirizzo inserito
                        });
                      },
                      onSubmitted: (String value) async {
                        await showDialog<void>(
                            context: context,
                            builder: (BuildContext context){
                              return AlertDialog(
                                  title: const Text('Testo nella TextBox'),
                                  content: Text('Indirizzo di collegamento: "$value" '),
                                  actions: <Widget>[
                                    TextButton(onPressed: () {Navigator.pop(context);}, child: const Text("OK"))
                                  ]
                              );
                            }
                        );
                      },
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Indirizzo',
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(width: 500,child:Text("Inserire Api Key")),
                SizedBox(height: 10),
                Center(
                  child: SizedBox(
                    width: 500,
                    child: TextField(
                      controller: _controller2,
                      onChanged: (value){
                        setState(() {
                          _api_key = value;
                        });
                      },
                      onSubmitted: (String value) async {
                        await showDialog<void>(
                            context: context,
                            builder: (BuildContext context){
                              return AlertDialog(
                                  title: const Text('Testo nella TextBox'),
                                  content: Text('ApiKey: "$value" '),
                                  actions: <Widget>[
                                    TextButton(onPressed: () {Navigator.pop(context);}, child: const Text("OK"))
                                  ]
                              );
                            }
                        );
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'ApiKey',
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: 500,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      child: ElevatedButton( onPressed: _saveInput, child: Text("Memorizza", style: TextStyle(color: Colors.black),),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(color: Colors.black)
                                )
                            )
                        )
                      )
                  ),
                )
                )
              ],
            ),
          )
    );
  }
}
