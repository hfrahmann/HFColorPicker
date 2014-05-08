HFColorPicker
=============

A simple colorpicker for iOS.

![Screenshot](https://raw.github.com/hfrahmann/HFColorPicker/master/screenshot.png)


How to use
----------

In the InterfaceBuilder or Storyboard you just add a normal view element to your view and set the class to "HFColorPickerView".
Then just connect the delegate to your ViewController.

Now you have import the *HFColorPickerView.h* in your ViewController and add the delegate.

```
//...
#import "HFColorPickerView.h"

@interface DemoTableViewController : UITableViewController <HFColorPickerViewDelegate>
//...
```

There is only one delegate method that needs to be implemented.

```
- (void)colorPicker:(HFColorPickerView *)colorPickerView selectedColor:(UIColor *)selectedColor;
```


License
-------

This project is licensed under the MIT-License.