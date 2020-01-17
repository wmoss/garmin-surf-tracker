using Toybox.WatchUi;
using Toybox.Time;
using Toybox.System;

class SurfTrackerDelegate extends WatchUi.BehaviorDelegate {
    hidden var lastKeyPressMillis = 0;
    hidden var accelData;

    function initialize(accelData) {
        BehaviorDelegate.initialize();
        self.accelData = accelData;
    }

    function onMenu() {
        return true;
    }

    function onPreviousPage() {
        return true;
    }

    function onNextPage() {
        return true;
    }

    function onPreviousMode() {
        return true;
    }

    function onBack() {
        return true;
    }

    function onNextMode() {
        return true;
    }

    function onSelect() {
        return true;
    }

    function onKey(keyEvent) {
        if (keyEvent.getKey() == KEY_ENTER) {
            var now = System.getTimer();
            if (now - lastKeyPressMillis < 500) {
                WatchUi.pushView(new PausedView(), new PausedDelegate(accelData), WatchUi.SLIDE_LEFT);
            }
            lastKeyPressMillis = now;
        }
         return true;
    }
}
