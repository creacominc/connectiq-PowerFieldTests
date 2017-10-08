/**
 * ActivityInfoMockNoFields is the base class representing system when no data is available.
 */
class ActivityInfoMockNoFields
{
}

/**
 * ActivityInfoMockHeartDataOnly represents the system with only heart rate data available.
 */
class ActivityInfoMockHeartDataOnly  extends ActivityInfoMockNoFields
{
    function initialize()
    {
        ActivityInfoMockNoFields.initialize();
    }
    var currentHeartRate = 0;
    var averageHeartRate = 0;
    var maxHeartRate = 0;
}

/**
 * ActivityInfoMockWithData represents the system with all data items available.
 */
class ActivityInfoMockWithData extends ActivityInfoMockNoFields
{
    function initialize()
    {
        ActivityInfoMockNoFields.initialize();
    }
    var currentHeartRate = 0;
    var averageHeartRate = 0;
    var maxHeartRate = 0;
    var currentPower = 0;
    var averagePower = 0;
    var maxPower = 0;
}
