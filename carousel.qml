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
    Loader{
        id: currentApp
        anchors.fill:parent
        active:true
        visible:active
        anchors.centerIn:parent
        width:320
        height:320
    }
    Timer{
        id:setAppTimer
        interval:3
        repeat:false
        running:false
        onTriggered:{
            animatedImage.playing = false;
            animatedImage.source = ""
            image.source = ""
            playTimer.restart();
        }
    }

    AnimatedImage{
        id: animatedImage
        visible: animatedImage.source != ""
        cache: false
        source:""
        fillMode: Image.PreserveAspectCrop
        playing:true
        x:0
        y:0
        width:320
        height:320
        onCurrentFrameChanged: {
            if((this.frameCount >= 35) && (this.currentFrame >= this.frameCount-1) ) {
                playTimer.interval = 100;
                playTimer.restart();
            }
        }
    }
    Image{
        id: image
        visible: image.source != ""
        cache: false
        fillMode: Image.PreserveAspectCrop
        anchors.centerIn: parent
        width:320
        height:320
        onStatusChanged: {
//            if(status == Image.Ready){
//                AppController.scheduleRedraw();
//            }
        }
    }
    Timer{
        id:playTimer
        interval:5500
        repeat:true
        running: true
        onTriggered:{
            switch(carousel.index){
                case 0: {
                    setNextApp();
                    break;
                }
                default: {
                    setNextGif();
                }
            }
        }
    }

    function setNextGif() {
        currentApp.active = false;
        carousel.index = 0;
        playTimer.interval = 12500;
        var index = Math.floor(Math.random() * carousel.gifs.length);
        var path = carousel.gifs[index];
        animatedImage.source = path;
        animatedImage.playing = true;
        image.source = "";
        AppController.frameDelay = 90;

    }
    function setNextApp() {
        if(carousel.gifs.length > 0) {
            ++carousel.index;
        }
        playTimer.stop();
        currentApp.source = carousel.apps[Math.floor(Math.random() * carousel.apps.length)];
        currentApp.active = true;
        playTimer.interval = 6000;
        setAppTimer.start()
        AppController.frameDelay = 185;
    }

    Component.onCompleted: {
        var settings = AppController.loadAppSettings();
        carousel.gifs = settings.gifs;
        carousel.apps = settings.apps;
        if(carousel.gifs.length > 0 ) {
            setNextGif();
        } else if (carousel.apps.length > 0){
            setNextApp();
        }
    }
}
