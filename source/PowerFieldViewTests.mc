using Toybox.System;
using Toybox.Math;



(:test)  // all values should be zero on initialization.
function initialValuesAreZero(logger)
{
    var view = new PowerFieldViewMock();
    return confirmAllFieldsAreZero(view, logger);
}


(:test) // all values should be zero if the activity info does not provide heart rate or power even if the timer is running.
function computeDoesNothingIfNoInfo(logger)
{
    var activityInfoMockNoFields = new ActivityInfoMockNoFields();
    var view = new PowerFieldViewMock();
    view.onTimerStart(); //! mark the timer as started.
    view.compute(activityInfoMockNoFields);
    return confirmAllFieldsAreZero(view, logger);
}



(:test)  // all values should be zero if the timer has not started.
function computeDoesNothingIfNoTimer(logger)
{
    var activityInfoMockWithData = new ActivityInfoMockWithData();
    var view = new PowerFieldViewMock();
    view.compute(activityInfoMockWithData);
    return confirmAllFieldsAreZero(view, logger);
}



(:test)  // heart rate should provide data if the timer is running.
function computeHeartRateOnly(logger)
{
    var rcode = true;
    var activityInfoMockHeartDataOnly = new ActivityInfoMockHeartDataOnly();
    var view = new PowerFieldViewMock();
    // test once before the timer starts
    view.compute(activityInfoMockHeartDataOnly);
    rcode = rcode && confirmAllFieldsAreZero(view, logger);
    // start the timer
    view.onTimerStart(); //! mark the timer as started.
    // test again and you should get a heart rate.
    activityInfoMockHeartDataOnly.currentHeartRate = 142.0;
    view.compute(activityInfoMockHeartDataOnly);
    rcode = rcode && confirmHeartRateIs(view, 142.0)  && confirmAllPowerFieldsAreZero(view, logger);
    return rcode;
}


