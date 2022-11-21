import 'dart:io';

import 'package:flutter/material.dart';

import '../../core/utils/debounce.dart';

class CustomImage extends StatefulWidget{
  const CustomImage({
    Key? key,
    required this.source,
    this.onError,
    this.onSuccess,
    this.onReload
  }) : super(key: key);

  final String source;
  final VoidCallback? onError;
  final VoidCallback? onSuccess;
  final VoidCallback? onReload;

  @override
  State<StatefulWidget> createState() => _CustomImage();

}

class _CustomImage extends State<CustomImage>{
  int attempts = 0;

  Widget _loadingHandler(BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
    if (loadingProgress == null) {
      if(widget.onSuccess != null) widget.onSuccess!();
      return child;
    }
    return Center(
      child: CircularProgressIndicator(
        value: loadingProgress.expectedTotalBytes != null
            ? loadingProgress.cumulativeBytesLoaded /
            loadingProgress.expectedTotalBytes!
            : null,
        color: Colors.red,
        strokeWidth: 3.5,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    dynamic i;
    if(widget.source.contains('http')){
      i = NetworkImage(widget.source + "?reload_n_time= $attempts}");
    }else{
      i = FileImage(File.fromUri(Uri(path: widget.source)));
    }

    return Image(
      image: i,
      fit: BoxFit.contain,
      alignment: Alignment.center,
      loadingBuilder: _loadingHandler,
      errorBuilder: _errorHandler,
    );
  }

  Widget _errorHandler(BuildContext context, Object error, StackTrace? stackTrace) {
    if(widget.onError != null) widget.onError!();
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: (){
          Debounce.instance.runBefore(
            action: (){
              if(widget.onReload != null) widget.onReload!();
              setState((){
                attempts++;
              });
            },
            rate: 200
          );
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: const Center(
              child: Icon(Icons.refresh)
          )
        )
      ),
    );
  }
}