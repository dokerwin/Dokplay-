import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import QtQuick.Dialogs 1.3
import QtWebView 1.1
import QtMultimedia 5.0
import "Buttons/" as MyButton

Window {
    visible: true
    width: 780
    height: 480
    title: qsTr("Audio drive")
    // Remove title bar
       flags: Qt.Window
    property string sliderTitle
    property real dur

    property real sliderMin
    property real sliderMax
    property real sliderVal

       function formatSeconds(s) {
           let minutes = ~~(s / 60);
           let seconds = ~~(s % 60);
           return  minutes + ':' + seconds;
         }


    Connections {
        target: appCore
        onSendLabelToQml:{

            track_lbl.text = track


        }
        onControlLevelChanged:{

            console.log("in slader signal" + controlLevel.value);
            volume_lbl.text = "Volume: "+ volume

        }

        onDurationChanged:{




            durtion.value = duration;

            console.log(duration);

            durtion_lbl.text = formatSeconds(duration);

        }

        onSetDurationSignal:{
              console.log(duration_+ "ne tam");
         dur = duration_;
        }


        onAllTracksToQml:{

            label_alltracks.text = "All tracks: "+  allTracks


        }

    }



    Image {
        width: 126; height: 104
        anchors.centerIn: parent
        fillMode: Image.PreserveAspectCrop

        source: "file:///C:/Users/z.kulbachenko/Documents/Audioplayer-main/build-Audioplayer-Desktop_x86_windows_msvc2019_pe_32bit-Debug/image/icon.png"
        anchors.verticalCenterOffset: 4
        anchors.horizontalCenterOffset: -84

    }





    MyButton.Stop_btn{

    }




    Label {

        id: track_lbl
        x: 221
        y: 11
        text: qsTr("Label")
    }


    

    Slider {
        id: controlLevel
        x: 0
        y: 106
        width: 251
        height: 20

        from: 0; to: 100; stepSize: 1
        value: to * 2

        onValueChanged:{appCore.setControlLevel(controlLevel.value)

        console.log("in slader" + value);
        }
        ToolTip {
            parent: controlLevel.handle
            visible: controlLevel.pressed
            text: controlLevel.value.toFixed(1)
        }



    }
    Slider {


        id:durtion
        x: 57
        y: 425
        width: 662
        height: 10

        from: 0; to:dur;

        onMoved:  {

        appCore.setDuration(value)


        }

    }




/*

 Duration{

     id: durtion
     x: 0
     y: 435
     width: 775
     height: 10

 }
*/










    Label {
        id: volume_lbl
        x: 17
        y: 451
        text: qsTr("Volume: ")
    }








    Label {
        id: label_alltracks
        x: 662
        y: 454
        width: 61
        height: 10
        text: qsTr("All tracks: ")
    }








    Test{
        x: 387
        y: 33
        width: 381
        height: 386
    }

    Label {
        id: volume_lbl1
        x: 494
        y: 11
        text: qsTr("Tracks")
    }




    Setting_button{



        x: 0
        y: 0



    }

    Label {
        id: durtion_lbl
        x: 0
        y: 422
        width: 59
        height: 16
    }

    MyButton.Play_btn {
        x: 110
        y: 220
    }

    MyButton.Next_btn {
        x: 163
        y: 220
    }

    MyButton.Prev_btn {
        x: 50
        y: 220
    }

    Button {
        id: stop_btn
        x: 109
        y: 280
        width: 48
        height: 49
        background: Rectangle {
            color: button_1.pressed ?  "#50bc2c":"#66D41E"
            radius: 25
            border.color: button_1.pressed ? "#66D41E" :"#50bc2c"
            border.width: 2
            Text {
                id: textw
                color: button_1.pressed ? "#5E5252" : "white"
                text: "Stop"
                font.pixelSize: 15
                font.bold: true
                anchors.centerIn: parent
            }
        }
        onClicked: appCore.stop()
    }

    Button {
        id: button_1
        x: 110
        y: 159
        width: 49
        height: 49
        background: Rectangle {
            color: button_1.pressed ?  "#50bc2c":"#66D41E"
            radius: 25
            border.color: button_1.pressed ? "#66D41E" :"#50bc2c"
            border.width: 2
            Text {
                id: texts
                color: button_1.pressed ? "#5E5252" : "white"
                text: "R"
                font.pixelSize: 15
                font.bold: true
                anchors.centerIn: parent
            }
        }
        onClicked: appCore.randomTrack()
    }

    Label {
        id: all_durtion_lbl
        x: 729
        y: 422
        width: 46
        height: 16
    }




}





