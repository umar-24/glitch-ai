import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:glitch_ai/constants/const.dart';
import 'package:http/http.dart' as http;

class ImageGenerator extends StatefulWidget {
  const ImageGenerator({super.key});

  @override
  State<ImageGenerator> createState() => _ImageGeneratorState();
}

class _ImageGeneratorState extends State<ImageGenerator> {
  TextEditingController promptController = TextEditingController();
  List<String> imageUrls = [];
  bool isLoading = false;

  Future<void> generateImage() async {
    setState(() {
      isLoading = true;
      imageUrls.clear();
    });

    const String apiUrl = "https://api.openai.com/v1/images/generations";
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        "Authorization": "Bearer $API_KEY",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "model": "dall-e-2",
        "prompt": promptController.text,
        "n": 4,
        "size": "512x512"
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        imageUrls = List<String>.from(data["data"].map((img) => img["url"]));
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${response.statusCode}")),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Glitch Image Generator", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Center(
                  child: imageUrls.isNotEmpty
                      ? GridView.builder(
                          padding: const EdgeInsets.all(16.0),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: imageUrls.length,
                          itemBuilder: (context, index) {
                            return Image.network(imageUrls[index]);
                          },
                        )
                      : const Text(
                          "Images will appear here",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: promptController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[900],
                    hintText: "Enter prompt for AI image",
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    suffixIcon: ElevatedButton.icon(
                      onPressed: generateImage,
                      icon:  Icon(Icons.auto_awesome, color: Colors.black),
                      label: const Text("Generate", style: TextStyle(color: Colors.black),),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(
                
                color: Colors.white,
                strokeWidth: 3,
              ),
            ),
        ],
      ),
    );
  }
}
