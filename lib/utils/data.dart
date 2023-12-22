import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class WidgetCarte extends StatefulWidget {
  const WidgetCarte({super.key});

  @override
  State<WidgetCarte> createState() => _WidgetCarteState();
}

class _WidgetCarteState extends State<WidgetCarte> {
  
  final _screenshotController = ScreenshotController();

  String name = "John Doe";
  String jobTitle = "Software Engineer";
  
  Uint8List? _imageBytes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: BoxDecoration(
          color: Colors.green.shade700,
          image: DecorationImage(
            image: Image.network(
              "https://example.com/bg.jpg"
            ).image,
            fit: BoxFit.cover
          )
        ),
        alignment: Alignment.bottomCenter,
        child: SingleChildScrollView(
          child: Column(
            children: [
              
              Padding(
                padding: EdgeInsets.fromLTRB(16, 140, 16, 16),
                child: Screenshot(
                  controller: _screenshotController,
                  child: Container(
                    width: double.infinity,
                    constraints: BoxConstraints(
                      maxWidth: 570,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Column(
                        children: [
                          
                          Container(
                            width: 318,
                            height: 386,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  "https://example.com/image.png"  
                                )
                              )
                            ),
                            child: Column(
                              children: [
                                
                                ClipOval(
                                  child: Image.memory(
                                    _imageBytes ?? Uint8List(0),
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                
                                Text(
                                  name,
                                  style: TextStyle(
                                    fontSize: 24, 
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                
                                Text(jobTitle)
                                
                              ],
                            ),
                          ),
                          
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              
                              _buildUploadImageButton(),
                              
                              _buildSaveButton(),
                              
                              _buildShareButton(),
                              
                            ],
                          ),
                          
                        ],
                      ),
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

  _buildUploadImageButton() {
    return ElevatedButton(
      onPressed: () {
        _modalBottomSheetMenu();
      },
      child: Text('Upload Image'),
    );
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

  _buildSaveButton() {
    return ElevatedButton(
      onPressed: _saveScreenshot,
      child: Text('Save to Gallery')
    );
  }

  _shareScreenshot() async {
    final image = await _screenshotController.capture();
    final directory = (await getApplicationDocumentsDirectory()).path;
    File imgFile = File('$directory/id_card.png');
    imgFile.writeAsBytesSync(image!);
    await Share.shareFiles([imgFile.path]);
  }

  _buildShareButton() {
    return ElevatedButton(
      onPressed: _shareScreenshot,
      child: Text('Share')
    );
  }

}