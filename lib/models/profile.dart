import 'dart:io';

import 'package:children_now/components/button_loading.dart';
import 'package:children_now/components/profile/image.dart';
import 'package:children_now/models/user.dart';
import 'package:children_now/providers/app_state.dart';
import 'package:children_now/utils/upload_file.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class PageProfile extends StatefulWidget {
  final User user;
  const PageProfile({Key? key, required this.user}) : super(key: key);

  @override
  State<PageProfile> createState() => _PageProfileState();
}

class _PageProfileState extends State<PageProfile> {
  final _formKey = GlobalKey<FormState>();
  final _ctrlName = TextEditingController();
  final _ctrlPhone = TextEditingController();

  final _nodePhone = FocusNode();

  File? image;

  @override
  void initState() {
    _ctrlName.text = widget.user.name ?? '';
    _ctrlPhone.text = widget.user.phone ?? '';
    super.initState();
  }

  @override
  void dispose() {
    _ctrlName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Scaffold(
      backgroundColor: const Color(0xffCAC4C7),
      appBar: AppBar(
        backgroundColor: const Color(0xff666264),
        title: const Text('Información personal'),
      ),
      body: Form(
          key: _formKey,
          child: Scrollbar(
            child: ListView(
              children: [
                SelectImage(
                  function: (File? photo) => setState(() => image = photo),
                  photo: image,
                  tagHero: 'image',
                  urlImage: widget.user.photo,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Email'),
                        initialValue: widget.user.email,
                        readOnly: true,
                        onTap: () {
                          Fluttertoast.showToast(msg: 'Email no editable');
                        },
                      ),
                      TextFormField(
                        controller: _ctrlName,
                        decoration: const InputDecoration(labelText: 'Nombre'),
                        validator: (val) {
                          if (val!.isNotEmpty) {
                            return null;
                          } else {
                            return 'Escribe tu nombre';
                          }
                        },
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_nodePhone);
                        },
                      ),
                      TextFormField(
                        controller: _ctrlPhone,
                        focusNode: _nodePhone,
                        decoration:
                            const InputDecoration(labelText: 'Teléfono'),
                        keyboardType: TextInputType.phone,
                        validator: (val) {
                          if (val!.isNotEmpty) {
                            return null;
                          } else {
                            return '¿Cuál es tu telefono?';
                          }
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8),
        child: ButtonLoading(
          title: 'Actualizar',
          function: () async {
            if (_formKey.currentState!.validate()) {
              String? urlPhoto = widget.user.photo;
              if (image != null) {
                urlPhoto = await UploadFile.uploadPicture(
                    image!, widget.user.email, _ctrlName.text);
              }
              User tmp = User(
                  photo: urlPhoto,
                  reference: widget.user.reference,
                  name: _ctrlName.text,
                  email: widget.user.email,
                  phone: _ctrlPhone.text,
                  refCources: widget.user.refCources,
                  refsCourcesSeen: widget.user.refsCourcesSeen);
              await User.updateUser(tmp);
              appState.currentUser = tmp;
              Fluttertoast.showToast(msg: 'Datos actualizados');
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            }
          },
        ),
      ),
    );
  }
}
