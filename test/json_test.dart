import 'package:flutter_test/flutter_test.dart';
import 'package:restirint/model/local_restaurant.dart';

var testItemRestaurant = {
  "id": "s1knt6za9kkfw1e867",
  "name": "Kafe Kita",
  "description":
      "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. ...",
  "pictureId": "25",
  "city": "Gorontalo",
  "rating": 4
};
void main() {
  test("Test Parsing", () async {
    var result = LocalRestaurant.fromJson(testItemRestaurant).id;

    expect(result, "s1knt6za9kkfw1e867");
  });
}
