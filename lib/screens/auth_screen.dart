import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notification_app/screens/messagesscreens.dart';

class AuthScreen extends StatefulWidget {
@override
_AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
final FirebaseAuth _auth = FirebaseAuth.instance;
final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
bool _isRegistering = false;

// Function to register a user
void _register() async {
try {
setState(() => _isRegistering = true);
UserCredential userCredential =
await _auth.createUserWithEmailAndPassword(
email: _emailController.text.trim(),
password: _passwordController.text.trim(),
);
Navigator.pushReplacement(
context,
MaterialPageRoute(
builder: (BuildContext context) => Messagesscreens()
)
);
ScaffoldMessenger.of(context).showSnackBar(
SnackBar(
content: Text(
'Registered successfully as: ${userCredential.user?.email}')),
);
await Future.delayed(const Duration(seconds: 2));
print('hhhh');

} on FirebaseAuthException catch (e) {
ScaffoldMessenger.of(context).showSnackBar(
SnackBar(content: Text('Error: ${e.message}')),
);
} finally {
setState(() => _isRegistering = false);
}
}

// Function to log in a user
void _login() async {
try {
UserCredential userCredential = await _auth.signInWithEmailAndPassword(
email: _emailController.text.trim(),
password: _passwordController.text.trim(),
);
ScaffoldMessenger.of(context).showSnackBar(
SnackBar(content: Text('Logged in as: ${userCredential.user?.email}')),
);
await Future.delayed(const Duration(seconds: 2));
Navigator.pushReplacement(
context,
MaterialPageRoute(
builder: (BuildContext context) => Messagesscreens()
)
);
} on FirebaseAuthException catch (e) {
ScaffoldMessenger.of(context).showSnackBar(
SnackBar(content: Text('Error: ${e.message}')),
);
}
}

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: Text('Login Page'),
centerTitle: true,
),
body: Padding(
padding: const EdgeInsets.all(16.0),
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
TextField(
controller: _emailController,
decoration: InputDecoration(
labelText: 'Email',
border: OutlineInputBorder(),
prefixIcon: Icon(Icons.email),
),
keyboardType: TextInputType.emailAddress,
),
SizedBox(height: 20),
TextField(
controller: _passwordController,
decoration: InputDecoration(
labelText: 'Password',
border: OutlineInputBorder(),
prefixIcon: Icon(Icons.lock),
),
obscureText: true,
),
SizedBox(height: 30),
ElevatedButton(
onPressed: _isRegistering ? null : _register,
child: _isRegistering
? CircularProgressIndicator(color: Colors.white)
    : Text('Register'),
style: ElevatedButton.styleFrom(
minimumSize: Size(double.infinity, 50),
),
),
SizedBox(height: 10),
ElevatedButton(
onPressed:_login,
child: Text('Login'),
style: ElevatedButton.styleFrom(
minimumSize: Size(double.infinity, 50),
),
),
],
),
),
);
}
}
