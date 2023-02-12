import 'package:flutter/material.dart';

void customAlertMessage(BuildContext context, String title, String message,
        List<Widget> actions) =>
    {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
              title: Text(title),
              content: Text(message),
              actions: actions,
              actionsAlignment: MainAxisAlignment.end))
    };
