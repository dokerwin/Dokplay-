
import QtQuick 2.0

Rectangle {
    width: 150; height: 230; color: "white"

    signal sendMessage(int compId)

    function formatSeconds(s) {
        let minutes = ~~(s / 60);
        let seconds = ~~(s % 60);
        return minutes + ':' + seconds;
      }

    Connections {
        target: appCore

    }


    Component {

        id: nameDelegate



        Text {
           property ListView __lv: ListView.view

            width: parent.width
            font.family: "Yu Gothic UI Semilight"


            text: model.name +"\n Duration: "+formatSeconds(model.duration/1000)

            font.pixelSize: 16

            MouseArea {
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                onDoubleClicked: {

                   sendMessage(model.duration/1000);
                   all_durtion_lbl.text= formatSeconds(model.duration/1000)
                   appCore.play_track(model.name)
                }
                anchors.fill: parent
                onClicked: __lv.currentIndex = model.index
            }
        }
    }
    //--> slide
    ListView {
        id: listView
        //--> hide
        width: parent.width
        anchors.top: parent.top
        anchors.bottom: label.top
        anchors.bottomMargin: 4

        model: _myModel
        delegate: nameDelegate
        focus: true
        clip: true

        header: Rectangle {
            anchors { left: parent.left; right: parent.right }
            height: 10
            color: "lightgreen"
        }
        footer: Rectangle {
            anchors { left: parent.left; right: parent.right }
            height: 10
            color: "darkgreen"
        }
        highlight: Rectangle {
            id: high
            height: 10
            anchors { left: parent.left; right: parent.right }
            color: "lightgray"
        }//<-- hide
    }

    Text {
        id: label
        y: 211
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        font.family: "Yu Gothic UI Semilight"

        font.pixelSize: 16
        anchors.horizontalCenterOffset: -113
        anchors.bottomMargin: 0
    }
    //<-- slide
}
