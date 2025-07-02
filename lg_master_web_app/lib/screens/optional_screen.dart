// ----------------------------------- OPTIONAL SCREEN -----------------------------------
// This screen provides optional learning resources on integrating advanced technologies
// These include Google Earth, Node.js, and Artificial Intelligence

import 'package:flutter/material.dart';

class OptionalScreen extends StatelessWidget {
  const OptionalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Optional Features'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: const [
            _FeatureCard(
              title: 'Integrating Google Earth',
              description:
                  'Learn how to control Google Earth using Liquid Galaxy\'s KML files, coordinates, and tours. You can automate visualizations and build immersive experiences.',
            ),
            _FeatureCard(
              title: 'Using Node.js',
              description:
                  'Integrate Node.js to create backend services, APIs, or data pipelines. Node.js can run servers that communicate with your Flutter app or external databases.',
            ),
            _FeatureCard(
              title: 'Incorporating Artificial Intelligence',
              description:
                  'Add AI to your app using pre-trained models or APIs (e.g., OpenAI, TensorFlow). You can build features like voice assistants, object detection, or predictive analytics.',
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------- Reusable Card Widget ----------------------
class _FeatureCard extends StatelessWidget {
  final String title;
  final String description;

  const _FeatureCard({
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
