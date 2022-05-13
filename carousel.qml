import QtQuick 2.15
import QtGraphicalEffects 1.15
import QtQuick.Window 2.15
Rectangle{
    id:carousel
    anchors.fill:parent
    color:"transparent"
    property bool settings: true
    property alias appSource:currentApp.source
    property int index: 0
    property var gifs:[]
    property var apps:[]
    Connections{
        target:PreviewWindow
        function onSettingsToggled(open: bool) {
            if(open && !PreviewWindow.detached) {
                PreviewWindow.detachPreview(true);
            }
            if(settingsWindow.item) {
                // ask the window to save
                //var data = settingsWindow.item.getData();
                //console.log(data);
                settingsWindow.active = false;
            } else {
                settingsWindow.active = open;
            }

        }
        function onDetachChanged( detach: bool) {
            if(!detach) {
                settingsWindow.active = false;
            }
        }
    }

    Loader{
        id: settingsWindow
        active:false
        anchors.fill: parent
        sourceComponent:SettingsWindow{
            x: PreviewWindow.x - 275
            y: PreviewWindow.y - 6
        }
    }

    Rectangle{
        id:appContainer
        color:"black"
        anchors.centerIn:parent
        width:320
        height:320
        visible:true
        Loader{
            id: currentApp
            anchors.fill:parent
            active:true
            onStatusChanged:{
                if(status == Loader.Ready) {
                    AppController.scheduleRedraw();
                    animatedImage.source = ""
                    image.source = ""
                    AppController.setTimerDrawn(true);
                }
            }
        }
    }

    AnimatedImage{
        id: animatedImage
        smooth: true
        visible: animatedImage.source != ""
        cache: false
        source:""
        fillMode: Image.PreserveAspectCrop
        playing:true
        anchors.centerIn: parent
        width:320
        height:320
        onFrameChanged: {
            AppController.scheduleRedraw();
        }
    }
    Image{
        id: image
        smooth: true
        visible: image.source != ""
        cache: false
        fillMode: Image.PreserveAspectFit
        anchors.centerIn: parent
        width:320
        height:320
    }
    Timer{
        id:playTimer
        interval:5000
        repeat:true
        running: true
        onTriggered:{
            switch(carousel.index){
                case 0: {
                    playTimer.interval = 5300;
                    currentApp.source = carousel.apps[Math.floor(Math.random() * carousel.apps.length)];
                    break;
                }
                default: {
                    carousel.index = -1;
                    AppController.setTimerDrawn(false);
                    playTimer.interval = 10000;
                    var index = Math.floor(Math.random() * carousel.gifs.length);
                    var path = carousel.gifs[index];
                    animatedImage.source = path;
                    image.source = "";
                    currentApp.source = "";
                }
            }
            ++carousel.index;
        }
    }

    Component.onCompleted: {
        var settings = AppController.loadAppSettings();
        carousel.gifs = settings.gifs;
        carousel.apps = settings.apps;
        animatedImage.source = carousel.gifs[Math.floor(Math.random() * carousel.gifs.length)]
    }
}
