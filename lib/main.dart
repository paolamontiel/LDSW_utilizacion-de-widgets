import 'package:flutter/material.dart';
import 'services/pokemon_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catálogo de Pokémon',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 34, 255, 218),
        ),
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final PokemonService _pokemonService = PokemonService();
  Map<String, dynamic>? _pokemonData;
  bool _isLoading = false;
  TextEditingController _controller = TextEditingController();

  void _fetchPokemon(String pokemonName) async {
    setState(() {
      _isLoading = true;
      _pokemonData = null;
    });

    try {
      final data =
          await _pokemonService.fetchPokemon(pokemonName.toLowerCase());
      setState(() {
        _pokemonData = data;
      });
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se pudo cargar el Pokémon')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background-app.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(height: 60),
              Text(
                'Catálogo de Pokémon',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black54,
                      offset: Offset(2.0, 2.0),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              Text(
                'Busca a tu Pokémon favorito',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Center(
                child: Container(
                  width: screenWidth * 0.6,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8.0,
                        offset: Offset(2, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          style: TextStyle(color: Colors.black87),
                          decoration: InputDecoration(
                            hintText: 'Escribe el nombre del Pokémon',
                            hintStyle: TextStyle(color: Colors.black54),
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                  color:
                                      const Color.fromARGB(255, 43, 194, 43)),
                            ),
                          ),
                          onSubmitted: (value) {
                            if (value.trim().isNotEmpty) {
                              _fetchPokemon(value.trim());
                            }
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF95CDA8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.all(19),
                        ),
                        onPressed: () {
                          String name = _controller.text.trim();
                          if (name.isNotEmpty) {
                            _fetchPokemon(name);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Por favor ingresa un nombre'),
                              ),
                            );
                          }
                        },
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: _isLoading
                      ? CircularProgressIndicator(
                          color: const Color.fromARGB(255, 74, 236, 136),
                        )
                      : _pokemonData != null
                          ? SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: 10),
                                  Text(
                                    _pokemonData!['name']
                                        .toString()
                                        .toUpperCase(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      shadows: [
                                        Shadow(
                                          blurRadius: 10.0,
                                          color: Colors.black54,
                                          offset: Offset(2.0, 2.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Número: ${_pokemonData!['id']}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white70,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      _pokemonData!['sprites']['front_default'],
                                      height: 150,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    'Tipo:',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Wrap(
                                    spacing: 10,
                                    children: (_pokemonData!['types'] as List)
                                        .map((typeInfo) => Chip(
                                              label: Text(
                                                typeInfo['type']['name'],
                                              ),
                                              backgroundColor: Colors.white,
                                              labelStyle: TextStyle(
                                                  color: Colors.black),
                                            ))
                                        .toList(),
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    'Habilidades:',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Wrap(
                                    spacing: 10,
                                    children:
                                        (_pokemonData!['abilities'] as List)
                                            .map((abilityInfo) => Chip(
                                                  label: Text(
                                                    abilityInfo['ability']
                                                        ['name'],
                                                  ),
                                                  backgroundColor: Colors.white,
                                                  labelStyle: TextStyle(
                                                      color: Colors.black),
                                                ))
                                            .toList(),
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    'Peso: ${_pokemonData!['weight'] / 10} kg',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Estatura: ${_pokemonData!['height'] * 10} cm',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Text(
                              'Ingresa un nombre de Pokémon para buscar',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
