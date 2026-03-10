import 'package:flutter/material.dart';

class GameManagementPage extends StatefulWidget {
  const GameManagementPage({super.key});

  @override
  State<GameManagementPage> createState() => _GameManagementPageState();
}

class _GameManagementPageState extends State<GameManagementPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Game Management")),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(18),
          child: Form(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Flexible(flex: 1, child: _buildIdInput()),
                    SizedBox(width: 12.0),
                    Flexible(flex: 3, child: _buildNameInput()),
                  ],
                ),
                SizedBox(height: 12.0),
                _buildDetailInput(),
                SizedBox(height: 12.0),
                Row(
                  children: <Widget>[
                    Flexible(flex: 1, child: _buildPriceInput()),
                    SizedBox(width: 12.0),
                    Flexible(flex: 1, child: _buildStockInput()),
                  ],
                ),
                SizedBox(height: 12.0),
                _buildImageInput(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration inputStyle({String? label}) => InputDecoration(
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue, width: 2),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black),
    ),
    labelText: label,
    labelStyle: TextStyle(fontSize: 20.0),
  );

  TextFormField _buildIdInput() => TextFormField(
    decoration: inputStyle(label: "id"),
    keyboardType: TextInputType.number,
    onSaved: (String? value) {
      //todo
    },
  );

  TextFormField _buildNameInput() => TextFormField(
    decoration: inputStyle(label: "name"),
    onSaved: (String? value) {
      //todo
    },
  );

  TextFormField _buildDetailInput() => TextFormField(
    decoration: inputStyle(label: "detail"),
    onSaved: (String? value) {
      //todo
    },
  );

  TextFormField _buildPriceInput() => TextFormField(
    decoration: inputStyle(label: "price"),
    keyboardType: TextInputType.number,
    onSaved: (String? value) {
      //todo
    },
  );

  TextFormField _buildStockInput() => TextFormField(
    decoration: inputStyle(label: "stock"),
    keyboardType: TextInputType.number,
    onSaved: (String? value) {
      //todo
    },
  );

  TextFormField _buildImageInput() => TextFormField(
    decoration: inputStyle(label: "image"),
    onSaved: (String? value) {
      //todo
    },
  );
}
