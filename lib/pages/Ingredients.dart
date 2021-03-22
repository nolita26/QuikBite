import 'dart:convert';
import 'package:crescendo_hack/Maps.dart';
import 'package:crescendo_hack/essentials/recipies.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:crescendo_hack/essentials/themecolor.dart';

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
  Future<ingredient> ingred;

  Future<ingredient> getData() async {
    http.Response response = await http.get('C:\Users\nolit\Documents\Node-express-backend\allIngredients.json');
    if (response.statusCode == 200) {
      return ingredient.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

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
    ingred = getData();
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
                    var id = 19;
                    if (names.length > id - 1) {
                      return "Found item";
                    } else {
                      // Maps();
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
              SizedBox(height: 30),
              RaisedButton(
                color: Colors.black,
                child: Text("Search by ingredrients", style: TextStyle(color: Colors.white),),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                        elevation: 16,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(14, 10, 14, 20),
                          height: 250.0,
                          width: 380.0,
                          child: ListView(
                            children: <Widget>[
                              SizedBox(height: 20),
                              Center(
                                child: Text(
                                  "                   NOTE:\nSome of the ingredients are missing. You can find it in your nearby grocery store given below.",
                                  style: TextStyle(fontSize: 24, color: kThemeColor, fontWeight: FontWeight.bold),
                                ),
                              ),
                              RaisedButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => PlacesSearchMapSample()),
                                  );
                                },
                                child: Text(
                                  "Click here",
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              SizedBox(height: 80),
              Center(child: Text("Select by Calories", style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),)),
              SizedBox(height: 30),
              Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 30),
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: "        Minimum Calories",
                        hintStyle:
                        TextStyle(color: Colors.grey, fontSize: 15.0)),
                    keyboardType: TextInputType.text,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: "      Maximum Calories",
                        hintStyle:
                        TextStyle(color: Colors.grey, fontSize: 15.0)),
                    keyboardType: TextInputType.text,
                  ),
                ),
              ),
            ],
          ),
              SizedBox(height: 30,),
              RaisedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Recipies()),
                  );
                },
                child: Text(
                  "Search",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.black,
              ),
        ])),
      ),
    );
  }
}

class ingredient{
  final int recipe_ids;
  final String name;

  ingredient({this.recipe_ids, this.name});

  factory ingredient.fromJson(Map<String, dynamic> json) {
    return ingredient(
        recipe_ids: json['recipe_ids'],
        name: json['name'],
    );
  }
}
