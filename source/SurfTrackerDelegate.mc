using Toybox.WatchUi;
using Toybox.Time;
using Toybox.System;
using Toybox.Timer;
using Toybox.Attention;


class SurfTrackerDelegate extends WatchUi.InputDelegate {
    hidden const DOUBLE_PRESS_THRESHOLD = 400;
    hidden const TRIPLE_PRESS_THRESHOLD = 2 * DOUBLE_PRESS_THRESHOLD;

    hidden var accelData;

    hidden var penultimateKeyPressMillis;
    hidden var lastKeyPressMillis;
    hidden var keyPressStart;
    hidden var buttonTimer;

    hidden var page;

    function initialize(accelData) {
        WatchUi.InputDelegate.initialize();

        self.accelData = accelData;
        accelData.start();

        buttonTimer = new Timer.Timer();
        lastKeyPressMillis = System.getTimer() - DOUBLE_PRESS_THRESHOLD;
        penultimateKeyPressMillis = System.getTimer() - TRIPLE_PRESS_THRESHOLD;
        page = 0;
    }

    /* Disable all screen touch events */
    function onHold(clickEvent) {
        return true;
    }

    function onRelease(clickEvent) {
        return true;
    }

    function onSelectable(selectableEvent){
        return true;
    }

    function onSwipe(swipeEvent) {
        return true;
    }

    function onTap(clickEvent){
        return true;
    }

    /*
     * Lap => Mark wave
     * Enter single press => Switch page
     * Enter double press => Pause / end
     */
    function onKey(keyEvent) {
        if (keyEvent.getKey() == KEY_ENTER) {
            var now = System.getTimer();
            if (now - lastKeyPressMillis < DOUBLE_PRESS_THRESHOLD) {
                buttonTimer.stop();
                WatchUi.switchToView(new PausedView(), new PausedDelegate(accelData), WatchUi.SLIDE_LEFT);
            } else  {
                penultimateKeyPressMillis = lastKeyPressMillis;
                buttonTimer.stop();
                buttonTimer.start(method(:changePage), DOUBLE_PRESS_THRESHOLD + 5, false);
            }
            lastKeyPressMillis = now;
            return true;
        } else if (keyEvent.getKey() == KEY_ESC) {
            markWave();
            return true;
        }

        return false;
    }

    function markWave() {
        accelData.addWave();
        Attention.vibrate([new Attention.VibeProfile(100, 1000)]);
        WatchUi.requestUpdate();
    }

    function changePage() {
        page = (page + 1) % 2;
        if (page == 0) {
            WatchUi.switchToView(new SurfTrackerView(accelData), self, WatchUi.SLIDE_DOWN);
        } else if (page == 1) {
            WatchUi.switchToView(new GPSTrackView(accelData), self, WatchUi.SLIDE_DOWN);
        } else {
            // wtfbbq?
        }
    }
}
