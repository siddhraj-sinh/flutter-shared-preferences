import 'package:flutter/material.dart';
import 'package:shared_preference_app/services/user_preferences_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  String? _username;
  int? _age;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Preferences"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Enter your username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter your age',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _saveUserData,
              icon: const Icon(Icons.login),
              label: const Text('Login'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _removeUserData,
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                textStyle: const TextStyle(fontSize: 18),
                backgroundColor: Colors.redAccent
              ),
            ),
            const SizedBox(height: 20),
            Text(
              _username != null
                  ? 'Saved Username: $_username'
                  : 'No username saved',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              _age != null ? 'Saved Age: $_age' : 'No age saved',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveUserData() async {
    final username = _usernameController.text.trim();
    final age = int.tryParse(_ageController.text.trim());

    if (username.isNotEmpty) {
      await UserPreferences.saveUsername(username);
      setState(() {
        _username = username;
      });
    }

    if (age != null && age > 0) {
      await UserPreferences.saveUserAge(age);
      setState(() {
        _age = age;
      });
    }
  }

  Future<void> _loadUserData() async {
    final username = await UserPreferences.loadUsername();
    final age = await UserPreferences.loadUserAge();
    setState(() {
      _username = username;
      _age = age;
      _usernameController.text = username ?? '';
      _ageController.text = age?.toString() ?? '';
    });
  }

  Future<void> _removeUserData() async {
    await UserPreferences.removeUsername();
    await UserPreferences.removeUserAge();
    setState(() {
      _username = null;
      _age = null;
    });
  }
}
