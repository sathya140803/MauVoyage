import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TranslatePage extends StatefulWidget {
  const TranslatePage({Key? key}) : super(key: key);

  @override
  State<TranslatePage> createState() => _TranslatePageState();
}

class _TranslatePageState extends State<TranslatePage> {
  CameraController? _cameraController;
  bool _isProcessing = false;
  String _translatedText = "";

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    _cameraController = CameraController(cameras.first, ResolutionPreset.medium);
    await _cameraController?.initialize();
    setState(() {});
  }

  Future<void> _captureAndTranslate() async {
    if (_cameraController == null || _isProcessing) return;

    setState(() {
      _isProcessing = true;
    });

    try {
      final picture = await _cameraController!.takePicture();
      final text = await _extractTextFromImage(picture.path);
      final translatedText = await _translateText(text!, 'en', 'es'); // Example: English to Spanish
      setState(() {
        _translatedText = translatedText ?? "Translation failed.";
      });
    } catch (e) {
      setState(() {
        _translatedText = "Error: $e";
      });
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  Future<String?> _extractTextFromImage(String imagePath) async {
    final textRecognizer = TextRecognizer();
    final inputImage = InputImage.fromFilePath(imagePath);
    final recognizedText = await textRecognizer.processImage(inputImage);
    return recognizedText.text;
  }

  Future<String?> _translateText(String text, String sourceLang, String targetLang) async {
    const apiKey = 'YOUR_GOOGLE_TRANSLATE_API_KEY'; // Replace with your API key
    final url = Uri.parse('https://translation.googleapis.com/language/translate/v2?key=$apiKey');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'q': text,
        'source': sourceLang,
        'target': targetLang,
        'format': 'text',
      }),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse['data']['translations'][0]['translatedText'];
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Translate'),
      ),
      body: Column(
        children: [
          if (_cameraController != null && _cameraController!.value.isInitialized)
            AspectRatio(
              aspectRatio: _cameraController!.value.aspectRatio,
              child: CameraPreview(_cameraController!),
            ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _isProcessing ? null : _captureAndTranslate,
            child: const Text('Capture and Translate'),
          ),
          const SizedBox(height: 16),
          Text(
            _translatedText,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }
}
