import QtQuick 2.0

Rectangle {
    id: rec

    property alias img_src: icon.source
    property alias btn_txt: button.text

    property color clr_enter: "#dcdcdc"
    property color clr_exit: "#ffffff"
    property color clr_click: "#aba9b2"
    property color clr_release: "#ffffff"

    // Пользовательский сигнал клика
    signal clickedLeft()
    signal clickedRight()
    signal release()

    width: 130
    height: 130
    radius: 10

    Image {
        id: icon
        width: 80
        height: 80
        source: "qrc:/camera.png"
        fillMode: Image.PreserveAspectFit
        clip: true
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.margins: 10
    }

    Text {
        id: button
        text: qsTr("button")

        anchors.top: icon.bottom
        anchors.topMargin: 5
        anchors.horizontalCenter: icon.horizontalCenter
        anchors.bottom: icon.bottom
        anchors.bottomMargin: 5

        font.bold: true
        font.pointSize: 14
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true

        // Принимаем ввод с левой и правой клавиш
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: {
            //Щелчок левой кнопкой мыши
            if (mouse.button === Qt.LeftButton)
            {
                parent.clickedLeft()
//                console.log(button.text + " Left button click")
            }
            else if(mouse.button === Qt.RightButton)
            {
                parent.clickedRight()
//                console.log(button.text + " Right button click")
            }
        }

        //Нажмите
        onPressed: {
            color = clr_click
        }

        // освобожден
        onReleased: {
            color = clr_enter
            parent.release()
            console.log("Release")
        }

        // Указатель ввода
        onEntered: {
            color = clr_enter
//            console.log(button.text + " mouse entered")
        }

        // Указатель выхода
        onExited: {
            color = clr_exit
//            console.log(button.text + " mouse exited")
        }
    }
}
