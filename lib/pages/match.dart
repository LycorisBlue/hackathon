import "package:flutter/material.dart";
import 'package:hive/hive.dart';
import "../models/country.dart";
import "../models/matchs.dart";
import "../widgets/country.dart";
import "../widgets/meet.dart";

class MyTabBar extends StatefulWidget {
  @override
  _MyTabBarState createState() => _MyTabBarState();
}

class _TabControllerProvider extends InheritedWidget {
  final TabController controller;

  const _TabControllerProvider({
    required this.controller,
    required Widget child,
  }) : super(child: child);

  static _TabControllerProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_TabControllerProvider>();
  }

  @override
  bool updateShouldNotify(_TabControllerProvider oldWidget) => false;
}

class _MyTabBarState extends State<MyTabBar>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return _TabControllerProvider(
      controller: controller,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            controller: controller,
            tabs: [
              Tab(
                icon: Icon(Icons.schedule),
                text: "Accueil",
              ),
              Tab(
                icon: Icon(Icons.sports_score),
                text: "Recherche",
              ),
              Tab(icon: Icon(Icons.equalizer), text: "Paramètres")
            ],
          ),
        ),
        body: TabBarView(
          controller: controller,
          children: [
            FirstTab(),
            SecondTab(),
            ThirdTab(),
          ],
        ),
      ),
    );
  }
}

class FirstTab extends StatefulWidget {
  @override
  _FirstTabState createState() => _FirstTabState();
}

class _FirstTabState extends State<FirstTab> {

  // Stockage Hive
  final _box = Hive.box("pass"); 

  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  String? _selectedRole;

  @override
  Widget build(BuildContext context) {  
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
          
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: "Nom d'utilisateur"),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Veuillez entrer un nom';
                }
                return null;
              } 
            ),
            
            DropdownButtonFormField(
              value: _selectedRole,
              items: [
                DropdownMenuItem(child: Text("Admin"), value: "admin"), 
                DropdownMenuItem(child: Text("User"), value: "user"),
                DropdownMenuItem(child: Text("Guest"), value: "guest") 
              ],
              onChanged: (value) {
                setState(() {
                  _selectedRole = value; 
                });
              },
              decoration: InputDecoration(labelText: "Rôle"),
              validator: (value) {
                if (value == null) {
                  return 'Veuillez sélectionner un rôle';
                } 
                return null;  
              },
            ),
            
            ElevatedButton(
              onPressed: _submitForm,
              child: Text("S'enregistrer"), 
            )
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Enregistrement dans Hive
      _box.put("username", _usernameController.text);
      _box.put("role", _selectedRole);
      
      // Redirection vers Tab 2
      TabController controller = _TabControllerProvider.of(context)!.controller;
      controller.animateTo(1);
    } 
  }
  
}

class SecondTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TabController controller =
        _TabControllerProvider.of(context)!.controller;

    return Center(
      child: ElevatedButton(
        onPressed: () {
          controller.animateTo(2);
        },
        child: Text("Go to Tab 3"),
      ),
    );
  }
}

class ThirdTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TabController controller =
        _TabControllerProvider.of(context)!.controller;

    return Center(
      child: ElevatedButton(
        onPressed: () {
          controller.animateTo(0);
        },
        child: Text("Back to Tab 1"),
      ),
    );
  }
}
