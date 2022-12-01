A simple autocomplete widget for Flutter that shows suggestion with a delay.

## Features

- Delay for showing suggestions
- Easy to customize design
- Easy to use apis

<!--
## Demo

![open street map search and pick](https://user-images.githubusercontent.com/69592754/179368498-fe392cdb-c321-46e8-ac4d-6b816e0a3758.png)
-->

<!-- ## Help Maintenance

I've been maintaining quite many repos these days and burning out slowly. If you could help me cheer up, buying me a cup of coffee will make my life really happy and get much energy out of it.

<a href="https://www.buymeacoffee.com/RtrHv1C" target="_blank"><img src="https://www.buymeacoffee.com/assets/img/custom_images/purple_img.png" alt="Buy Me A Coffee" style="height: auto !important;width: auto !important;" ></a> -->


## Getting Started

Import the following package in your dart file

```dart
import 'package:delayed_autocomplete/delayed_autocomplete.dart';
```

## Then Usage

    DeyaledAutocomplete(
        itemWidget: (dynamic object) {
          String name = object as String;
          return Container(
            height: 50,
            child: Center(
              child: Text(name),
            ),
          );
        },
        toDo: (String suggestion) {
          List<String> suggestions = [
            "Apple",
            "Banana",
            "Orange",
            "Pineapple",
            "Mango"
          ];
          List<String> finallist = [];
          for (String s in suggestions) {
            if (s.toLowerCase().contains(suggestion.toLowerCase())) {
              finallist.add(s);
            }
          }
          return finallist;
        },
      )

<!--
# Video Tutorial

Click on the image below to view a video tutorial. It will redirect you to a youtube video.

- Video 1

[![Click here to view the tutorial](https://img.youtube.com/vi/VHDlC8wC9FI/0.jpg)](https://www.youtube.com/watch?v=VHDlC8wC9FI)

- Video 2

[![Click here to view the tutorial](https://img.youtube.com/vi/kZRrH3UlxeU/0.jpg)](https://www.youtube.com/watch?v=kZRrH3UlxeU)
-->
