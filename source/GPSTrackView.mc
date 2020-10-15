using Toybox.WatchUi;
using Toybox.System;
using Toybox.Timer;


class GPSTrackView extends WatchUi.View {
    hidden const SCREEN_USE_PERCENT = 0.7;

    hidden var accelData;
    hidden var timer;

    function initialize(accelData) {
        View.initialize();

        self.accelData = accelData;
        timer = new Timer.Timer();
    }

    function onLayout(dc) {
    }

    function onShow() {
        timer.start(method(:reDraw), 2000, true);
    }

    function reDraw() {
        WatchUi.requestUpdate();
    }

    function onUpdate(dc) {
        View.onUpdate(dc);

        var points = accelData.getPoints();
        if (points.getCount() <= 1) { return; }

        var width = SCREEN_USE_PERCENT * dc.getWidth();
        var height = SCREEN_USE_PERCENT * dc.getHeight();
        var width_offset = dc.getWidth() * (1 - SCREEN_USE_PERCENT) / 2;
        var height_offset = dc.getHeight() * (1 - SCREEN_USE_PERCENT) / 2;


        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);

        var previous = points.get(0);
        for (var i = 1; i < points.getCount(); i++) {
            var point = points.get(i);

            var y1 = (point[0] - points.lat_min) / (points.lat_max - points.lat_min) * width + width_offset;
            var x1 = (point[1] - points.lng_min) / (points.lng_max - points.lng_min) * height + height_offset;
            var y2 = (previous[0] - points.lat_min) / (points.lat_max - points.lat_min) * width + width_offset;
            var x2 = (previous[1] - points.lng_min) / (points.lng_max - points.lng_min) * height + height_offset;

            dc.drawLine(x1, y1, x2, y2);

            previous = point;
        }

        var y1 = (previous[0] - points.lat_min) / (points.lat_max - points.lat_min) * width + width_offset;
        var x1 = (previous[1] - points.lng_min) / (points.lng_max - points.lng_min) * height + height_offset;
        dc.fillCircle(x1, y1, 4);
    }

    function onHide() {
        timer.stop();
    }

}