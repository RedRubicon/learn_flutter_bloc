void main() async {
  // Initialise the stream
  var stream = countStream(10);

  // Consume the stream
  var total = await sumStream(stream);

  // ignore: avoid_print
  print(total);
}

Stream<int> countStream(int max) async* {
  for (int i = 0; i < max; i++) {
    yield i;
  }
}

Future<int> sumStream(Stream stream) async {
  int sum = 0;
  await for (int value in stream) {
    sum += value;
  }
  return sum;
}
