import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart'; 
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class CustomIDCard extends StatefulWidget {
  @override 
  _CustomIDCardState createState() => _CustomIDCardState();
}

class _CustomIDCardState extends State<CustomIDCard> {

  String name = "John Doe";
  String jobTitle = "Software Engineer"; 
  
  Uint8List? _imageBytes; 
  final _screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Custom ID Card"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            
            Screenshot(
              controller: _screenshotController,
              child: _buildIDCard(), 
            ),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
               _buildUploadImageButton(),
               _buildSaveToGalleryButton(),  
               _buildShareButton(),
              ],
            ),
            
          ],
        ),
      ),
    );
  }

  Widget _buildIDCard() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage("assets/id_template.png"),
          fit: BoxFit.cover
        ),
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
          SizedBox(height: 12,),
          Text(
            name,
            style: TextStyle(
              fontSize: 24, 
              fontWeight: FontWeight.bold
            ),
          ),
          Text(jobTitle),
        ],
      ) 
    );
  }

  Widget _buildUploadImageButton() {

    return ElevatedButton(
      onPressed: () {
        _modalBottomSheetMenu();  
      },
      child: Text("Upload Image"),
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
           ) 
         ),
       );
     }
   );
}

_imgFromCamera() async {
  final pickedFile = await ImagePicker().pickImage(
    source: ImageSource.camera,
    maxWidth: 1800,
    maxHeight: 1800,
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
    maxWidth: 1800,
    maxHeight: 1800,
  );

  if (pickedFile != null) {
    setState(() {
      _imageBytes = File(pickedFile.path).readAsBytesSync();
    });
  } 
}

 Widget _buildSaveToGalleryButton() {
    return ElevatedButton(
      onPressed: _saveScreenshot, 
      child: Text("Save to Gallery"),
    );
  }

    Widget _buildShareButton() {
    return ElevatedButton(
      onPressed: _shareScreenshot,  
      child: Text("Share"), 
    );
  }

  _saveScreenshot() async {
    final image = await _screenshotController.capture();
    final directory = (await getApplicationDocumentsDirectory()).path;
    File imgFile = File('$directory/id_card.png');
    imgFile.writeAsBytesSync(image!);
    await GallerySaver.saveImage(imgFile.path); 
  }

  _shareScreenshot() async {
    final image = await _screenshotController.capture();
    final directory = (await getApplicationDocumentsDirectory()).path;
    File imgFile = File('$directory/id_card.png');
    imgFile.writeAsBytesSync(image!); 
    await Share.shareFiles([imgFile.path]);
  }

}