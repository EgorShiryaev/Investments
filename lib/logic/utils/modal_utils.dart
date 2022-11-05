import 'dart:async';

import 'package:flutter/material.dart';

void showModal(BuildContext context, Widget modal) {
  unawaited(
    showDialog(context: context, builder: (context) => modal),
  );
}
