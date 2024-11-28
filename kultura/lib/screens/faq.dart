import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  final List<Map<String, String>> faqData = const [
    const {
      "question": "What is Kultura?",
      "answer": "Kultura is a platform to explore and promote cultural heritage and artistic works."
    },
    const {
      "question": "How do I create an account?",
      "answer": "To create an account, click on 'Sign Up', fill in the required details, and follow the instructions."
    },
    const {
      "question": "How can I reset my password?",
      "answer": "Click on 'Forgot Password' on the login screen and follow the instructions to reset your password."
    },
    const {
      "question": "Can I upload my own artwork?",
      "answer": "Yes! Once you create an artist account, you can upload and showcase your work."
    },
    const {
      "question": "Is there a way i can get a get a job/opporunity on kultura?",
      "answer": "Yes, Kultura provides a way to get a job/opporunity"
    },
  ];

  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Frequently Asked Questions"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 134, 15, 103),
      ),
      body: ListView.builder(
        itemCount: faqData.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            elevation: 2,
            child: ExpansionTile(
              title: Text(
                faqData[index]['question']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    faqData[index]['answer']!,
                    style: const TextStyle(color: Color.fromARGB(255, 8, 0, 0)),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: FAQPage(),
  ));
}
