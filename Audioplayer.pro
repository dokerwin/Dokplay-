QT += quick multimedia
QT += core
CONFIG += c++17
QT += quickcontrols2
# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0


SOURCES += \
        appcore.cpp \
        datatracks.cpp \
        loader.cpp \
        main.cpp \
        metadata.cpp \
        playlist.cpp

RESOURCES += qml.qrc \
    Files.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
qml.files += $$files(*.qml)
qml.path = "."
INSTALLS += qml
# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =



LIBS += -L$$PWD/lib -ltag
INCLUDEPATH += $$PWD/include
DEPENDPATH += $$PWD/include




# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target



HEADERS += \
    appcore.h \
    datatracks.h \
    loader.h \
    metadata.h \
    playlist.h \
    playlistplgn.h

DISTFILES += \
    Buttons/Next_btn.qml \
    Buttons/Play_btn.qml \
    Buttons/Prev_btn.qml

