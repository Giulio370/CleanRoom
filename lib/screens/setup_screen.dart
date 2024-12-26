import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../widgets/custom_drawer.dart';
import '../screens/rooms_screen.dart';

class SetupScreen extends StatefulWidget {
  @override
  _SetupScreenState createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  // Controllers per i TextField
  final TextEditingController _apiController = TextEditingController();
  final TextEditingController _keyController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Variabili di stato
  String _errorMessage = '';
  bool _isLoading = false;
  bool _isAuthenticated = false;
  String _apiKey = '';
  String _apiUrl = '';
  final String _setupPassword = "admin123"; // Password interna

  @override
  void initState() {
    super.initState();
    _loadSavedValues();
  }

  Future<void> _loadSavedValues() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _apiUrl = prefs.getString('indirizzo_api') ?? '';
      _apiKey = prefs.getString('api_key') ?? '';
      _apiController.text = _apiUrl;
      _keyController.text = _apiKey;
    });
  }

  Future<void> _saveInput() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('indirizzo_api', _apiUrl);
    await prefs.setString('api_key', _apiKey);
  }

  Future<void> _testApiCall() async {
    setState(() {
      _apiUrl = _apiController.text.trim();
      _apiKey = _keyController.text.trim();
    });

    if (_apiUrl.isEmpty || _apiKey.isEmpty) {
      setState(() {
        _errorMessage = "Indirizzo API e API Key sono obbligatori.";
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final url = Uri.parse('$_apiUrl/PrenotazioneCamere/1');
      final response = await http.get(
        url,
        headers: {
          'X-Api-Key': _apiKey,
        },
      );

      if (response.statusCode == 200) {
        await _saveInput();
        _showSuccessDialog();
      } else {
        setState(() {
          _errorMessage =
          'Errore nella richiesta: ${response.statusCode}\nMessaggio: ${response.body}';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Errore di rete: ${e.toString()}';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Successo'),
          content: Text('Credenziali memorizzate con successo!'),
          actions: [
            TextButton(
              onPressed: () =>
              {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => RoomsScreen()),
                )
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _authenticate() {
    if (_passwordController.text == _setupPassword) {
      setState(() {
        _isAuthenticated = true;
        _errorMessage='';
      });
    } else {
      setState(() {
        _errorMessage = "Password errata. Riprova.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setup'),
      ),
      drawer: CustomDrawer(),
      body: _isAuthenticated ? _buildSetupForm() : _buildPasswordScreen(),
    );
  }

  Widget _buildPasswordScreen() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.lock_outline,
              size: 60,
              color: Colors.blueAccent,
            ),
            SizedBox(height: 20),
            Text(
              'Accesso Riservato',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              'Inserisci la password per accedere al setup',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            Container(
              width: 500,
              child:TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.password, color: Colors.grey),
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                  ),
                ),
              ),
            ),

            SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: _authenticate,
              icon: Icon(Icons.login, color: Colors.white),
              label: Text('Accedi', style: TextStyle(fontSize: 16, color: Colors.white)),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 5,
              ),
            ),
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  _errorMessage,
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSetupForm() {
    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Align(
            alignment: Alignment.center,
            child: Container(
              width: 500,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Icon(Icons.settings, color: Colors.blueAccent, size: 28),
                      SizedBox(width: 10),
                      Text(
                        'Impostazioni API',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Indirizzo API',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: _apiController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.link, color: Colors.grey),
                      labelText: 'Inserisci l\'indirizzo API',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'API Key',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: _keyController,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.key, color: Colors.grey),
                      labelText: 'Inserisci la API Key',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: _testApiCall,
                      icon: Icon(Icons.save, color: Colors.white),
                      label: Text(
                        'Testa API e Salva',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 5,
                      ),
                    ),
                  ),
                  if (_errorMessage.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Center(
                        child: Text(
                          _errorMessage,
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        if (_isLoading)
          Container(
            color: Colors.black.withOpacity(0.5),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }


}
