// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Use the File `openRead()` method to read a file's contents a little at a
/// time using a stream.
///
/// The example below reads the file fragments, decodes them to UTF8, and
/// converts them to individual lines. The `onDone` callback executes when the
/// stream exhausts. The `onError` callback executes when there is an error.

import 'dart:io';
import 'dart:convert';
import 'dart:async';

main() async {
  final file = new File('file.txt');
  Stream<List<int>> inputStream = file.openRead();

  Stream<String> lines = inputStream
    // Decode to UTF8.
    .transform(UTF8.decoder)
    // Convert stream to individual lines.
    .transform(new LineSplitter());

  try {
    await for (String line in lines) print('$line: ${line.length} bytes');
  } catch(e) {
    print(e.toString());
  }

  print('File is now closed.');
}