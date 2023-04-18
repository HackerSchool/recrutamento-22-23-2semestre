import 'package:flutter/material.dart';
import 'reviewres.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RestaurantsPage extends StatefulWidget {
  const RestaurantsPage({Key? key}) : super(key: key);

  @override
  _RestaurantsPageState createState() => _RestaurantsPageState();
}

class _RestaurantsPageState extends State<RestaurantsPage> {
  List<Info> _informacoes = [];

  @override
  void initState() {
    super.initState();
    _loadInformacoes();
  }

  void _loadInformacoes() async {
    final prefs = await SharedPreferences.getInstance();
    final count = prefs.getInt('count') ?? 0;
    final informacoes = List.generate(
      count,
      (index) => Info(
        prefs.getString('Restaurant$index') ?? '',
        prefs.getString('Review$index') ?? '',
        prefs.getString('Friend$index') ?? '',
      ),
    );
    setState(() => _informacoes = informacoes);
  }

  void _saveInformacoes() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('count', _informacoes.length);
    for (int i = 0; i < _informacoes.length; i++) {
      final info = _informacoes[i];
      await prefs.setString('Restaurant$i', info.restaurant);
      await prefs.setString('Review$i', info.review);
      await prefs.setString('Friend$i', info.review);
    }
  }

  void _adicionarInformacao(Info novaInfo) {
    setState(() {
      _informacoes.add(novaInfo);
    });
    _saveInformacoes();
  }

  void _removerInfo(int index) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _informacoes.removeAt(index);
    });
    await prefs.setInt('count', _informacoes.length);
    for (int i = index; i < _informacoes.length; i++) {
      await prefs.setString('Restaurant$i', _informacoes[i].restaurant);
      await prefs.setString('Review$i', _informacoes[i].review);
      await prefs.setString('Friend$i', _informacoes[i].friend);
    }
    await prefs.remove('Restaurant${_informacoes.length}');
    await prefs.remove('Review${_informacoes.length}');
    await prefs.remove('Friend${_informacoes.length}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurants Reviews'),
      ),
      body: _informacoes.isEmpty
          ? const Center(
              child: Text('Add Restaurant Reviews'),
            )
          : ListView.builder(
              itemCount: _informacoes.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Restaurant: ${_informacoes[index].restaurant}"),
                      Text("Review: ${_informacoes[index].review}"),
                      Text("Friend: ${_informacoes[index].friend}"),
                      ElevatedButton(
                        onPressed: () {
                          _removerInfo(index);
                        },
                        child: const Text('Remove'),
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Formulario(adicionarInformacoes: _adicionarInformacao)),
          );
        },
        label: const Text('Add a Restaurant'),
        icon: const Icon(Icons.add_box),
        backgroundColor: Colors.pink,
      ),
    );
  }
} 
