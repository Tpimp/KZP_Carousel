import QtQuick 2.15
import QtQuick.Window 2.15
import QtGraphicalEffects 1.15
Rectangle{
    id: settingBackground
    visible:true;
    height:600;
    width:600;
    color:"transparent"
    property alias previewContainer: previewCase
    property int windowXOffset:-275
    property int windowYOffset:-6
    Rectangle{
        id:listContainer
        color: "#e60f0f0f"
        anchors {
            left:parent.left
            top:settingsBackground.bottom
            leftMargin:8
            bottomMargin:16
            topMargin:-1
        }
        width:400
        height:0
        border.width: 0
        radius:4

        Image{
            id:gridBackground
            fillMode: Image.PreserveAspectCrop
            source:"metal_grate.png"
            anchors.fill: listContainer
            anchors.margins: 1
            anchors.bottomMargin: 4
            anchors.topMargin: 2
        }
    }


    Rectangle{
        id:settingsBackground
        anchors {
            right:parent.right
            top:parent.top
            topMargin: 4
            rightMargin:164
        }
        width:160
        height:48
        color: "#d78718"
        border.width: 4
        radius:4
    }

    ListView{
        anchors.fill: listContainer
        model:200
        spacing:0
        clip:true
        anchors.leftMargin: 1
        anchors.topMargin: 1
        anchors.bottomMargin: 5
        delegate:Item{
            height: 42
            width:gridBackground.width
            Rectangle{
                height:34
                width:parent.width
                border.width: 1
                border.color: "white"
                anchors.top:parent.top
                anchors.topMargin: 4
                radius:4
                color: "#80ffffff"
                Text{
                    id:indexText
                    anchors{
                        top:parent.top
                        left:parent.left
                        bottom:parent.bottom
                        margins:2
                        leftMargin:4
                    }
                    width:40
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignRight
                    rightPadding:2
                    text:index + 1
                    styleColor: "#494949"
                    font.letterSpacing: 1
                    font.pixelSize: parent.height*.54
                    style: Text.Sunken
                    font.bold: true
                }
                Rectangle{
                    id:chainStrip
                    color:"black"
                    height:42
                    width:4
                    anchors.top:parent.top
                    anchors.topMargin: -4
                    anchors.horizontalCenter: typeDiamond.horizontalCenter
                }
                Rectangle{
                    id:typeDiamond
                    anchors{
                        left:indexText.right
                        leftMargin: 6
                        verticalCenter: parent.verticalCenter
                    }
                    color:"black"
                    height:24
                    width:24
                    rotation:45
                    radius:1
                    Rectangle{
                        anchors.fill: parent
                        anchors.margins: 4
                        radius:2
                        color:"#31ca55"
                        border.color: "#363636"
                        border.width: 1
                    }
                }
            }
        }
    }
    Rectangle{
        anchors.fill: previewCase
        anchors.margins: -6
        radius:previewCase.radius
        border.width:8
        color:"white"
    }

    Rectangle{
        id:previewCase
        height:240
        width:height
        radius:height
        anchors{
            horizontalCenter: settingsBackground.right
            horizontalCenterOffset: 12
            top:settingsBackground.top
            topMargin:36
        }
    }
    Rectangle{
        color:"#b3000000"
        height:64
        width:64
        radius:64
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.rightMargin: 74
        anchors.topMargin: -2
        Rectangle{
            id:xLabelRect
            color:"#70000000"
            radius:8
            width:0
            height:32
            clip:true
            anchors{
                left:xIcon.right
                verticalCenter: xIcon.verticalCenter
                leftMargin:-8
            }
            Text{
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.fill: parent
                leftPadding:2
                font.bold: true
                font.pixelSize: 16
                font.letterSpacing: 2
                color:"white"
                text:"Close"
                style:Text.Sunken
            }
        }
        ParallelAnimation{
            id:openXLabel
            NumberAnimation{
                target:xLabelRect
                properties: "width"
                duration:180
                from:0
                to: 72
            }
            NumberAnimation{
                target:xIcon
                properties: "rotation"
                duration:200
                from:0
                to:360
            }
        }
        ParallelAnimation{
            id:closeXLabel
            running:false
            alwaysRunToEnd: true
            NumberAnimation{
                target:xLabelRect
                properties: "width"
                duration:180
                from:72
                to: 0
            }
            NumberAnimation{
                target:xIcon
                properties: "rotation"
                duration:200
                to:0
                from:360
            }
        }
        Image{
            id:xIcon
            source:"x.png"
            anchors.fill: parent
            anchors.margins: 2
        }


        MouseArea{
            anchors.fill: parent
            onClicked:{
                Preview.showSettings(false);
            }
            hoverEnabled:true
            onEntered:{
                closeXLabel.stop();
                openXLabel.start();
            }
            onExited: {
                openXLabel.stop();
                closeXLabel.start();
            }
        }
    }
    SequentialAnimation{
        id:openWindow
        running:true

        alwaysRunToEnd: true
        NumberAnimation {
            target:settingsBackground
            property:"width"
            duration:220
            alwaysRunToEnd: true
        }
        SpringAnimation {
            id:openContainerAnimation
            target:listContainer
            duration:440
            spring:3
            damping:.1
            property: "height"
            from:0
            to:320
        }

    }

    Image{
        id: icon
        height:64
        fillMode: Image.PreserveAspectFit
        source:"carousel_icon.svg"
        anchors{
            left:settingsBackground.left
            leftMargin:-6
            top: settingsBackground.top
            topMargin:-4
        }
    }
    Text{
        text:"Carousel Settings"
        font.pixelSize: 24
        font.bold: true
        anchors{
            left:icon.right
            leftMargin:18
            top:parent.top
            topMargin:12
        }
    }
    Component.onCompleted: {
        settingsBackground.width = 434;
    }
}
