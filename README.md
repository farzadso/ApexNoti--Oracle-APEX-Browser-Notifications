# ApexNoti Dynamic Action Plugin
A simple dynamic action plugin based on browsers' Notification API

##Demo
[ApexNoti Dynamic Action Demo - Click Here](https://apex.oracle.com/pls/apex/f?p=9468:2)

##Installation
Just import the 
```html
dynamic_action_plugin_com_jafr_apexnoti.sql
```
file into your application.

What this plugin does is that it includes custom code for getting the notification to popup. 
The plugin is of “Dynamic Action” type, that means you have to call it via some sort of dynamic action triggering event. 

## Usage

Error Type (Optional):
```html
There are two options, Alert and Console. This setting checks whether or not your browser is compatible with notifications. If it is then nothing will happen. In the case of your browser not being compatible with notification, by choosing “Alert” you will receive a simple Javascript alert that says your browser isn’t compatible and by selecting “Console” this message gets printed in the browser console.
```


Title (Required):
```html
The title option sets the title of the notification as it is clear by its name.
```

Icon (Optional):
```html
The icon option display an icon (image) in the notification itself. I have included a default image in the plugin itself so that it doesn’t look empty if you don’t set anything in the icon field. You can set a link to any image you desire. You can also choose an image uploaded in your application’s Static Application Files.
```

Body (Required):
```html
This option sets the message of the notification itself.
```

Link (Optional):
```html
Using this option which is optional, you can set a link for when the user clicks on the notification itself. The link is opened in a new tab in the browser so that it doesn’t interrupt the user’s current page. Be sure to include the protocol in your link (http://……. or https://…..).
```

Timeout (Optional):
```html
This text field accepts values with a unit of milliseconds. For instance, if you enter 3000 as the value for this option, the produced notification gets dismissed in 3 seconds.
```


## Author

[Farzad Soltani](https://github.com/farzadso)
