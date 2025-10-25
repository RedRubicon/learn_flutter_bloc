void main() {
  // Initialise the stream
  var stream = countStream(10);
}

Stream<int> countStream(int max) async* {
  for (int i = 0; i < max; i++) {
    yield i;
  }
}
