

class GPSPointArray
{
    hidden var SIZE = 400;
    hidden var points = new [SIZE];
    hidden var count = 0;

    var lat_max = -90;
    var lat_min = 90;
    var lng_max = -190;
    var lng_min = 180;

    /* Better algorithm,
     * 1. Merge from last merge end to the current end using the sample rate
     * 2. If there are still too many points,
     *    a. Downsample the existing array by 2x
     *    b. Increase the same rate for (1) by 2x
     */

    function add(point) {
        // This is wrong, overweights the new points in the array...
        if (count == SIZE) {
            for (var i = 2; i < SIZE; i += 2) {
                points[i / 2] = averagePoints(points[i], points[i + 1]);
            }
            count = SIZE / 2;
        }

        points[count] = point;
        count += 1;

        if (point[0] > lat_max) {
            lat_max = point[0];
        }
        if (point[0] < lat_min) {
            lat_min = point[0];
        }
        if (point[1] > lng_max) {
            lng_max = point[1];
        }
        if (point[1] < lng_min) {
            lng_min = point[1];
        }
    }

    function get(i) {
        return points[i];
    }

    function getCount() {
        return count;
    }

    function averagePoints(point1, point2) {
        return [
            (point1[0] + point2[0]) / 2,
            (point1[1] + point2[1]) / 2
        ];
    }
}