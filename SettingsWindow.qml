import QtQuick 2.15
import QtQuick.Window 2.15

Window{
    id: settingsWindow
    visible:true;
    height:600;
    width:600;
    maximumWidth:600
    maximumHeight:600
    minimumWidth:600
    minimumHeight:600
    flags: Qt.FramelessWindowHint |  Qt.WA_TranslucentBackground
    title:"Carousel Settings"
    color:"transparent"
    Connections{
        target:PreviewWindow
        function onXChanged(x: real){
            settingsWindow.x = x - 275
        }
        function onYChanged(y: real){
            settingsWindow.y = y - 6
        }
    }

    Rectangle{
        id:settingsBackground
        anchors {
            left:parent.left
            top:parent.top
            leftMargin:6
        }
        width:428
        height:400

        border.width: 8
        radius:4
        color:"lightblue"
    }
    Rectangle{
        id:previewCase
        height:332
        width:332
        radius:width
        border.width:8
        anchors{
            horizontalCenter: settingsBackground.right
            top:settingsBackground.top
        }
    }
}
