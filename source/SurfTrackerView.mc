using Toybox.WatchUi;
using Toybox.Timer;


class SurfTrackerView extends TimeTrackerView  {
    hidden var accelData;
    hidden var wavesLabel;
    hidden var timer;

    function initialize(accelData) {
        TimeTrackerView.initialize();
        self.accelData = accelData;

        timer = new Timer.Timer();
    }

    function onLayout(dc) {
        var surferBitmap = new WatchUi.Bitmap({
            :rezId => Rez.Drawables.Surfer,
            :locX => WatchUi.LAYOUT_HALIGN_CENTER,
            :locY => WatchUi.LAYOUT_VALIGN_CENTER,
        });

        wavesLabel = new WatchUi.Text({
            :color => Graphics.COLOR_WHITE,
            :font => Graphics.FONT_NUMBER_HOT,
            :locX => dc.getWidth() * 0.1,
            :locY => WatchUi.LAYOUT_VALIGN_CENTER,
            :justification => Graphics.TEXT_JUSTIFY_LEFT,
        });

        setLayout([surferBitmap, wavesLabel].addAll(createTimeLabels(dc)));
    }

    function onShow() {
        timer.start(method(:requestUpdate), 2000, true);
    }

    function requestUpdate() {
        WatchUi.requestUpdate();
    }

    function onUpdate(dc) {
        View.onUpdate(dc);

        updateTimeLabels();

        wavesLabel.setText(accelData.getWaveCount().format("%d"));

        dc.setColor(getGPSAccuracyColor(accelData.getAccuracy()), Graphics.COLOR_BLACK);
        dc.fillCircle(dc.getWidth() - 12, dc.getHeight() / 2, 10);
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
    }

    function onHide() {
        timer.stop();
    }

    function getGPSAccuracyColor(accuracy) {
        switch (accuracy) {
            case Position.QUALITY_GOOD:
              return Graphics.COLOR_DK_GREEN;
            case Position.QUALITY_USABLE:
              return Graphics.COLOR_YELLOW;
            default:
              return Graphics.COLOR_DK_RED;
        }
    }
}
