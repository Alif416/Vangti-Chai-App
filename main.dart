import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String input = '';
  String result = '';

  final List<int> notes = [500, 100, 50, 20, 10, 5, 2, 1];
  List<int> noteCounts = [0, 0, 0, 0, 0, 0, 0, 0];

  void _updateCalculation() {
    setState(() {
      int amount = int.tryParse(input) ?? 0;
      if (amount <= 0) {
        // Reset the note counts if the amount is zero or invalid
        noteCounts = [0, 0, 0, 0, 0, 0, 0, 0];
        result = '';
        return;
      }

      noteCounts = [0, 0, 0, 0, 0, 0, 0, 0];

      for (int i = 0; i < notes.length; i++) {
        int count = amount ~/ notes[i];
        noteCounts[i] = count;
        amount = amount % notes[i];
      }

      List<String> changeDetails = [];
      for (int i = 0; i < notes.length; i++) {
        if (noteCounts[i] > 0) {
          changeDetails.add('${noteCounts[i]} x ৳${notes[i]}');
        }
      }
      result = changeDetails.join('\n');
    });
  }

  // Function to add numbers to input
  void _addToInput(String value) {
    setState(() {
      input += value;
    });
    _updateCalculation();
  }

  // Function to clear the input and result
  void _clearInput() {
    setState(() {
      input = '';
      result = '';
      noteCounts = [0, 0, 0, 0, 0, 0, 0, 0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Vangti Chai",
          style: TextStyle(
            fontSize: 25.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 6, 109, 6),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: TextField(
                readOnly: true,
                controller: TextEditingController(text: input),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Enter Amount",
                  hintText: "Enter Only Digits",
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            // Keypad area
            Expanded(
              child: Row(
                children: [
                  // Keypad on the left
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {

                        int crossAxisCount = constraints.maxWidth > 600 ? 4 : 3;
                        return GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 6.0,
                          mainAxisSpacing: 12.0,
                          childAspectRatio: 1,
                          children: [
                            for (var i = 1; i <= 9; i++)
                              _buildKeyButton(i.toString()),
                            _buildKeyButton('0'),
                            _buildKeyButton('Clear', isClear: true),
                          ],
                        );
                      },
                    ),
                  ),


                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const SizedBox(height: 20),
                          Text(
                            '500: ${noteCounts[0]} ',
                            style: const TextStyle(fontSize: 16),
                          ),
                          Text(
                            '100: ${noteCounts[1]} ',
                            style: const TextStyle(fontSize: 16),
                          ),
                          Text(
                            '50: ${noteCounts[2]} ',
                            style: const TextStyle(fontSize: 16),
                          ),
                          Text(
                            '20: ${noteCounts[3]} ',
                            style: const TextStyle(fontSize: 16),
                          ),
                          Text(
                            '10: ${noteCounts[4]} ',
                            style: const TextStyle(fontSize: 16),
                          ),
                          Text(
                            '5: ${noteCounts[5]} ',
                            style: const TextStyle(fontSize: 16),
                          ),
                          Text(
                            '2: ${noteCounts[6]} ',
                            style: const TextStyle(fontSize: 16),
                          ),
                          Text(
                            '1: ${noteCounts[7]} ',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Key button widget
  Widget _buildKeyButton(String value, {bool isClear = false}) {
    return ElevatedButton(
      onPressed: () {
        if (isClear) {
          _clearInput();
        } else {
          _addToInput(value);
        }
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(16.0),
        textStyle: const TextStyle(fontSize: 24.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: Text(value),
    );
  }
}
