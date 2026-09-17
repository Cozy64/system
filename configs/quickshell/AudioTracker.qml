import QtQuick
import Quickshell.Services.Pipewire

Item {
    id: root

    signal changed(string type, real level, string icon)

    readonly property bool sinkMuted: Pipewire.defaultAudioSink?.audio?.muted ?? false
    readonly property real sinkVolume: Pipewire.defaultAudioSink?.audio?.volume ?? 0

    readonly property bool sourceMuted: Pipewire.defaultAudioSource?.audio?.muted ?? false
    readonly property real sourceVolume: Pipewire.defaultAudioSource?.audio?.volume ?? 0

    PwObjectTracker {
        objects: [ Pipewire.defaultAudioSink, Pipewire.defaultAudioSource ]
    }

    function volumeIcon(): string {
        if (root.sinkMuted || root.sinkVolume === 0) return "audio-volume-muted-symbolic";
        if (root.sinkVolume < 0.5) return "audio-volume-low-symbolic";
        return "audio-volume-high-symbolic";
    }

    function micIcon(): string {
        return root.sourceMuted
            ? "microphone-sensitivity-muted-symbolic"
            : "microphone-sensitivity-high-symbolic";
    }

    Connections {
        target: Pipewire.defaultAudioSink?.audio
        function onVolumeChanged() {
            const level = root.sinkMuted ? 0 : Math.min(1.0, root.sinkVolume);
            root.changed("volume", level, root.volumeIcon());
        }
        function onMutedChanged() {
            const level = root.sinkMuted ? 0 : Math.min(1.0, root.sinkVolume);
            root.changed("volume", level, root.volumeIcon());
        }
    }

    Connections {
        target: Pipewire.defaultAudioSource?.audio
        function onVolumeChanged() {
            const level = root.sourceMuted ? 0 : Math.min(1.0, root.sourceVolume);
            root.changed("mic", level, root.micIcon());
        }
        function onMutedChanged() {
            const level = root.sourceMuted ? 0 : Math.min(1.0, root.sourceVolume);
            root.changed("mic", level, root.micIcon());
        }
    }
}
