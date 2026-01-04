import 'package:flutter/material.dart';
import '../services/sentiment_service.dart';
import '../model/sentiment_response.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController controller = TextEditingController();
  final SentimentService service = SentimentService();

  String result = "";
  Color resultColor = Colors.black;
  bool loading = false;

  @override
  void dispose() {
    controller.dispose(); // Mencegah kebocoran memori
    super.dispose();
  }

  void analyze() async {
    if (controller.text.isEmpty) {
      setState(() => result = "Ulasan tidak boleh kosong");
      return;
    }

    setState(() {
      loading = true;
      result = "";
    });

    // Memanggil fungsi AI
    SentimentResponse response = await service.analyzeSentiment(controller.text);

    setState(() {
      loading = false;
      result = "Hasil: ${response.sentiment}";
      
      // Memberi warna berdasarkan hasil
      if (response.sentiment.contains("Positif")) {
        resultColor = Colors.green;
      } else if (response.sentiment.contains("Negatif")) {
        resultColor = Colors.red;
      } else {
        resultColor = Colors.orange;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AI Sentiment Analysis"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: controller,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Masukkan ulasan barang/layanan",
                hintText: "Contoh: Barang cepat sampai tapi mudah sobek...",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: loading ? null : analyze,
              icon: loading 
                ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                : const Icon(Icons.analytics),
              label: const Text("Analisis dengan AI"),
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(15)),
            ),
            const SizedBox(height: 30),
            if (result.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: resultColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: resultColor),
                ),
                child: Text(
                  result,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: resultColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}