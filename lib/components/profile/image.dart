import 'dart:io';

import 'package:children_now/utils/crop.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SelectImage extends StatelessWidget {
  final String? urlImage;
  final String? tagHero;
  final File? photo;
  final Function function;
  const SelectImage({
    Key? key,
    required this.photo,
    required this.function,
    required this.urlImage,
    required this.tagHero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return (urlImage == null && photo == null)
        ? InkWell(
            onTap: () async {
              function(await Crop.pickImage(ImageSource.gallery));
            },
            child: Container(
              width: size.width,
              height: size.width / 2,
              decoration: const BoxDecoration(color: Colors.black87),
              child: const Center(
                child: Icon(
                  Icons.camera,
                  color: Colors.white,
                  size: 60,
                ),
              ),
            ),
          )
        : Stack(
            children: [
              if (photo == null) ...[
                Hero(
                    tag: tagHero!,
                    child: Image.network(
                      urlImage!,
                      width: size.width,
                      height: size.width,
                      fit: BoxFit.cover,
                    ))
              ] else ...[
                Image.file(
                  photo!,
                  width: size.width,
                  height: size.width,
                  fit: BoxFit.cover,
                )
              ],
              Positioned(
                  bottom: 0,
                  child: Container(
                      height: size.width / 6,
                      width: size.width,
                      decoration: const BoxDecoration(color: Colors.black45),
                      child: Row(
                        children: [
                          Expanded(
                              child: IconButton(
                                  onPressed: () async {
                                    function(await Crop.pickImage(
                                        ImageSource.camera));
                                  },
                                  icon: const Icon(
                                    Icons.camera,
                                    color: Colors.white,
                                    size: 30,
                                  ))),
                          Expanded(
                              child: IconButton(
                                  onPressed: () async {
                                    function(await Crop.pickImage(
                                        ImageSource.gallery));
                                  },
                                  icon: const Icon(
                                    Icons.photo_library,
                                    color: Colors.white,
                                    size: 30,
                                  ))),
                          if (photo != null) ...[
                            Expanded(
                                child: IconButton(
                                    onPressed: () async {
                                      function(await Crop.cropImage(photo!));
                                    },
                                    icon: Icon(
                                      Icons.crop,
                                      color: Colors.amber[700],
                                      size: 30,
                                    ))),
                            Expanded(
                                child: IconButton(
                                    onPressed: () {
                                      function(null);
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.redAccent,
                                      size: 30,
                                    )))
                          ]
                        ],
                      )))
            ],
          );
  }
}