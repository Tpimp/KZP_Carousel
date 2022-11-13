# KZP_Carousel
Qml App that runs inside Kraken Z Playground, allowing users to build custom carousels

This app uses the settings.json found in it appdir.
Currently it cycles between an app (randomly) and then an image (randomly). Eventually this will use a C++ schedular for now here is an example
### Example
```json
{
    "gifs": [
        "file:///PATH_TO_IMAGE/elon.gif"
    ],
    "apps": [
        "file:///PATH_TO_QML/main.qml"
    ]
}
```
