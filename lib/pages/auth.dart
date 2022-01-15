import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  String _emailValue;
  String _passwordValue;
  bool _acceptTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/pexels-mehrad-vosoughi-3687999.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.6), BlendMode.dstATop),
          ),
        ),
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'E-Mail'),
              keyboardType: TextInputType.emailAddress,
              onChanged: (String value) {
                setState(() {
                  _emailValue = value;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              onChanged: (String value) {
                setState(() {
                  _passwordValue = value;
                });
              },
            ),
            SwitchListTile(
              value: _acceptTerms,
              onChanged: (bool value) {
                setState(() {
                  _acceptTerms = value;
                });
              },
              title: Text('Accept Terms'),
            ),
            ElevatedButton(
              child: Text('LOGIN'),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/products');
              },
            ),
          ],
        ),
      ),
    );
  }
}
