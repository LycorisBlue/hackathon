import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:hive/hive.dart';


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



class FormApp extends StatefulWidget {
  const FormApp({super.key});

  @override
  State<FormApp> createState() => _FormAppState();
}

class _FormAppState extends State<FormApp> {
  
  final _box = Hive.box("pass");
  // Dans le State
  final _nameController = TextEditingController();
  final _postController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Enregistrement dans Hive
      _box.put("username", _nameController.text);
      _box.put("role", _nameController);

      // Redirection vers Tab 2
      TabController controller = _TabControllerProvider.of(context)!.controller;
      controller.animateTo(1);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: Image.network(
              'https://s-p5.com/medi/ansut/country/Suppoter-Maso.jpg',
            ).image,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 250, 16, 16),
                child: Container(
                  width: double.infinity,
                  constraints: BoxConstraints(
                    maxWidth: 570,
                  ),
                  decoration: BoxDecoration(
                    // color: FlutterFlowTheme.of(context).secondaryBackground,
                    color: Colors.white,

                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4,
                        color: Color(0x33000000),
                        offset: Offset(0, 2),
                      )
                    ],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(16, 20, 16, 24),
                          child: Text("Créez votre passeport CAN",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(16, 0, 16, 18),
                                child: TextFormField(
                                  controller: _nameController,
                                  // Validation
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Ce champ est requis';
                                    }
                                    return null;
                                  }, 
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText:
                                        "Votre Nom",
                                    labelStyle: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade400,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(16, 0, 16, 18),
                                child: TextFormField(
                                  controller: _postController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Ce champ est requis'; 
                                    }
                                    return null;
                                  },
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText:
                                        "Votre poste Ex: Défenseur, Att...",
                                    labelStyle: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade400,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(16, 0, 16, 20),
                                child: ElevatedButton(
                                  onPressed: () {
                                    
                                  },
                                  child: Text(
                                    "Continuer",
                                    style: TextStyle(
                                      fontFamily: "Readex Pro",
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size(double.infinity, 40),
                                    primary: Color(0xFF003E1F),
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
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

String getFlag(String countryName) {

  // Liste des équipes 
  final teams = [
    
    Country(
      team: "Algérie",
      flag: "https://s-p5.com/medi/ansut/pictures/Alg%C3%A9rie.png"
    ),
    
    Country(
      team: "afrique du sud",
      flag: "https://s-p5.com/medi/ansut/pictures/Afrique%20du%20Sud.png"
    ),
    Country(
      team: "angola", 
      flag: "https://s-p5.com/medi/ansut/pictures/Angola.png"
    ),
    Country(
      team: "Burkina Faso",
      flag: "https://s-p5.com/medi/ansut/pictures/Burkina.png"
    ),
    Country(
      team: "cameroun",
      flag: "https://s-p5.com/medi/ansut/pictures/Cameroun.png"
    ),
    Country(
      team: "Cap-Vert",
      flag: "https://s-p5.com/medi/ansut/pictures/Cape%20vert.png"
    ),
    Country( 
      team: "Côte d'Ivoire",
      flag: "https://s-p5.com/medi/ansut/pictures/C%C3%B4te%20d%E2%80%99Ivoire.png"
    ),
    Country(
      team: "Égypte",
      flag: "https://s-p5.com/medi/ansut/pictures/%C3%89gypte.png"
    ),
    Country(
      team: "Gambie",
      flag: "https://s-p5.com/medi/ansut/pictures/Gambie.png"
    ),
    Country(
      team: "Ghana",
      flag: "https://s-p5.com/medi/ansut/pictures/Ghana.png"
    ),
    Country(
      team: "Guinee",
      flag: "https://s-p5.com/medi/ansut/pictures/Guin%C3%A9e%20Conakry.png"
    ),
    Country(
      team: "Guinée-Bissau",
      flag: "https://s-p5.com/medi/ansut/pictures/Guin%C3%A9e%20Bissau.png" 
    ),
    Country(
      team: "Guinée équatoriale",
      flag: "https://s-p5.com/medi/ansut/pictures/%C3%89quatoriale%20Guin%C3%A9e.png"
    ),
    Country(
      team: "Mali", 
      flag: "https://s-p5.com/medi/ansut/pictures/Mali.png"
    ),
    Country(
      team: "Maroc", 
      flag: "https://s-p5.com/medi/ansut/pictures/Maroc.png"
    ),
    Country(
      team: "Mauritanie", 
      flag: "https://s-p5.com/medi/ansut/pictures/Mauritanie.png"
    ),
    Country(
      team: "Mozambique", 
      flag: "https://s-p5.com/medi/ansut/pictures/Mozambique.png"
    ),
    Country(
      team: "Namibie", 
      flag: "https://s-p5.com/medi/ansut/pictures/Namibie.png"
    ),
    Country(
      team: "Nigeria", 
      flag: "https://s-p5.com/medi/ansut/pictures/Nigeria.png"
    ),
    Country(
      team: "RD congo", 
      flag: "https://s-p5.com/medi/ansut/pictures/RD%20Congo.png"
    ),
    Country(
      team: "Sénégal", 
      flag: "https://s-p5.com/medi/ansut/pictures/S%C3%A9n%C3%A9gal.png"
    ),
    Country(
      team: "Tanzanie", 
      flag: "https://s-p5.com/medi/ansut/pictures/Tanzanie.png"
    ),
    Country(
      team: "Tunisie", 
      flag: "https://s-p5.com/medi/ansut/pictures/Tunisie.png"
    ),
    Country(
      team: "Zambie", 
      flag: "https://s-p5.com/medi/ansut/pictures/Zambie.png"
    ),
  ];

  // Trouver le pays dans la liste
  final country = teams.firstWhere((c) => c.team == countryName);

  if (true) {
    // Enregistrer le drapeau dans Hive
    // _flagsBox.put(countryName, country.flag);

    // Retourner le drapeau
    return country.flag; 
  }

}

class Country {
  String team;
  String flag;

  Country({required this.team, required this.flag});
}

List<Country> countries() {
  return [
    
    Country(
      team: "Algérie",
      flag: "https://flagcdn.com/w2560/dz.png"
    ),
    
    Country(
      team: "afrique du sud",
      flag: "https://flagcdn.com/w2560/za.png"
    ),
    Country(
      team: "angola", 
      flag: "https://flagcdn.com/w2560/ao.png"
    ),
    Country(
      team: "Burkina Faso",
      flag: "https://flagcdn.com/w2560/bf.png"
    ),
    Country(
      team: "cameroun",
      flag: "https://flagcdn.com/w2560/cm.png"
    ),
    Country(
      team: "Cap-Vert",
      flag: "https://flagcdn.com/w2560/cv.png"
    ),
    Country( 
      team: "Côte d'Ivoire",
      flag: "https://flagcdn.com/w2560/ci.png"
    ),
    Country(
      team: "Égypte",
      flag: "https://flagcdn.com/w2560/eg.png"
    ),
    Country(
      team: "Gambie",
      flag: "https://flagcdn.com/w2560/gm.png"
    ),
    Country(
      team: "Ghana",
      flag: "https://flagcdn.com/w2560/gh.png"
    ),
    Country(
      team: "Guinee",
      flag: "https://flagcdn.com/w2560/gn.png"
    ),
    Country(
      team: "Guinée-Bissau",
      flag: "https://flagcdn.com/w2560/gw.png" 
    ),
    Country(
      team: "Guinée équatoriale",
      flag: "https://flagcdn.com/w2560/gq.png"
    ),
    Country(
      team: "Mali", 
      flag: "https://flagcdn.com/w2560/ml.png"
    ),
    Country(
      team: "Maroc", 
      flag: "https://flagcdn.com/w2560/ma.png"
    ),
    Country(
      team: "Mauritanie", 
      flag: "https://flagcdn.com/w2560/mr.png"
    ),
    Country(
      team: "Mozambique", 
      flag: "https://flagcdn.com/w2560/mz.png"
    ),
    Country(
      team: "Namibie", 
      flag: "https://flagcdn.com/w2560/na.png"
    ),
    Country(
      team: "Nigeria", 
      flag: "https://flagcdn.com/w2560/ng.png"
    ),
    Country(
      team: "RD congo", 
      flag: "https://flagcdn.com/w2560/cd.png"
    ),
    Country(
      team: "Sénégal", 
      flag: "https://flagcdn.com/w2560/sn.png"
    ),
    Country(
      team: "Tanzanie", 
      flag: "https://flagcdn.com/w2560/tz.png"
    ),
    Country(
      team: "Tunisie", 
      flag: "https://flagcdn.com/w2560/tn.png"
    ),
    Country(
      team: "Zambie", 
      flag: "https://flagcdn.com/w2560/zm.png"
    ),
  ];
}

class FlagCircle extends StatelessWidget {
  
  final String flag;
  
  const FlagCircle({
    Key? key, 
    required this.flag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(flag),
          fit: BoxFit.cover
        )  
      ),
    );
  }
}

class WidgetCarte extends StatefulWidget {
  const WidgetCarte({super.key});

  @override
  State<WidgetCarte> createState() => _WidgetCarteState();
}

class _WidgetCarteState extends State<WidgetCarte> {
  final _box = Hive.box("pass");
  final _screenshotController = ScreenshotController();


  Uint8List? _imageBytes;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.sizeOf(context).height * 0.9,
        decoration: BoxDecoration(
            color: Colors.green.shade700,
            image: DecorationImage(
                image: Image.network(
                        "https://s-p5.com/medi/ansut/country/Suppoter-Maso.jpg")
                    .image,
                fit: BoxFit.cover)),
        alignment: AlignmentDirectional(0, -1),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 140, 16, 16),
                child: Container(
                  width: double.infinity,
                  constraints: BoxConstraints(
                    maxWidth: 570,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4,
                        color: Color(0x33000000),
                        offset: Offset(0, 2),
                      )
                    ],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                            child: Screenshot(
                              controller: _screenshotController,
                              child: Container(
                                width: 318,
                                height: 386,
                                decoration: BoxDecoration(
                                  color: Colors.white60,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: Image.network(
                                      getFlag(_box.get("choice")),
                                    ).image,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 4,
                                      color: Color(0x33000000),
                                      offset: Offset(0, 2),
                                      spreadRadius: 5,
                                    )
                                  ],
                                ),
                                child: Stack(
                                  children: [
                                    Container(
                                      width: 324.0,
                                      height: 390.0,
                                      decoration: BoxDecoration(),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Stack(
                                            children: [
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    0.0, -1.0),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(10.0, 30.0,
                                                          10.0, 0.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0.0, 0.0),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      92.0,
                                                                      40.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        80.0),
                                                            child: Image.memory(
                                                              _imageBytes ??
                                                                  Uint8List(0),
                                                              width: 115,
                                                              height: 115,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 20.0, 0.0, 0.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 10.0, 0.0, 0.0),
                                                  child: Container(
                                                    width: 254.0,
                                                    height: 28.0,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white),
                                                    child: Text(
                                                      _box.get("username"),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: 250.0,
                                                  height: 32.0,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white),
                                                  child: Text(
                                                    _box.get("role"),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(-1.0, 0.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15.0, 0.0, 16.0, 40.0),
                                child: ElevatedButton(
                                  onPressed: _modalBottomSheetMenu,
                                  child: Text(
                                    'Inserer photo',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: Size(120, 44),
                                    primary: Color(0xFF084D3C),
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(-1.0, 0.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15.0, 0.0, 16.0, 40.0),
                                child: ElevatedButton(
                                  onPressed: _shareScreenshot,
                                  child: Text(
                                    'partager',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: Size(120, 44),
                                    primary: Color(0xFF084D3C),
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _imgFromCamera() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );

    if (pickedFile != null) {
      setState(() {
        _imageBytes = File(pickedFile.path).readAsBytesSync();
      });
    }
  }

  _imgFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _imageBytes = File(pickedFile.path).readAsBytesSync();
      });
    }
  }

  void _modalBottomSheetMenu() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            height: 150.0,
            color: Colors.transparent,
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(10.0),
                        topRight: const Radius.circular(10.0))),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.camera_alt),
                      title: Text('Camera'),
                      onTap: () {
                        Navigator.pop(context);
                        _imgFromCamera();
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.image),
                      title: Text('Gallery'),
                      onTap: () {
                        Navigator.pop(context);
                        _imgFromGallery();
                      },
                    )
                  ],
                )),
          );
        });
  }

  _saveScreenshot() async {
    final image = await _screenshotController.capture();
    final directory = (await getApplicationDocumentsDirectory()).path;
    File imgFile = File('$directory/id_card.png');
    imgFile.writeAsBytesSync(image!);
    // Code pour sauvegarder
  }

  _shareScreenshot() async {
    final image = await _screenshotController.capture();
    final directory = (await getApplicationDocumentsDirectory()).path;
    File imgFile = File('$directory/id_card.png');
    imgFile.writeAsBytesSync(image!);
    await Share.shareFiles([imgFile.path]);

    Fluttertoast.showToast(
    msg: "Téléchargement réussi",
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.green,
    textColor: Colors.white,
    fontSize: 16.0
);
  }
}
