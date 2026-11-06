import 'package:flutter/material.dart';
import 'preview_screen.dart';

class TextPreviewerScreen extends StatefulWidget {
  const TextPreviewerScreen({super.key});

  @override
  State<TextPreviewerScreen> createState() => _TextPreviewerScreenState();
}

class _TextPreviewerScreenState extends State<TextPreviewerScreen> {
  final TextEditingController _textController = TextEditingController();
  double _fontSize = 16.0;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
  
  Future<void> _navigateToPreview() async {
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) => PreviewScreen(
          text: _textController.text,
          fontSize: _fontSize,
        ),
      ),
    );

    if (!mounted) return;

    String message;
    if (result == 'ok') {
      message = 'Cool!';
    } else if (result == 'cancel') {
      message = "Let's try something else.";
    } else {
      message = "Don't know what to say.";
    }

    _showResultDialog(message);
  }

  void _showResultDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(
              'https://emojiisland.com/cdn/shop/products/Robot_Emoji_Icon_abe1111a-1293-4668-bdf9-9ceb05cff58e_large.png?v=1571606090',
              height: 60,
              errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.android, size: 60, color: Colors.purple),
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text previewer'),
        centerTitle: true,
        backgroundColor: const Color(0xFFE8DEF8),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Text:',
                hintText: 'Enter some text',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 24),

            Row(
              children: [
                Text(
                  'Font size: ${_fontSize.toInt()}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Expanded(
                  child: Slider(
                    value: _fontSize,
                    min: 10,
                    max: 50,
                    onChanged: (val) {
                      setState(() {
                        _fontSize = val;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF6750A4),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: _navigateToPreview,
              child: const Text('Preview', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}