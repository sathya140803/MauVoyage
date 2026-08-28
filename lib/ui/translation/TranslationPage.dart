import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'text_recognition.dart';
import 'translation_service.dart';

class TranslationPage extends StatefulWidget {
  @override
  _TranslationPageState createState() => _TranslationPageState();
}

class _TranslationPageState extends State<TranslationPage> {
  File? _image;
  String _extractedText = "";
  String _translatedText = "";
  final ImagePicker _picker = ImagePicker();
  String _selectedLanguage = 'fr'; // Default language to French

  // List of languages you can translate to
  final List<Map<String, String>> _languages = [
    {'name': 'French', 'code': 'fr'},
    {'name': 'Spanish', 'code': 'es'},
    {'name': 'German', 'code': 'de'},
    {'name': 'Italian', 'code': 'it'},
    {'name': 'Portuguese', 'code': 'pt'},
    {'name': 'Chinese', 'code': 'zh'},
    {'name': 'Japanese', 'code': 'ja'},
    // Add more languages here
  ];

  // Pick image from camera or gallery
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(
      source: await _showImageSourceDialog(), // Get source from a dialog
    );

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      _processImage(_image!);
    }
  }

  // Show dialog to choose the image source
  Future<ImageSource> _showImageSourceDialog() async {
    return await showDialog<ImageSource>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose Image Source'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.camera),
                  title: Text('Camera'),
                  onTap: () => Navigator.pop(context, ImageSource.camera),
                ),
                ListTile(
                  leading: Icon(Icons.photo),
                  title: Text('Gallery'),
                  onTap: () => Navigator.pop(context, ImageSource.gallery),
                ),
              ],
            ),
          ),
        );
      },
    ) ?? ImageSource.gallery; // Default to gallery if dialog is canceled
  }

  // Extract text from the image
  Future<void> _processImage(File image) async {
    String text = await extractText(image);
    setState(() {
      _extractedText = text;
    });
    _translateText(text);
  }

  // Translate the extracted text
  Future<void> _translateText(String text) async {
    String translated = await translateText(text, 'en', _selectedLanguage); // From English to selected language
    setState(() {
      _translatedText = translated;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Translation App'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _image != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.file(
                    _image!,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                )
                    : InkWell( // Make the container clickable
                  onTap: _pickImage, // Open picker on tap
                  child: Container(
                    height: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: Colors.grey[300],
                    ),
                    child: Center(
                      child: Text(
                        'No image selected',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _pickImage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                  child: Text('Capture Image'),
                ),
                SizedBox(height: 20),
                DropdownButton<String>(
                  value: _selectedLanguage,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedLanguage = newValue!;
                    });
                    if (_extractedText.isNotEmpty) {
                      _translateText(_extractedText); // Translate immediately after language selection
                    }
                  },
                  items: _languages.map<DropdownMenuItem<String>>((Map<String, String> language) {
                    return DropdownMenuItem<String>(
                      value: language['code'],
                      child: Text(language['name']!),
                    );
                  }).toList(),
                  dropdownColor: Colors.white,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                  iconEnabledColor: Colors.blueAccent,
                ),
                SizedBox(height: 20),
                Text(
                  'Extracted Text:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.grey[100],
                  ),
                  child: Text(
                    _extractedText.isNotEmpty ? _extractedText : 'No text extracted yet.',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Translated Text:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.grey[100],
                  ),
                  child: Text(
                    _translatedText.isNotEmpty ? _translatedText : 'Translation will appear here.',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}