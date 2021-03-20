import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class Animal {
  final int id;
  final String name;

  Animal({
    this.id,
    this.name,
  });
}

class Ingredients extends StatefulWidget {
  Ingredients({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _IngredientsState createState() => _IngredientsState();
}

class _IngredientsState extends State<Ingredients> {
  static List<Animal> _animals = [
    Animal(id: 1, name: "chilli powder"),
    Animal(id: 2, name: "coriander"),
    Animal(id: 3, name: "chicken"),
    Animal(id: 4, name: "eggs"),
    Animal(id: 5, name: "sugar"),
    Animal(id: 6, name: "milk"),
    Animal(id: 7, name: "rice"),
    Animal(id: 8, name: "pasta"),
    Animal(id: 9, name: "bread"),
    Animal(id: 10, name: "soya sauce"),
    Animal(id: 11, name: "shezwan sauce"),
    Animal(id: 12, name: "Fish"),
    Animal(id: 13, name: "honey"),
    Animal(id: 14, name: "lemon"),
    Animal(id: 15, name: "onion"),
    Animal(id: 16, name: "tomato"),
    Animal(id: 17, name: "lady finger"),
    Animal(id: 18, name: "cucumber"),
    Animal(id: 19, name: "mixed flour"),
  ];
  final _items = _animals
      .map((animal) => MultiSelectItem<Animal>(animal, animal.name))
      .toList();
  List<Animal> _selectedAnimals2 = [];
  List<Animal> _selectedAnimals3 = [];
  List<Animal> _selectedAnimals5 = [];
  final _multiSelectKey = GlobalKey<FormFieldState>();

  @override
  void initState() {
    _selectedAnimals5 = _animals;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Ingredients"),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(40),
          child: Column(
            children: <Widget>[
              SizedBox(height: 40),
              MultiSelectBottomSheetField<Animal>(
                key: _multiSelectKey,
                initialChildSize: 0.7,
                maxChildSize: 0.95,
                title: Text("Ingredients"),
                buttonText: Text("Type your ingredients"),
                items: _items,
                searchable: true,
                validator: (values) {
                  if (values == null || values.isEmpty) {
                    return "Required";
                  }
                  List<String> names = values.map((e) => e.name).toList();
                  if (names.contains("salt")) {
                    return "Salt! yayyy!";
                  }
                  return null;
                },
                onConfirm: (values) {
                  setState(() {
                    _selectedAnimals3 = values;
                  });
                  _multiSelectKey.currentState.validate();
                },
                chipDisplay: MultiSelectChipDisplay(
                  onTap: (item) {
                    setState(() {
                      _selectedAnimals3.remove(item);
                    });
                    _multiSelectKey.currentState.validate();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
