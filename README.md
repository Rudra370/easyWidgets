# easy_widgets 🤖

Simplified and quick access to most used **widget** with easy access to **extenstions** and **functions/helpers** which are **responsive** in nature.

<br>
<table>
    <thead>
        <tr>
            <th>Features</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
          <td><a href="#Responsive" >Responsive</a></td>
          <td>Every easy widgets are responsive in nature. Other nums can be responsive by using <b>'.hWise'</b> or <b>'.wWise'</b> extension.</td>
        </tr>
        <tr>
          <td><a href="#" >Simplified Widgets</a></td>
          <td>Simplified widgets to configure faster and easier like <b>EasyContainer</b>, <b>EasyScrollList</b>, and more.</td>
        </tr>
        <tr>
          <td><a href="#" >Multiple push/pushNamed</a></td>
          <td>Can push multiple pages at once with <b>animation</b>, commonly used for <b>deep linking</b> or <b>app linking</b>.</td>
        </tr>
        <tr>
          <td><a href="#" >Page transitions</a></td>
          <td>Easy <b>page transitions</b> with multiple animations.</td>
        </tr>
        <tr>
          <td><a href="#" >Easy Mixin support</a></td>
          <td>Gives you access to multiple common used functions simplified, like showing <b>loading indicator</b> while future, <b>snackbars</b>, <b>dialog</b> and more.</td>
        </tr>
        <tr>
          <td><a href="#" >Easy extensions</a></td>
          <td>Multiple extensions to make code faster, these extensions helps in responsiveness. The extensions works on <b>list</b>, <b>context</b>, <b>nums</b>, <b>Widgets</b> and more</td>
        </tr>
    </tbody>
</table>
<br>

## Installation

```
flutter pub add easy_widgets
```

or

```
dependencies:
  easy_widgets: ^0.0.4
```

## Import

All you need is a signle import:

```dart
import 'package:easy_widget/easy_widget.dart';
```

## Initialize(MUST!)

For the responsive functionality, you need to initialize the easy widget first.
<br>
There are two ways to initialize the easy widget.

<br>
1. If your app is never going to change its dimensions(like in Android or Ios), then you can initialize the easy widget in the main.dart file inside build function of your app like this.
<br>
<br>

```dart
EasyWidget.initiate(context);
```

```dart
import 'package:easy_widget/easy_widget.dart';
/*
.
rest of the code
.
*/
@override
  Widget build(BuildContext context) {
EasyWidget.initiate(context(
      context,
      designHeight: 720, // Put your design dimension heiight here, this is optional
      designWidth: 360, // Put your design dimension width here, this is optional
    ); // Must initialize the easy widget here.

return YOURWIDGET(
  /*
  .
  your code
  .
  */
    );
  }
```

<br>
2. If your app is going to change its dimensions(like in web), then you should initialize the easy widget with the help of easy mixin.

<br>
<br>

Use EasyMixin with your page stateful class and it will automatically initialize the easy widget.

```dart
with EasyMixin
```

```dart
import 'package:easy_widget/easy_widget.dart';
/*
.
rest of the code
.
*/
class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with EasyMixin { // Must extend the State class with EasyMixin
/*
.
rest of the code
.
*/
}
```

However if you're willing to pass the design dimensions, you can pass them in init like this:

```dart
@override
  void initState() {
    setDesignDimension(360, 720);// put your design width and height here
    super.initState();
  }
```

<br>

## Responsive

Every easy widget is responsive in nature. Other nums can be responsive by using `'.hWise'` or `'.wWise'` extension.

For example:

```dart
Container(
  height: 200.hWise, // height will be adjusted accrding to the height of the screen,
  width: 200.wWise, // width will be adjusted according to the width of the screen,
);
```

You can use the same with Texts, Buttons, Padding, etc.

For example:

```dart
Text(
  'Lorem ispum',
  style: TextStyle(
    fontSize: 14.hWise, // Text will be adjusted according to the height of the screen,
  ),
);
```
