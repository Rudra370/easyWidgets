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
          <td><a href="#responsive" >Responsive</a></td>
          <td>Every easy widgets are responsive in nature. Other nums can be responsive by using <b>'.hWise'</b> or <b>'.wWise'</b> extension.</td>
        </tr>
        <tr>
          <td><a href="simplified-widgets" >Simplified Widgets</a></td>
          <td>Simplified widgets to configure faster and easier like <b>EasyContainer</b>, <b>EasyScrollList</b>, and more.</td>
        </tr>
        <tr>
          <td><a href="#multiple-pushpushnamed" >Multiple push/pushNamed</a></td>
          <td>Can push multiple pages at once with <b>animation</b>, commonly used for <b>deep linking</b> or <b>app linking</b>.</td>
        </tr>
        <tr>
          <td><a href="#page-transition" >Page transitions</a></td>
          <td>Easy <b>page transitions</b> with multiple animations.</td>
        </tr>
        <tr>
          <td><a href="#easy-mixin" >Easy Mixin support</a></td>
          <td>Gives you access to multiple common used functions simplified, like showing <b>loading indicator</b> while future, <b>snackbars</b>, <b>dialog</b> and more.</td>
        </tr>
        <tr>
          <td><a href="#easy-extensions" >Easy extensions</a></td>
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

All you need is a single import:

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
      designHeight: 720, // design height(optional)
      designWidth: 360, // design width(optional)
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

<br>

## Simplified Widgets

There are few simplified widgets to configure faster and easier like.
There documentation are provided for each widget to help you understand how to use it.

Widgets avaiable:

- `EasyContainer()` // can be used as button, add splash effect, animations and much more
- `EasyScrollList()` // Easily create list, with pagination, optional scroll, separator and much more.
- `EasyGesture()` // Easily handle complex getures like swipe.
- `EasyInkTap()` // Handle ink tap, add ripple effect easily.
- `EasyPadding()` // Easy customizable padding to your widget.

<br>

## Multiple push/pushNamed

You can push multiple pages at once with animation, commonly used for deep linking or app linking.

```dart
import 'package:easy_widget/easy_widget.dart';
/*
.
rest of the code
.
*/
void pushMultiplePages(){
  context.pushAll(
    [Page1(), Page2(), Page3()],
    transitionType: EasyTransitionType.rightToLeft, // define the transition type/animation
  );
}
```

To push multiple named routes at once, you can use `pushNamed` method.
Also, you need to return `EasyPageTransition` in your generateRoute funcnction

For example:

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Easy Widgets exaple',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: "Multiple pushNamed",
      ),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/first':
            return EasyPageTransition(
              child: Scaffold(
                appBar: AppBar(
                  title: Text('First'),
                ),
              ),
              type: EasyTransitionType.bottomToTop,
              settings: settings,
            );
          case '/second':
            return EasyPageTransition(
              child: Scaffold(
                appBar: AppBar(
                  title: Text('Second'),
                ),
              ),
              type: EasyTransitionType.bottomToTop,
              settings: settings,
            );
          default:
            return EasyPageTransition(
              child: Scaffold(
                appBar: AppBar(
                  title: Text('404'),
                ),
                body: Text('Route not Found').alignC,
              ),
              type: EasyTransitionType.bottomToTop,
              settings: settings,
            );;
        }
      },
    );
  }
}
```

Now you can simple use `.pushNamedAll` function on context to push multiple named routes at once. <b> Make sure the length of the arguments list is equal to the routeNames length or don't pass arguments at all.</b>

```dart
void pushNamedAll(){
  context
        .pushNamedAll(routeNames: ['/first', '/second'], arguments: [{}, {}]);
}
```

<br>

## Page transition

Handle page transition animations easily with `EasyPageTransition` class.

For Eaxmple:

```dart
context.push(
  HomePage(),
  transitionType: EasyTransitionType.rightToLeft, // define the transition type/animation
);
```

Avaiable transition types:

- `EasyTransitionType.topToBottom`
- `EasyTransitionType.bottomToTop`
- `EasyTransitionType.leftToRight`
- `EasyTransitionType.rightToLeft`
- `EasyTransitionType.scale`
- `EasyTransitionType.rotate`
- `EasyTransitionType.size`
- `EasyTransitionType.rightToLeftWithFade`
- `EasyTransitionType.leftToRightWithFade`
- `EasyTransitionType.leftToRightJoined`
- `EasyTransitionType.rightToLeftJoined`

<br>

## Easy Mixin

As soon as the statefull Widget implements easy mixin, it starts managaing the responsiveness of the app, then you don't need to manually initialize the EasyWidget for responsiveness.

Inspite of this, it gives you access to multiple functions and getters to make your code shorter, cleaner and easier.

<table>
    <thead>
        <tr>
            <th>Features</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
          <td>screenW</td>
          <td>returns screen width</td>
        </tr>
        <tr>
          <td>screenH</td>
          <td>returns screen height</td>
        </tr>
        <tr>
          <td>orientation</td>
          <td>returns screen orientation</td>
        </tr>
        <tr>
          <td>kHeight</td>
          <td>returns keyboard height</td>
        </tr>
        <tr>
          <td>kVisible</td>
          <td>check if keyboard is visible on the screen</td>
        </tr>
        <tr>
          <td>pop()</td>
          <td>pop function</td>
        </tr>
        <tr>
          <td>back</td>
          <td>pop getter</td>
        </tr>
        <tr>
          <td>push, 
          <br>pushReplacement, 
          <br>pushAndRemoveUntil, 
          <br>pushNamed, 
          <br>pushReplacementNamed, 
          <br>popAndPushNamed</td>
          <td>push functions</td>
        </tr>
        <tr>
          <td>navigator</td>
          <td>returns context navigator</td>
        </tr>
        <tr>
          <td>theme</td>
          <td>returns context theme</td>
        </tr>
        <tr>
          <td>easySnackBar()</td>
          <td>easy customizable snackbar</td>
        </tr>
        <tr>
          <td>easyLoader</td>
          <td>loader on the screen, can be used while future is getting executed</td>
        </tr>
        <tr>
          <td>easyRestrictedLoader</td>
          <td>Loader but it can't be closed with back button(Android, Web)</td>
        </tr>
        <tr>
          <td>easyColorLoader()</td>
          <td>Loader with more customization</td>
        </tr>
        <tr>
          <td>easyDialog()</td>
          <td>create dialog faster and cleaner</td>
        </tr>
        <tr>
          <td>easyFuture< z>()</td>
          <td>Handle futures, error and loading easily, explained in detailed below</td>
        </tr>
    </tbody>
</table>
<br>

### easyFuture

Hanlde the future with and with clean code.
With this you can:

- Handle the future with a callback
- Handle the error
- Default snackbars for error
- Handle the loading while executing future
- return type in case of error

<br>

## Easy Extensions

Several extensions are available to make your code easier and cleaner.

Avaiable extensions works on:

- `num`
- `BuildContext`
- `Object`
- `Widget`
- `String`
- `List`
- `List<String>`
- `List<num>`
