// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:thanaphat_app_cs/src/pages/config/app_route.dart';
import 'package:thanaphat_app_cs/src/service/network.dart';
// import 'package:image_picker/image_picker.dart';

import '../../model/game_model.dart';

class GameManagementPage extends StatefulWidget {
  const GameManagementPage({super.key});

  @override
  State<GameManagementPage> createState() => _GameManagementPageState();
}

class _GameManagementPageState extends State<GameManagementPage> {
  final _formKey = GlobalKey<FormState>();
  bool? _editMode;
  Game? _game;

  // File? _image;
  // final picker = ImagePicker();

  // callback(File image) {
  //   _image = image;
  // }

  @override
  void initState() {
    _editMode = false;
    _game = Game();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Object? arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments is Game) {
      _game = arguments;
      _editMode = true;
    }

    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(18),
          child: Form(
            key: _formKey,
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
                // ProductImage(callback, image: _game?.gameImg ?? ''),
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
    initialValue: _game?.gameId ?? '',
    decoration: inputStyle(label: "id"),
    keyboardType: TextInputType.number,
    onSaved: (String? value) {
      _game?.gameId = value;
    },
  );

  TextFormField _buildNameInput() => TextFormField(
    initialValue: _game?.gameName ?? '',
    decoration: inputStyle(label: "name"),
    onSaved: (String? value) {
      _game?.gameName = value;
    },
  );

  TextFormField _buildDetailInput() => TextFormField(
    initialValue: _game?.gameDetail ?? '',
    decoration: inputStyle(label: "detail"),
    onSaved: (String? value) {
      _game?.gameDetail = value;
    },
  );

  TextFormField _buildPriceInput() => TextFormField(
    initialValue: _game?.gamePrice.toString() ?? '',
    decoration: inputStyle(label: "price"),
    keyboardType: TextInputType.number,
    onSaved: (String? value) {
      _game?.gamePrice = value.toString();
    },
  );

  TextFormField _buildStockInput() => TextFormField(
    initialValue: _game?.gameStock.toString() ?? '',
    decoration: inputStyle(label: "stock"),
    keyboardType: TextInputType.number,
    onSaved: (String? value) {
      _game?.gameStock = value.toString();
    },
  );

  TextFormField _buildImageInput() => TextFormField(
    initialValue: _game?.gameImg ?? '',
    decoration: inputStyle(label: "image"),
    onSaved: (String? value) {
      _game?.gameImg = value;
    },
  );

  AppBar _buildAppBar() => AppBar(
    centerTitle: false,
    title: Text((_editMode ?? false) ? 'Edit Game' : 'Add Game'),
    actions: [
      IconButton(
        onPressed: () async {
          _formKey.currentState?.save();
          FocusScope.of(context).requestFocus(FocusNode());
          if ((_editMode ?? false)) {
            //todo Edit
            try {
              final message = await NetworkService().editGameDioNoImage(_game!);
              if (message == 'Edit Successfully') {
                Navigator.pushNamed(context, AppRoute.gameRoute);
              } else {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Edit Failed')));
              }
            } catch (ex) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Edit Failed')));
            }
          } else {
            //todo Add Game No Image
            try {
              final message = await NetworkService().addGameDioNoImage(_game!);
              if (message == 'Add Successfully') {
                Navigator.pushNamed(context, AppRoute.gameRoute);
              } else {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Add Failed')));
              }
            } catch (ex) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Add Failed')));
            }
          }
        },
        icon: Icon(Icons.save, color: Colors.black),
      ),
    ],
  );
}

/*
class ProductImage extends StatefulWidget {
  final Function callBack;
  final String image;

  const ProductImage(this.callBack, {Key? key, required this.image})
    : super(key: key);

  @override
  _ProductImageState createState() => _ProductImageState();
}

class _ProductImageState extends State<ProductImage> {
  File? _imageFile;
  String? _image;
  final _picker = ImagePicker();

  @override
  void initState() {
    _image = widget.image;
    super.initState();
  }

  @override
  void dispose() {
    _imageFile?.delete();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[_buildPickerImage(), _buildPreviewImage()],
      ),
    );
  }

  dynamic _buildPreviewImage() {
    if ((_image == null || _image!.isEmpty) && (_imageFile == null)) {
      return SizedBox();
    }

    final container = (Widget child) => Container(
      color: Colors.grey[100],
      margin: EdgeInsets.only(top: 4),
      alignment: Alignment.center,
      height: 350,
      child: child,
    );

    return _image != null
        ? container(Image.network('${API.gameApiImage}/$_image'))
        : Stack(
            children: [
              container(Image.file(_imageFile!)),
              _buildDeleteImageButton(),
            ],
          );
  }

  OutlinedButton _buildPickerImage() => OutlinedButton.icon(
    icon: Icon(Icons.image),
    label: Text('image'),
    onPressed: () {
      _modalPickerImage();
    },
  );

  void _modalPickerImage() {
    final buildListTile = (IconData icon, String title, ImageSource source) =>
        ListTile(
          leading: Icon(icon),
          title: Text(title),
          onTap: () {
            Navigator.of(context).pop();
            _pickImage(source);
          },
        );

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              buildListTile(
                Icons.photo_camera,
                "Take a picture from camera",
                ImageSource.camera,
              ),
              buildListTile(
                Icons.photo_library,
                "Choose from photo library",
                ImageSource.gallery,
              ),
            ],
          ),
        );
      },
    );
  }

  void _pickImage(ImageSource source) {
    _picker
        .pickImage(
          source: source,
          imageQuality: 70,
          maxHeight: 500,
          maxWidth: 500,
        )
        .then((file) {
          if (file != null) {
            setState(() {
              _imageFile = File(file.path);
              _image = null;
              widget.callBack(_imageFile);
            });
          }
        })
        .catchError((error) {
          //todo
        });
  }

  Positioned _buildDeleteImageButton() => Positioned(
    right: 0,
    child: IconButton(
      onPressed: () {
        print('click delete image');
        setState(() {
          _imageFile = null;
          //widget.callBack(null);
        });
      },
      icon: Icon(Icons.clear, color: Colors.black54),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
    ),
  );
}
*/
