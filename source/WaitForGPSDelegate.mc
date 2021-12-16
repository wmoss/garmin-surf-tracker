using Toybox.WatchUi;


class WaitForGPSDelegate extends WatchUi.InputDelegate {
    hidden var accelData;

    function initialize(accelData) {
        InputDelegate.initialize();
        self.accelData = accelData;
    }

    function onKey(keyEvent) {
        if (keyEvent.getKey() == KEY_ENTER) {
            WatchUi.switchToView(
                new SurfTrackerView(accelData),
                new SurfTrackerDelegate(accelData),
                WatchUi.SLIDE_LEFT
            );
            return true;
        } else if (keyEvent.getKey() == KEY_ESC) {
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        }
        return false;
    }
}
