using Toybox.System;
using Toybox.Timer;


class GPSTrackView extends TimeTrackerView {
    hidden const SCREEN_USE_PERCENT = 0.7;

    hidden var accelData;
    hidden var timer;

    function initialize(accelData) {
        TimeTrackerView.initialize();

        self.accelData = accelData;
        timer = new Timer.Timer();
    }

    function onLayout(dc) {
        setLayout(createTimeLabels(dc));
    }

    function onShow() {
        timer.start(method(:reDraw), 2000, true);
    }

    function reDraw() {
        WatchUi.requestUpdate();
    }

    function onUpdate(dc) {
        View.onUpdate(dc);

        updateTimeLabels();

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

            var y1 = scaleY(point, points, height, height_offset);
            var x1 = scaleX(point, points, width, width_offset);
            var y2 = scaleY(previous, points, height, height_offset);
            var x2 = scaleX(previous, points, width, width_offset);

            dc.drawLine(x1, y1, x2, y2);

            previous = point;
        }

        var y1 = scaleY(previous, points, height, height_offset);
        var x1 = scaleX(previous, points, width, width_offset);
        dc.fillCircle(x1, y1, 4);
    }

    function onHide() {
        timer.stop();
    }

    function scaleX(point, points, width, offset) {
        return (point[1] - points.lng_min) / (points.lng_max - points.lng_min) * width + offset;
    }

    function scaleY(point, points, height, offset) {
        return height - (point[0] - points.lat_min) / (points.lat_max - points.lat_min) * height + offset;
    }
}