import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Info {
  String restaurant;
  String review;
  String friend;

  Info(this.restaurant, this.review, this.friend);
}

class Formulario extends StatefulWidget {
  final Function(Info) adicionarInformacoes;
//  final Function() getInformacoesSalvas;

  const Formulario({
    Key? key,
    required this.adicionarInformacoes,
//    required this.getInformacoesSalvas,
  }) : super(key: key);

  @override
  _FormularioState createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  final _formKey = GlobalKey<FormState>();
  final restaurantController = TextEditingController();
  final reviewController = TextEditingController();
  final friendController = TextEditingController();


  @override
  void initState() {
    super.initState();
  }

  void _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('Restaurant', restaurantController.text);
    await prefs.setString('Review', reviewController.text);
    await prefs.setString('Friend', friendController.text);
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final restaurant = restaurantController.text;
      final review = reviewController.text;
      final friend = friendController.text;

      final novaInfo = Info(restaurant, review, friend);
      widget.adicionarInformacoes(novaInfo);
      _saveData();
      Navigator.pop(context, novaInfo);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add your review'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: restaurantController,
                decoration: const InputDecoration(
                  labelText: 'Restaurant',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please add a Restaurant';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: reviewController,
                decoration: const InputDecoration(
                  labelText: 'Review [a number from 1 to 10]',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please add a Review';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: friendController,
                decoration: const InputDecoration(
                  labelText: 'Friend who suggested',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please add the friend who made the recommendation';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Add'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
