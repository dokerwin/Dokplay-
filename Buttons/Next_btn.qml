
import QtQuick 2.0

Item {

    id: butto
    width: 47
    height: 47
    property alias text: innerText.text
    signal clicked


    Image {

        id: backgroundImage
        anchors.fill: parent

        source: "qrc:/image/next.png"
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
    }




    Text {
        id: innerText
        anchors.centerIn: parent
        color: "white"
        font.bold: true
    }

    //Mouse area to react on click events
    MouseArea {
        anchors.fill: butto
        acceptedButtons: Qt.LeftButton

        onClicked: appCore.nextTrack()
    }


}
