// confirm all fields are zero.  This can be called by multiple tests
function confirmAllFieldsAreZero(view)
{
    var mHeart            = view.getHeart();
    Toybox.Test.assertEqualMessage(mHeart, 0.0, "mHeart is expected to be zero");
    var mPower3s          = view.getPower3s();
    Toybox.Test.assertEqualMessage(mPower3s, 0.0, "mPower3s is expected to be zero");
    var mPower30s         = view.getPower30s();
    Toybox.Test.assertEqualMessage(mPower30s, 0.0, "mPower30s is expected to be zero");
    var mPower120s        = view.getPower120s();
    Toybox.Test.assertEqualMessage(mPower120s, 0.0, "mPower120s is expected to be zero");
    var mPower300s        = view.getPower300s();
    Toybox.Test.assertEqualMessage(mPower300s, 0.0, "mPower300s is expected to be zero");
    var mPower1200s       = view.getPower1200s();
    Toybox.Test.assertEqualMessage(mPower1200s, 0.0, "mPower1200s is expected to be zero");
    var mPower3600s       = view.getPower3600s();
    Toybox.Test.assertEqualMessage(mPower3600s, 0.0, "mPower3600s is expected to be zero");
    var mPower7200s       = view.getPower7200s();
    Toybox.Test.assertEqualMessage(mPower7200s, 0.0, "mPower7200s is expected to be zero");
    var mPeak3s           = view.getPeak3s();
    Toybox.Test.assertEqualMessage(mPeak3s, 0.0, "mPeak3s is expected to be zero");
    var mPeak30s          = view.getPeak30s();
    Toybox.Test.assertEqualMessage(mPeak30s, 0.0, "mPeak30s is expected to be zero");
    var mPeak120s         = view.getPeak120s();
    Toybox.Test.assertEqualMessage(mPeak120s, 0.0, "mPeak120s is expected to be zero");
    var mPeak300s         = view.getPeak300s();
    Toybox.Test.assertEqualMessage(mPeak300s, 0.0, "mPeak300s is expected to be zero");
    var mPeak1200s        = view.getPeak1200s();
    Toybox.Test.assertEqualMessage(mPeak1200s, 0.0, "mPeak1200s is expected to be zero");
    var mPeak3600s        = view.getPeak3600s();
    Toybox.Test.assertEqualMessage(mPeak3600s, 0.0, "mPeak3600s is expected to be zero");
    var mPeak7200s        = view.getPeak7200s();
    Toybox.Test.assertEqualMessage(mPeak7200s, 0.0, "mPeak7200s is expected to be zero");
    return true;
}

(:test)
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

(:test)
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

(:test)
function computeDoesNothingIfNoTimer(logger)
{
    var activityInfoMockWithFields = new ActivityInfoMockWithFields();
    var view = new PowerFieldViewMock();
    view.compute(activityInfoMockWithFields);
    return confirmAllFieldsAreZero(view);
}



class ActivityInfoMockHeartDataOnly
{
    var currentHeartRate = 132;
    //var currentPower = 0;
}

(:test)
function computeHeartRateOnly(logger)
{
    var activityInfoMockHeartDataOnly = new ActivityInfoMockHeartDataOnly();
    var view = new PowerFieldViewMock();
    view.compute(activityInfoMockHeartDataOnly);
    return confirmAllFieldsAreZero(view);
}


