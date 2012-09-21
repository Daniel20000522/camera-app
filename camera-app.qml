import QtQuick 1.1

Rectangle {
    id: main
    width: 400
    height: 600
    color: "black"

    Camera {
        id: camera
        anchors.fill: parent

        MouseArea {
            anchors.fill: parent
            onClicked: {
                toolbar.opacity = 1.0;
                ring.x = mouse.x - ring.width * 0.5;
                ring.y = mouse.y - ring.height * 0.5;
                ring.opacity = 1.0;
                // TODO: call the spot focusing API here
            }
        }

        FocusRing {
            id: ring
            opacity: 0.0
            onClicked: camera.takeSnapshot()
        }

        onIsRecordingChanged: if (isRecording) ring.opacity = 0.0
        onSnapshotSuccess: {
            console.log("snapshot successfully taken"); // TODO: load snapshot and slide it off screen to the right
            ring.opacity = 0.0
            toolbar.opacity = 0.0
        }
    }

    Toolbar {
        id: toolbar
        anchors.fill: parent
        camera: camera
        opacity: 0.0
    }
}
