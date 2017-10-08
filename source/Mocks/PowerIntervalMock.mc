// mock wrapper for PowerInterval class

class PowerIntervalMock extends PowerInterval
{


    function initialize(properties, index, greenAt)
    {
        var app = Application.getApp();
        app.setProperties(properties);
        PowerInterval.initialize(index, greenAt);
    }




}
