import "package:flutter/material.dart";
import "package:hackathon/pages/card.dart";
import "package:hackathon/pages/form.dart";
import 'package:hive/hive.dart';
import "../models/country.dart";
// import "../models/matchs.dart";
import "../widgets/country.dart";
import "../widgets/meet.dart";
import "../utils/passeport.dart";


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
                text: "Etape 1",
              ),
              Tab(
                icon: Icon(Icons.sports_score),
                text: "Etape 2",
              ),
              Tab(icon: Icon(Icons.equalizer), text: "Etape 3")
            ],
          ),
        ),
        body: TabBarView(
          controller: controller,
          children: [
            // FirstTab(),
            FormApp(),
            FlagsGrid(
                countries: countries(),
                onTap: (country) {
                  print("Pays sélectionné: $country");
                }),
            WidgetCarte(),
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
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 150),
              Text(
                "Welcome back",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 10),
              Text(
                "Login to your account",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 50),
              TextFormField(
                  controller: _usernameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: "Nom & Pseudo",
                    prefixIcon: const Icon(Icons.person_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Veuillez entrer un nom';
                    }
                    return null;
                  }),
              const SizedBox(height: 10),
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
                decoration: InputDecoration(
                  labelText: "Role",
                  prefixIcon: const Icon(Icons.person_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value == null) {
                    return 'Veuillez sélectionner un rôle';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
                Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: _submitForm,
                      child: const Text("Register"),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account?"),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Login"),
                        ),
                      ],
                    ),
            ],
          ),
            ],
        ),
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


class FlagsGrid extends StatelessWidget {
  


  final List<Country> countries;
  final int crossAxisCount;

  // Ajouter callback
  final Function(String) onTap;

  const FlagsGrid({
    Key? key, 
    required this.countries,
    this.crossAxisCount = 4,
    // Ajouter callback
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
final TabController controller =
        _TabControllerProvider.of(context)!.controller;
  final _box = Hive.box("pass");

    return GridView.count(
      padding: EdgeInsets.all(20),
      crossAxisCount: crossAxisCount,
      children: countries.map((country) {
        
        // Entourer de GestureDetector
        return GestureDetector(
          onTap: () {
            // Appeler la callback
            _box.put("choice", country.team);
            onTap(_box.get("choice")); 
            controller.animateTo(2);
          },
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: FlagCircle(flag: country.flag),
          ),
        );

      }).toList(),
    );
  }

}