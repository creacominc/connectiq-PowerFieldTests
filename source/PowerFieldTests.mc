
// confirm the value in the heart rate field.
function confirmHeartRateIs(view, value)
{
    var mHeart            = view.getHeart();
    Toybox.Test.assertEqualMessage(mHeart, value, "mHeart (" + mHeart + ") is expected to be " + value);
    return true;
}

// confirm the value in a given power field.
function confirmPowerFieldIs(view, fieldIndex, value)
{
    switch(fieldIndex)
    {
        case 0:
            var mPower3s          = view.getPower3s();
            Toybox.Test.assertEqualMessage(mPower3s, value, "mPower3s (" + mPower3s + ") is expected to be " + value);
            break;
        case 1:
            var mPower30s         = view.getPower30s();
            Toybox.Test.assertEqualMessage(mPower30s, value, "mPower30s (" + mPower30s + ") is expected to be " + value);
            break;
        case 2:
            var mPower120s        = view.getPower120s();
            Toybox.Test.assertEqualMessage(mPower120s, value, "mPower120s (" + mPower120s + ") is expected to be " + value);
            break;
        case 3:
            var mPower300s        = view.getPower300s();
            Toybox.Test.assertEqualMessage(mPower300s, value, "mPower300s (" + mPower300s + ") is expected to be " + value);
            break;
        case 4:
            var mPower1200s       = view.getPower1200s();
            Toybox.Test.assertEqualMessage(mPower1200s, value, "mPower1200s (" + mPower1200s + ") is expected to be " + value);
            break;
        case 5:
            var mPower3600s       = view.getPower3600s();
            Toybox.Test.assertEqualMessage(mPower3600s, value, "mPower3600s (" + mPower3600s + ") is expected to be " + value);
            break;
        case 6:
            var mPower7200s       = view.getPower7200s();
            Toybox.Test.assertEqualMessage(mPower7200s, value, "mPower7200s (" + mPower7200s + ") is expected to be " + value);
            break;
        case 7:
            var mPeak3s           = view.getPeak3s();
            Toybox.Test.assertEqualMessage(mPeak3s, value, "mPeak3s (" + mPeak3s + ") is expected to be " + value);
            break;
        case 8:
            var mPeak30s          = view.getPeak30s();
            Toybox.Test.assertEqualMessage(mPeak30s, value, "mPeak30s (" + mPeak30s + ") is expected to be " + value);
            break;
        case 9:
            var mPeak120s         = view.getPeak120s();
            Toybox.Test.assertEqualMessage(mPeak120s, value, "mPeak120s (" + mPeak120s + ") is expected to be " + value);
            break;
        case 10:
            var mPeak300s         = view.getPeak300s();
            Toybox.Test.assertEqualMessage(mPeak300s, value, "mPeak300s (" + mPeak300s + ") is expected to be " + value);
            break;
        case 11:
            var mPeak1200s        = view.getPeak1200s();
            Toybox.Test.assertEqualMessage(mPeak1200s, value, "mPeak1200s (" + mPeak1200s + ") is expected to be " + value);
            break;
        case 12:
            var mPeak3600s        = view.getPeak3600s();
            Toybox.Test.assertEqualMessage(mPeak3600s, value, "mPeak3600s (" + mPeak3600s + ") is expected to be " + value);
            break;
        case 13:
            var mPeak7200s        = view.getPeak7200s();
            Toybox.Test.assertEqualMessage(mPeak7200s, value, "mPeak7200s (" + mPeak7200s + ") is expected to be " + value);
            break;
        default:
            Toybox.Test.assertMessage(false, "Invalid power index: " + fieldIndex);
    }
    return true;
}

// confirm all power fields are zero.
function confirmAllPowerFieldsAreZero(view)
{
    for(var indx=0; indx < 14; indx++)
    {
        confirmPowerFieldIs(view, indx, 0.0);
    }
    return true;
}

// confirm all fields are zero.  This can be called by multiple tests
function confirmAllFieldsAreZero(view)
{
    confirmHeartRateIs(view, 0.0);
    confirmAllPowerFieldsAreZero(view);
    return true;
}

// return the sum of values from the given value for the number of steps
function expectedAverage(value, step, steps)
{
    var rval = 0;
    var minimum = (value - steps);
    if(minimum < 1)
    {
            minimum = 0;
        }
    while( value > minimum )
    {
        rval += value;
        value--;
    }
    return rval / ((step<steps) ? step : steps);
}


(:test)  // all values should be zero on initialization.
function initialValuesAreZero(logger)
{
    var view = new PowerFieldViewMock();
    return confirmAllFieldsAreZero(view);
}


class ActivityInfoMockNoFields
{
    //var currentHeartRate = 0;
    //var currentPower = 0;
}

(:test) // all values should be zero if the activity info does not provide heart rate or power even if the timer is running.
function computeDoesNothingIfNoInfo(logger)
{
    var activityInfoMockNoFields = new ActivityInfoMockNoFields();
    var view = new PowerFieldViewMock();
    view.onTimerStart(); //! mark the timer as started.
    view.compute(activityInfoMockNoFields);
    return confirmAllFieldsAreZero(view);
}


class ActivityInfoMockWithFields
{
    var currentHeartRate = 0;
    var currentPower = 0;
}

(:test)  // all values should be zero if the timer has not started.
function computeDoesNothingIfNoTimer(logger)
{
    var activityInfoMockWithFields = new ActivityInfoMockWithFields();
    var view = new PowerFieldViewMock();
    view.compute(activityInfoMockWithFields);
    return confirmAllFieldsAreZero(view);
}



class ActivityInfoMockHeartDataOnly
{
    var currentHeartRate = 0;
    //var currentPower = 0;
}

(:test)  // heart rate should provide data if the timer is running.
function computeHeartRateOnly(logger)
{
    var rcode = true;
    var activityInfoMockHeartDataOnly = new ActivityInfoMockHeartDataOnly();
    var view = new PowerFieldViewMock();
    // test once before the timer starts
    view.compute(activityInfoMockHeartDataOnly);
    rcode = rcode && confirmAllFieldsAreZero(view);
    // start the timer
    view.onTimerStart(); //! mark the timer as started.
    // test again and you should get a heart rate.
    activityInfoMockHeartDataOnly.currentHeartRate = 142.0;
    view.compute(activityInfoMockHeartDataOnly);
    rcode = rcode && confirmHeartRateIs(view, 142.0)  && confirmAllPowerFieldsAreZero(view);
    return rcode;
}


class ActivityInfoMockWithData
{
    var currentHeartRate = 0;
    var currentPower = 0;
}

(:test)  // confirm caculation of power averages and peaks.
function computePowerAveragesAndPeaks(logger)
{
    var rcode = true;
    var activityInfoMockWithData = new ActivityInfoMockWithData();
    var view = new PowerFieldViewMock();
    // test once before the timer starts
    view.compute(activityInfoMockWithData);
    rcode = rcode && confirmAllFieldsAreZero(view);
    // start the timer
    view.onTimerStart(); //! mark the timer as started.
    var sumOfPowers = 0.0;
    // The timers go up to 2 hours and count each second so we should send 60*60*2 updates.
    for(var step=1; step <= 60*60*2; step++)
    {
        activityInfoMockWithData.currentHeartRate = 121.0;
        activityInfoMockWithData.currentPower = step;
        view.compute(activityInfoMockWithData);
        confirmHeartRateIs(view, activityInfoMockWithData.currentHeartRate);
        // confirm 3 second average
        confirmPowerFieldIs(view, 0, expectedAverage(step, step, 3));
        confirmPowerFieldIs(view, 1, expectedAverage(step, step, 30));
        //confirmPowerFieldIs(view, 2, expectedAverage(step, step, 120));
        //confirmPowerFieldIs(view, 3, expectedAverage(step, step, 300));
        //confirmPowerFieldIs(view, 4, expectedAverage(step, step, 1200));
        //confirmPowerFieldIs(view, 5, expectedAverage(step, step, 3600));
        confirmPowerFieldIs(view, 6, expectedAverage(step, step, 7200));
        confirmPowerFieldIs(view, 7, expectedAverage(step, step, 3));
        confirmPowerFieldIs(view, 8, expectedAverage(step, step, 30));
        confirmPowerFieldIs(view, 9, expectedAverage(step, step, 120));
        confirmPowerFieldIs(view, 10, expectedAverage(step, step, 300));
        confirmPowerFieldIs(view, 11, expectedAverage(step, step, 1200));
        confirmPowerFieldIs(view, 12, expectedAverage(step, step, 3600));
        confirmPowerFieldIs(view, 13, expectedAverage(step, step, 7200));
    }
    return rcode;
}


